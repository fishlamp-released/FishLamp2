//
//	FLZenfolioRandomPhotoDownloader.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/1/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//
#if REFACTOR

#import "FLZenfolioRandomPhotoDownloader.h"
#import "FLZenfolioWebApi.h"

#import "FLZenfolioSyncService.h"

#import "FLZenfolioDownloadImageHttpRequest.h"
#import "FLReachableNetwork.h"
#import "FLRandom.h"

#if IOS
#import "FLProgressViewController.h"
#import "FLSimpleProgressView.h"
#endif

@interface FLZenfolioRandomPhotoDownloader (Private)
- (void) beginLoadingPhotoSet:(NSInteger) photoSetId;
- (void) beginLoadGroup:(NSInteger) groupId;
- (void) _begin;
- (void) beginLoadingPhoto:(FLZenfolioPhoto*) photo;
@property (readwrite, assign, nonatomic) FLAction* action;

@end

@implementation FLZenfolioRandomPhotoDownloader

- (FLAction*) action
{
    return _action.object;
}

- (void) setAction:(FLAction*) action
{
    _action.object = action;
}

@synthesize actionContext = _operationContext;

- (id) init
{
	if((self = [super init]))
	{
		_downloadedPhotos = [[NSMutableSet alloc] init];
        _action = [[FLWeakReference alloc] init];
	}
	
	return self;
}

- (void) dealloc
{	
    FLRelease(_action);
    FLRelease(_mainProgress);
    FLRelease(_operationContext);
    FLRelease(_completionBlock);
	FLRelease(_downloadedPhotos);
	FLSuperDealloc();
}

- (void) _notify:(FLJpegFile*) imageFile 
{
    if(_completionBlock)
    {
        FLZenfolioRandomDownloaderCompletionBlock oldBlock = FLRetain(_completionBlock);
        FLReleaseBlockWithNil(_completionBlock);
        oldBlock(imageFile, nil);
        FLRelease(oldBlock);
    }
}

- (void) _failed:(NSError*) error
{
    if(_completionBlock)
    {
        _completionBlock(nil, error);
        FLReleaseBlockWithNil(_completionBlock);
    }
}

- (void) _notifyDownloadCompleted:(FLJpegFile*) imageFile 
                            error:(NSError*) error
{
	FLReleaseWithNil(_mainProgress);

    if(error)
    {
        [self performSelectorOnMainThread:@selector(_failed:) withObject:error waitUntilDone:YES];
    }
    else
    {
        if(imageFile)
        {
            [imageFile readFromStorage];
        }

        [self performSelectorOnMainThread:@selector(_notify:) withObject:imageFile waitUntilDone:YES];
    }
}

- (void) beginLoadingPhoto:(FLZenfolioPhoto*) photo
{
    FLAction* action = [FLAction action];

    self.action = action;
    
    [action setNetworkRequired:YES];
    [action actionDescription].actionType = FLActionTypeDownload;
    [action actionDescription].actionItemName = FLActionDescriptionItemNamePhoto;

    FLZenfolioDownloadImageHttpRequest* loadPhotoHttpRequest = FLAutorelease([[FLZenfolioDownloadImageHttpRequest alloc] initWithPhoto:photo 
        photoSize:kImageDownloadSize]);
    
    FLZenfolioDownloadImageHttpRequest* operation = FLAutorelease([[FLZenfolioDownloadImageHttpRequest alloc] initWithSubOperation:loadPhotoHttpRequest]);
    
    operation.cache = [[self.userContext userStorageService].cacheDatabase;
    operation.canLoadFromCache = YES;
    operation.canSaveToCache = YES;
    [action addOperation:operation];

	[self.actionContext startAction:action completion: ^(id<FLAsyncResult> result) { 
        if([action didSucceed])
        {
            FLCachedImage* cachedImage = [[action lastOperation] operationOutput]; 
            [_downloadedPhotos addObject:photo.Id]; 
            
    //		  FLLog(@"downloaded: %@", photo.Id);
            
            [self _notifyDownloadCompleted:cachedImage.imageFile error:nil];
        }
        else
        {
            [self _notifyDownloadCompleted:nil error:[action error]];
        }
    }];

}

- (void) _didLoadRandomGroupElement:(FLZenfolioGroupElement*) groupElement
{
    BOOL foundOne = NO;

    if(groupElement.isGroupElement)
    {
        FLZenfolioGroup* group = (FLZenfolioGroup*) groupElement;
        
        NSMutableArray* subGroups = FLAutorelease([group.Elements mutableCopy]);
        
        // remove empty photoSets and groups from random choice list
        for(NSInteger i = (NSInteger) subGroups.count-1; i >= 0; i--)
        {
        
            FLZenfolioGroupElement* subElement = [subGroups objectAtIndex:(NSUInteger) i];
            if(subElement.isGroupElement)
            {
                if(((FLZenfolioGroup*) subElement).ImmediateChildrenCountValue == 0)
                {
                    [subGroups removeObjectAtIndex:(NSUInteger) i];
                }
            }
            else
            {
                FLZenfolioPhotoSet* photoSet = [[[self.userContext photoSetStorage] loadPhotoSetWithID:subElement.IdValue];
                if(photoSet)
                {
                    if(photoSet.PhotoCountValue == 0)
                    {
                        [subGroups removeObjectAtIndex:(NSUInteger) i];
                    }
                }
                else if(((FLZenfolioPhotoSet*) subElement).PhotoCountValue == 0)
                {
                    [subGroups removeObjectAtIndex:(NSUInteger) i];
                }
            }
        }
        
        // choose a random group or photoSet from pruned list
        if(subGroups.count > 0)
        {
            foundOne = YES;
            
            NSUInteger randomIndex =  FLRandomInt(0, (NSUInteger) subGroups.count - 1);
            
            FLZenfolioGroupElement* randomItem = [subGroups objectAtIndex:randomIndex];
            
            if(randomItem.isGroupElement)
            {
                [self beginLoadGroup:randomItem.IdValue];
            }
            else
            {
                [self beginLoadingPhotoSet:randomItem.IdValue];
            }
        }
        
    }
    else
    {
        FLZenfolioPhotoSet* photoSet = (FLZenfolioPhotoSet*) groupElement; 
        NSMutableArray* photoArray = FLAutorelease([photoSet.Photos mutableCopy]);
        
        if(photoArray.count) // check just in case, though it should have been removed from the choices.
        {
            _hasPhotosToChooseFrom = YES;
            NSUInteger randomIndex = FLRandomInt(0, (NSUInteger) photoArray.count - 1);
            FLZenfolioPhoto* photo = [photoArray objectAtIndex:randomIndex];
            foundOne = ![_downloadedPhotos containsObject:photo.Id];
            if(foundOne)
            {
                [self beginLoadingPhoto:photo];
            }
#if DEBUG
            else FLLog(@"not loading dupe: %@", photo.Id);
#endif					
        }
    }
    
    if(!foundOne)
    {
        if(_downloadedPhotos.count)
        {
            [_downloadedPhotos removeAllObjects];
        }
    
        if(_hasPhotosToChooseFrom)
        {
            [self _begin];
        }
        else
        {
            [self _notifyDownloadCompleted:nil error:nil];
        }
    }
}

- (void) _onGroupElementLoaded:(FLAction*) action
{
	if(action.didSucceed)
	{
		FLZenfolioGroupElement* groupElement = [[action lastOperation] operationOutput];
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                [self _didLoadRandomGroupElement:groupElement];
            });
    }
	else
	{
		[self _notifyDownloadCompleted:nil error:[action error]];
	}
}

- (void) beginLoadGroup:(NSInteger) groupId 
{
    FLAction* action = [FLAction action];
    self.action = action;

    FLZenfolioApiSoapLoadGroup* loadGroup = FLAutorelease([[FLZenfolioApiSoapLoadGroup alloc] initWithServerContext:[FLZenfolioApiSoap instance]]);
    loadGroup.input.groupIdValue = groupId;
    loadGroup.input.level = kZenfolioInformatonLevelFull;
    loadGroup.input.includeChildrenValue = YES;
    
    FLZenfolioLoadGroupFromCacheOperation* operation = FLAutorelease([[FLZenfolioLoadGroupFromCacheOperation alloc] initWithSubOperation:loadGroup]);
    operation.cache = [[self.userContext userStorageService].cacheDatabase;
    operation.canLoadFromCache = YES;
    operation.canSaveToCache = YES;
 
    [action addOperation:operation];
    [action actionDescription].actionType = FLActionTypeDownload;
    [action actionDescription].actionItemName = FLActionDescriptionItemNameGroup;

	[self.actionContext startAction:action completion: ^(id<FLAsyncResult> result) {
        [self _onGroupElementLoaded:action];
    }];
}

- (void) beginLoadingPhotoSet:(NSInteger) photoSetId
{
    FLAction* action = [FLAction action];
    self.action = action;

    [action setNetworkRequired:YES];
    [action actionDescription].actionType = FLActionTypeDownload;
    [action actionDescription].actionItemName = FLActionDescriptionItemNameGallery;

    FLOperation* loadPhotoSet = [FLZenfolioWebService loadPhotoSetHttpRequest:[NSNumber numberWithInt:photoSetId]
                                                       level:kZenfolioInformatonLevelFull
                                               includePhotos:YES]];

    
    FLZenfolioLoadPhotoSetFromCacheOperation* operation = FLAutorelease([[FLZenfolioLoadPhotoSetFromCacheOperation alloc] initWithSubOperation:loadPhotoSet]);
    operation.cache = [[self.userContext userStorageService].cacheDatabase;
    operation.canLoadFromCache = YES;
    operation.canSaveToCache = YES;
    [action addOperation:operation];

	[self.actionContext startAction:action completion: ^(id<FLAsyncResult> result) { [self _onGroupElementLoaded:action]; }];
}

- (void) _begin
{
	if(++_retryCount <= 3)
	{
		_hasPhotosToChooseFrom = NO;
	
		NSNumber* rootId = [NSNumber numberWithInt:[FLZenfolioSyncService loadRootGroupId]];
		[self beginLoadGroup:rootId.intValue];
	}
	else
	{
		[self _notifyDownloadCompleted:nil error:nil];
	}
}

- (void) startProgress:(NSString*) progressString
{
	FLReleaseWithNil(_mainProgress);

#if IOS
    FLProgressViewController* progress = [[FLProgressViewController alloc] initWithProgressViewClass:[FLSimpleProgressView class]];
    progress.viewAlpha = 0.65;
	progress.title = progressString;
    progress.contentMode = FLRectLayoutMake(FLRectLayoutHorizontalCentered, FLRectLayoutVerticalTopThird);
    
	_mainProgress = progress;
	[_mainProgress showProgress];
#endif
}

- (void) requestCancel
{
    [self.action requestCancel];
    FLReleaseWithNil(_mainProgress);
    FLReleaseBlockWithNil(_completionBlock);
}

- (void) beginDownloadingRandomImage:(NSString*) progressString 
                     completionBlock:(FLZenfolioRandomDownloaderCompletionBlock) completionBlock
{
	_completionBlock = [completionBlock copy];
    
    if(FLStringIsNotEmpty(progressString))
    {
        [self startProgress:progressString];
    }

    _retryCount = 0;
    [self _begin];
}

- (void) beginLoadingSelectedPhoto:(FLZenfolioPhoto*) photo 
                    progressString:(NSString*) progressString
                   completionBlock:(FLZenfolioRandomDownloaderCompletionBlock) completionBlock
{
	_completionBlock = [completionBlock copy];
    
    [self startProgress:progressString];
	[self beginLoadingPhoto:photo];
}


@end
#endif