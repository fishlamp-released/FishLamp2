//
//	ZFBatchSavePhotosToDevice.m
//	MyZen
//
//	Created by Mike Fullerton on 3/4/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//
#if REFACTOR

#import "ZFBatchSavePhotosToDevice.h"
#if IOS

#import "ZFDownloadImageHttpRequest.h"
#import "FLSavePhotoToUsersPhotoAlbumOperation.h"
#import "FLModalProgressView.h"
#import "UIDevice+FLExtras.h"
#import "FLExportedAsset.h"
#import "FLAlert.h"
#import "FLButtons.h"
#import "FLProgressViewController.h"


@implementation ZFBatchSavePhotosToDevice

- (id) init
{
    if((self = [super init]))
    {
        _downloadSize = kImageDownloadSize;
    }
    
    return self; 
}

- (void) didPrepareBatch
{
	self.progressController = [FLProgressViewController progressViewController:[FLModalProgressView class] presentationBehavior:[FLModalPresentationBehavior instance]];
	[self.progressController setTitle:[NSString stringWithFormat:NSLocalizedString(@"Copying to %@:", nil), [UIDevice currentDevice].deviceDisplayName]];
	[self.progressController setButtonTitle:NSLocalizedString(@"Cancel", nil)];
	[self.progressController setButtonTarget:self action:@selector(cancelCallback:) isCancel:YES];
	[self.progressController showProgress];
	
	[super didPrepareBatch];
}

- (void) prepareBatch
{
	if(![FLReachableNetwork instance].isReachable)
	{
		FLActionDescription* description = [[FLActionDescription alloc] init];
		description.actionItemName = FLActionDescriptionItemNamePhoto;
		description.actionType = FLActionTypeCopy;
		ShowOfflineAlert(description.unableText);
        FLReleaseWithNil(description);
	
		[self requestCancel:nil];
	}
    else
    {
        FLRetain(self);
        
        FLAlert* sizesAlert = [FLAlert alertViewController:NSLocalizedString(@"Choose image size to download and save", nil)
        message:NSLocalizedString(@"Note that the high resolution size may take a long time to download.", nil)];
        
        [sizesAlert addButton:[FLDenyButton cancelButton:^(id controller) {
            _downloadSize = kImageDownloadSize;
            [self didPrepareBatch];
        }]];

        [sizesAlert addButton:[FLConfirmButton buttonWithTitle:NSLocalizedString(@"High Resolution", nil)
                onPress:^(id controller) {
                    _downloadSize = kImageHighResDownloadSize;
                    [self didPrepareBatch];
                }]];
        
        [sizesAlert showViewControllerAnimated:YES];
    
    }
	
}

- (void) _willSaveToDevice:(FLSaveImageToUsersPhotoAlbumOperation*) saver
{
	ZFLoadImageFromCacheOperation* downloader = (ZFLoadImageFromCacheOperation*) saver.previousOperation;
	FLCachedImage* image = downloader.output;
	
	[saver setImageInput:image.imageFile.image properties:image.imageFile.properties];
	
}

- (void) updateProgress:(NSUInteger) count
    total:(NSUInteger) total
{
	[self.progressController updateProgress:count totalAmount:total];
	
	[self.progressController.progressView setProgressBarText:[NSString stringWithFormat:(NSLocalizedString(@"%d of %d Photos", nil)), 
		count + 1, 
		total]];
}

- (FLAction*) createActionWithCurrentQueueObject:(id) object
{
	ZFPhoto* photo = object;

	[self.progressController setSecondaryText:photo.displayName];
			
	FLAction* action = FLAutorelease([[FLAction alloc] init]);
	action.networkRequired = YES;
	action.actionDescription.actionItemName = FLActionDescriptionItemNamePhoto;
	action.actionDescription.actionType = FLActionTypeCopy;
	
	ZFLoadImageFromCacheOperation* downloader = 
        FLAutorelease([[ZFLoadImageFromCacheOperation alloc] initWithSubOperation: FLAutorelease([[ZFDownloadImageHttpRequest alloc] initWithPhoto:photo photoSize:_downloadSize])]);
	downloader.canLoadFromCache = YES;
	downloader.canSaveToCache = YES;
	downloader.cache = [[self.context userStorageService].cacheDatabase;
	[action addOperation:downloader];
	
    
    FLSaveImageToUsersPhotoAlbumOperation* saver =
        [FLSaveImageToUsersPhotoAlbumOperation operation];
    saver.willStartBlock = ^(id theOperation) {
        [self _willSaveToDevice:theOperation]; 
    };
    saver.willFinishBlock = ^(id theOperation) {
        if([theOperation didSucceed])
        {
            FLExportedAsset* exportedAsset = [FLExportedAsset exportedAsset];
            exportedAsset.originalID = [NSString stringWithFormat:@"%d", photo.IdValue];
            exportedAsset.exportedDate = [NSDate date];
            exportedAsset.assetURL = [[theOperation operationOutput] absoluteString];
            [[self.context userStorageService].documentsDatabase saveObject:exportedAsset];
        }
    };
    
	[action addOperation:saver];
    
	return action;
}

@end
#endif
#endif