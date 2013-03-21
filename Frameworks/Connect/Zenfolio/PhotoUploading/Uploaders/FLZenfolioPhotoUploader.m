//
//	FLZenfolioPhotoUploader.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/22/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//
#if REFACTOR

#import "FLZenfolioPhotoUploader.h"

#import "FLCallbackObject.h"
#import "FLZenfolioUploadGallery.h"
#import "FLTempFileMgr.h"

#import "FLZenfolioUploadImageOperation.h"
#import "FLZenfolioPrepareImageForUploadOperation.h"

#if IOS
#import "UIDevice+FLExtras.h"
#import "FLSavePhotoToUsersPhotoAlbumOperation.h"
#import "FLProgressViewController.h"

#endif

@implementation FLZenfolioPhotoUploader

@synthesize photo = _uploadingPhoto;
@synthesize uploadState = _state;
@synthesize uploadSize = _uploadSize;
@synthesize bytesUploaded = _bytesUploaded;
@synthesize imageFile = _imageFile;
@synthesize uploadQueue = _uploadQueue;

- (id) delegate {
	return _delegate.object;
}

- (void) setDelegate:(id<FLZenfolioPhotoUploaderDelegate>) delegate {
	_delegate.object = delegate;
}

FLAssertDefaultInitNotCalled();

- (id) initWithUploadQueue:(FLZenfolioUploadQueue*) uploadQueue {
	if((self = [super init])) {
#if IOS
		[UIApplication sharedApplication].idleTimerDisabled = YES;
#endif
		_delegate = [[FLWeakReference alloc] init];
        _uploadQueue = FLRetain(uploadQueue);
	}
	
	return self;
}

- (void)dealloc  {
#if IOS
	[UIApplication sharedApplication].idleTimerDisabled = NO; // just in case
#endif

    FLRelease(_uploadQueue);
    FLRelease(_imageFile);
    FLRelease(_delegate);
	FLRelease(_uploadingPhoto);
	FLSuperDealloc();
}

- (void) _handleActionCompleteForState:(FLAction*) action {
    if(action.didSucceed) {
        [self changeStateToNextState];
    }
    else {
        [self _didFinishWithError:action.error];
    }
}

- (unsigned long long) calculateInitialUploadSize {
    return 0;
}

- (unsigned long long) bytesUploaded {
    return MIN(_bytesUploaded, _uploadSize);
}

- (void) _updateProgress {
	FLAssertWithComment([NSThread isMainThread], @"updating progress on wrong thread");

	[self.progressController updateProgress:self.bytesUploaded totalAmount:self.uploadSize]; // for the bar
}

- (void) setProgressController:(id<FLProgressViewController>) progress {
    [super setProgressController:progress];
    if(self.uploadSize > 0) {
        [self _updateProgress];
    }
}

- (void) _informDelegateWithError:(NSError*) error {
    [self.delegate photoUploader:self finishedWithError:error];
}

- (void) _didFinishWithError:(NSError*) error {
    [[FLTempFileMgr instance] beginPurgeInBackgroundThread:^{
        [self _informDelegateWithError:error];
        }]; 
}

- (FLAction*) createAction {
	FLAction* action = [super createAction];
	action.actionDescription.actionType = FLActionTypeUpload;
	action.actionDescription.itemNameInProgress = [self.photo displayName];
	action.actionDescription.actionItemName = FLActionDescriptionItemNamePhoto;
	return action;
}

- (void) _didUpdatePhotoMetaData:(FLZenfolioApiSoapUpdatePhoto*) operation {
	if(operation.didSucceed) {
		int photoSetId = self.photo.uploadDestinationIdValue;
		FLZenfolioPhotoSet* photoSet = [[[self.userContext photoSetStorage] loadPhotoSetWithID:photoSetId];
		[photoSet addPhoto:[operation.output UpdatePhotoResult]];
		[photoSet saveInCache];
	}
}

- (void) _beginUploadingMetaData {
    FLReleaseWithNil(_imageFile);

    FLAction* action = [self createAction];
    FLZenfolioPhotoUpdater* updater = [self.photo createUpdater];

    // note that the filename is set in the EXIF data.
    BOOL canSkipUpload = 
        FLStringIsEmpty(updater.Title) &&
        FLStringIsEmpty(updater.Caption) && 
        FLStringIsEmpty(updater.Copyright) && 
        (!updater.Keywords || updater.Keywords.count == 0) &&
        (!updater.Categories || updater.Categories.count == 0);
    
    if(!canSkipUpload) {
        if(self.photo.uploadedAssetId == 0) {
            FLThrowErrorCodeWithComment(FLZenfolioErrorDomain, errUnknownObjectId, @"Photo id is zero");
        }
        
        // upload meta-data (perform update on Photo snapshot)
        FLZenfolioApiSoapUpdatePhoto* uploadPhoto = FLAutorelease([[FLZenfolioApiSoapUpdatePhoto alloc] initWithServerContext:[FLZenfolioApiSoap instance]]);
        [uploadPhoto.input setPhotoId:self.photo.uploadedAssetId]; 
        [uploadPhoto.input setUpdater:updater];
        uploadPhoto.willFinishBlock = ^(id operation) { 
            [self _didUpdatePhotoMetaData:(FLZenfolioApiSoapUpdatePhoto*)operation]; 
            };
                
        [action addOperation:uploadPhoto];    
    }

    [action addOperationWithBlock:^(id operation) {
        [_uploadQueue didUploadAsset:self.photo];
    }];
        
	[self.actionContext startAction:action completion: ^(id<FLAsyncResult> result) {
        [self _handleActionCompleteForState:action]; 
    }];
}

- (FLZenfolioPhotoUploaderState) nextStateForState:(FLZenfolioPhotoUploaderState) state {
    switch(state)
    {
        case FLZenfolioPhotoUploaderStateInit:
            return FLZenfolioPhotoUploaderStateCheckUploadGalleries;
        break;
    
        case FLZenfolioPhotoUploaderStateBeginUpload:
            return FLZenfolioPhotoUploaderStateSaveToDevice;
        break;
        
        case FLZenfolioPhotoUploaderStateCheckUploadGalleries:
            return FLZenfolioPhotoUploaderStateBeginUpload;
        break;
        
        case FLZenfolioPhotoUploaderStateSaveToDevice:
            return FLZenfolioPhotoUploaderStatePrepareImage;
        break;

        case FLZenfolioPhotoUploaderStatePrepareImage:
            return FLZenfolioPhotoUploaderStateUploadBytes;
        break;
        
        case FLZenfolioPhotoUploaderStateUploadBytes:
            return FLZenfolioPhotoUploaderStateUploadMetadata;
        break;
        
        case FLZenfolioPhotoUploaderStateUploadMetadata:
            return FLZenfolioPhotoUploaderStateDone;
        break;
        
        case FLZenfolioPhotoUploaderStateDone:
            return _state;
        break;
    }

    FLAssertFailedWithComment(@"should have returned a new state");
    
    return _state;
}

- (void) requestCancel:(dispatch_block_t) cancelCompletionOrNil {
    [super requestCancel:cancelCompletionOrNil];
	self.delegate = nil;
}

- (void) _handleDoneState {
    [self _didFinishWithError:nil];
}

- (void) _handleInitState {
    _uploadSize  = [self calculateInitialUploadSize];
    _bytesUploaded = 0;
    [self changeStateToNextState];
}

- (void) _handleBeginUploadState {
    [self changeStateToNextState];
}

- (void) _startState {
    switch(_state)
    {
        case FLZenfolioPhotoUploaderStateInit:
            [self _handleInitState];
        break;
        
        case FLZenfolioPhotoUploaderStateBeginUpload:
            [self _handleBeginUploadState];
        break;
        
        case FLZenfolioPhotoUploaderStateSaveToDevice:
            [self _beginSavingPhotoToDevice];
        break;
        
        case FLZenfolioPhotoUploaderStateCheckUploadGalleries:
            [self _beginCheckingUploadGalleries];
        break;
        
        case FLZenfolioPhotoUploaderStatePrepareImage:
            [self _prepareUploadFile];
        break;
        
        case FLZenfolioPhotoUploaderStateUploadBytes:

            if(self.photo.uploadedAssetIdValue == 0)
            {
                [self _beginUploadingBytes];
            }
            else
            {
            // if uploadedAssetIdValue != 0, this means the bytes were uploaded to the server
            // and we have a Photo.Id for snapshot, so upload the metadata now.

                [self changeStateToNextState];
            }
        break;
        
        case FLZenfolioPhotoUploaderStateUploadMetadata:
            [self _beginUploadingMetaData];
        break;
        
        case FLZenfolioPhotoUploaderStateDone:
            [self _handleDoneState];
        break;
    }
}

- (void) changeState:(FLZenfolioPhotoUploaderState) state {
    _state = state;
    [self performSelectorOnMainThread:@selector(_startState) withObject:nil waitUntilDone:YES];
}

- (void) _didUploadBytesNowUpdateCache:(id) operation {
	
    if([operation didSucceed]) {
        self.photo.uploadedAssetIdValue = [[operation operationOutput] unsignedLongValue];
        if(self.photo.uploadedAssetId == 0) {
            FLThrowErrorCodeWithComment(FLZenfolioErrorDomain, errUnknownObjectId, @"Photo id is zero");
        }
		[_uploadQueue saveAsset:self.photo];
	}
}

- (void) _updateProgressWhileUploadingImage:(unsigned long long) amountWritten
    totalAmountWritten:(unsigned long long) totalAmountWritten
    totalAmountExpectedToWrite:(unsigned long long) totalAmountExpectedToWrite {
}

- (void) _beginUploadingBytes {
    FLAssertIsNotNil(self.photo);
    FLAssertIsNotNil(self.imageFile);

    FLAction* action = [self createAction];
    FLZenfolioUploadImageOperation* uploadImage = FLAutorelease([[FLZenfolioUploadImageOperation alloc] initWithUploadablePhoto:self.photo preparedImage:self.imageFile]) ;
    uploadImage.willFinishBlock = ^(id theOperation) {
        [self _didUploadBytesNowUpdateCache:theOperation]; 
    };
    [action addOperation:uploadImage];

    action.onUpdateProgress = ^(id theAction,
                                unsigned long long amountWritten,
                                unsigned long long totalAmountWritten,
                                unsigned long long totalAmountExpectedToWrite){
        [self _updateProgressWhileUploadingImage:amountWritten totalAmountWritten:totalAmountWritten totalAmountExpectedToWrite:totalAmountExpectedToWrite];
        [self _updateProgress];
        };

   [self.actionContext startAction:action completion: ^(id<FLAsyncResult> result) {
        [self _handleActionCompleteForState:action]; 
        }];
}

- (void) _didPrepareUploadFile:(FLAction*) action  {
    if(action.didSucceed)
    {
        FLZenfolioPrepareImageForUploadOperation* preparer = [action lastOperation];
        
        self.imageFile = preparer.preparedImage;
        
        if(preparer.finalFileSize > preparer.startFileSize)
        {
            unsigned long long difference = (preparer.startFileSize - preparer.finalFileSize);
        	_uploadSize -= difference;
            [self _updateProgress];
        }
        
        [self changeStateToNextState];
    }
    else
    {
        [self _didFinishWithError:action.error];
    }
}

- (void) _prepareUploadFile {
    if(!self.imageFile) {

        FLAction* action = [self createAction];
        [action addOperation:FLAutorelease([[FLZenfolioPrepareImageForUploadOperation alloc] initWithUploadablePhoto:self.photo])];
     
        [self.actionContext startAction:action completion: ^(id<FLAsyncResult> result) { 
            [self _didPrepareUploadFile:action]; 
        }];

    }
    else {
        [self changeStateToNextState];
    }   
}

- (void) _beginSavingPhotoToDevice {
    if(	self.photo.saveToDeviceBeforeUploadValue && !self.photo.wasSavedToDeviceBeforeUploadValue)
    {
        FLAction* action = [self createAction];
        [action actionDescription].actionType = FLActionTypeSave;
        [action actionDescription].itemNameInProgress = [self.photo displayName];
        [action actionDescription].actionItemName = FLActionDescriptionItemNamePhoto;
        
#if IOS
        [self.progressController.progressView setTitle:[NSString stringWithFormat:(NSLocalizedString(@"Saving %@ to %@", nil)), self.photo.displayName, [UIDevice currentDevice].deviceDisplayName]];
        
        FLSavePhotoToUsersPhotoAlbumOperation* saver = FLAutorelease([[FLSavePhotoToUsersPhotoAlbumOperation alloc] initWithPhotoInput:self.photo.imageAsset]);
        saver.willFinishBlock = ^(FLOperation* operation) {
            
            if(operation.didSucceed) {
                self.photo.wasSavedToDeviceBeforeUploadValue = YES;
                self.photo.saveToDeviceBeforeUploadValue = NO;
                [_uploadQueue saveAsset:self.photo];
            }
        };

        [action addOperation:saver];
#endif

        [self.actionContext startAction:action completion: ^(id<FLAsyncResult> result) {
            [self _handleActionCompleteForState:action];
            }];
    }
    else
    {
        [self changeStateToNextState];
    }
}

- (void) createProgress:(FLRectLayout) progressLocation
{
#if IOS

    if(self.progressController)
    {
        [self.progressController setTitle:NSLocalizedString(@"Preparing to Upload…", nil)];
#if VIEW_AUTOLAYOUT
        [self.progressController setAutoLayoutMode:progressLocation];
#endif        
        [self.progressController setButtonTitle:NSLocalizedString(@"Cancel", nil)];
        [self.progressController setProgressViewAlpha:0.8f ];
        [self.progressController setButtonTarget:self action:@selector(respondToCancelEvent:) isCancel:YES];
        [self.progressController showProgress];
    }
#endif
}


- (void) changeStateToNextState {
    [self changeState:[self nextStateForState:self.uploadState]];
}

- (void) _doneCheckingPhotoSets:(FLAction*) action {
	if(action.didSucceed) {
        [self changeStateToNextState];
	}
	else if([action error].zenfolioFaultCode == errNoSuchObject) {
        id failedOperation = action.lastOperation;
    
		int photoSetId = [[failedOperation operationInput] photoSetIdValue];	
		
		if(self.photo && 
			self.photo.uploadDestinationIdValue == photoSetId) {
			self.photo.uploadGallery = nil;
		}
		
		if(_uploadQueue) {
        
            if(_uploadQueue.isLoaded)
            {
                for(FLZenfolioQueuedPhoto* asset in _uploadQueue)
                {
                    if(asset.uploadDestinationIdValue == photoSetId)
                    {
                        asset.uploadGallery = nil;
                    }
                }
                
                [_uploadQueue saveQueueToDatabase];
            }
            
            if(self.photo)
            {
                [_uploadQueue saveAsset:self.photo];
            }
		} 
        
        FLZenfolioUploadGallery* defaultUploadGallery = [FLZenfolioUploadGallery defaultUploadGallery];
        if(defaultUploadGallery && defaultUploadGallery.photoSetIdValue == photoSetId)
        {
            [[self.service userStorageService].documentsDatabase deleteObject:defaultUploadGallery];

        }
	
		action.handledError = YES;
        [self _didFinishWithError:[NSError errorWithDomain:FLZenfolioPhotoUploaderErrorDomain 
            code:FLZenfolioPhotoUploaderErrorUploadGalleryWasDeleted 
            userInfo:nil]];
    }
	else
	{
        [self _didFinishWithError:[action error]];
	}
}

- (NSSet*) uploadGalleries {
    return nil;
}

- (void) beginActionInContext:(FLOperationContext*) context {
	[super beginActionInContext:context];
    [self changeState:self.uploadState];
}

- (void) _beginCheckingUploadGalleries {
   
     NSSet* uploadGalleries = [self uploadGalleries];
    if(!uploadGalleries || uploadGalleries.count == 0)
    {
        [self _didFinishWithError:[NSError errorWithDomain:FLZenfolioPhotoUploaderErrorDomain code:FLZenfolioPhotoUploaderErrorMissingUploadGallery userInfo:nil]];
        return;
    }

    FLAction* action = [self createAction];
    
    for(NSNumber* photoSetId in uploadGalleries) {
        [action addOperation:[FLZenfolioWebService loadPhotoSetHttpRequest:photoSetId
                                                    level:FLZenfolioInformatonLevelLevel1
                                            includePhotos:NO]];
    }

    [action actionDescription].actionType = FLActionTypeUpload;
    [action actionDescription].actionItemName = NSLocalizedString(@"Gallery", nil);
	[self.actionContext startAction:action completion: ^(id<FLAsyncResult> result) { 
        [self _doneCheckingPhotoSets:action]; 
        }];
}

+ (NSString*) chooserPromptForError:(NSError*) error
{
	NSString* helpText = nil;
	if([error isDomain:FLZenfolioPhotoUploaderErrorDomain])
	{
		switch(error.code)
		{
			case FLZenfolioPhotoUploaderErrorUploadGalleryWasDeleted:
				helpText = NSLocalizedString(@"Please choose a new destination gallery for upload, the previous destination gallery no longer exists.", nil);
				break;
			case FLZenfolioPhotoUploaderErrorMissingUploadGallery:
				helpText = NSLocalizedString(@"Please choose a destination gallery for upload.", nil);
				break;
		}
	}
	
	return helpText;
}


@end

#endif