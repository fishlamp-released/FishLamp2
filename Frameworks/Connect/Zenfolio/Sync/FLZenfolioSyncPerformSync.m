//
//	FLZenfolioSyncPerformSync.m
//	FishLamp
//
//	Created by Mike Fullerton on 8/20/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//
#if 0
#import "FLZenfolioSyncPerformSync.h"
#import "FLZenfolioUtils.h"
#import "FLZenfolioDownloadImageHttpRequest.h"

#if IOS
#import "FLProgressViewController.h"
#import "FLModalProgressView.h"
#endif


#if DEBUG
#define LOG 0
#endif
#if LOG
#warning LOG enabled
#endif

@interface FLZenfolioSyncPerformSync ()
- (void) _syncNextPhoto;
- (void) _beginSyncingNextPhotoSet;
- (void) _beginExpandingNextItemForPrep;
- (void) _addElementToSyncQueueForPrep:(FLZenfolioGroupElement*) element;

@property (readwrite, retain, nonatomic) FLZenfolioPhotoSet* syncingPhotoSet;
@end

@implementation FLZenfolioSyncPerformSync

@synthesize syncingPhotoSet = _downloadingPhotoSet;
@synthesize elementsToSync = _elementsToSync;

- (id) delegate
{
	return _delegate.object;
}

- (void) setDelegate:(id<FLZenfolioSyncPerformSyncDelegate>) delegate
{
	_delegate.object = delegate;
}

- (id) init
{
	if((self = [super init]))
	{
		_delegate = [[FLWeakReference alloc] init];
	}
	
	return self;
}

- (void) dealloc
{
#if IOS
	[UIApplication sharedApplication].idleTimerDisabled = NO;
#endif
	FLRelease(_delegate);
	FLRelease(_groupSyncList);
	FLRelease(_downloadingPhotoSet);
	FLRelease(_photoSetSyncList);
	FLRelease(_elementsToSync);
	FLRelease(_prepareSyncDictionary);
	FLRelease(_prepareSyncList);
	FLSuperDealloc();
}

- (void) beginActionInContext:(FLOperationContext *)context
{
	[super beginActionInContext:context];

#if IOS

	[UIApplication sharedApplication].idleTimerDisabled = YES;

	self.progressController = [FLProgressViewController progressViewController:[FLModalProgressView class] presentationBehavior:[FLModalPresentationBehavior instance]];
//	[self.progressController setWasThemed:YES];
	[self.progressController setTitle:NSLocalizedString(@"Finding Galleries in Group:", nil)];
	[self.progressController setButtonTitle:NSLocalizedString(@"Cancel", nil)];
	[self.progressController setButtonTarget:self action:@selector(cancelCallback:) isCancel:YES];
	[self.progressController showProgress];
#endif

	FLSetObjectWithRetain(_prepareSyncList, [NSMutableArray arrayWithCapacity:_elementsToSync.count]);
	FLSetObjectWithRetain(_prepareSyncDictionary, [NSMutableDictionary dictionary]);
	
	_totalPhotoCount = 0;
	
	for(FLZenfolioGroupElement* element in _elementsToSync.forwardObjectEnumerator)
	{
		[self _addElementToSyncQueueForPrep:element];
	}
	
	[self _beginExpandingNextItemForPrep];
}

- (void) _syncDidFinish:(NSError*) error
{
	[self.delegate syncPerformSync:self didFinishSync:error];
#if IOS
	[UIApplication sharedApplication].idleTimerDisabled = NO;
#endif
}

- (void) _onPhotoSetDownloadedForSync:(FLAction*) action
{
	if(action.didSucceed)
	{
        FLAssertIsNotNil_(self.syncingPhotoSet);
        FLAssert_v(self.syncingPhotoSet.PhotoCountValue == (int) self.syncingPhotoSet.Photos.count, @"photoset not properly loaded");

#if IOS
		[self.progressController setTitle:[NSString stringWithFormat:NSLocalizedString(@"Synchronizing %@:", nil),
            self.syncingPhotoSet.isGalleryElement ? NSLocalizedString(@"Gallery", nil) : NSLocalizedString(@"Collection", nil)]];
		[self.progressController setSecondaryText:self.syncingPhotoSet.Title];
		[self.progressController updateProgress:_photoCount totalAmount:_totalPhotoCount];
		[self.progressController.progressView setProgressBarText:[NSString stringWithFormat:(NSLocalizedString(@"%d of %d Photos",nil)), _photoCount, _totalPhotoCount]];
#endif

		_currentPhotoIndex = -1;
		
		[self _syncNextPhoto];
	}
	else
	{
		[self _syncDidFinish:[action error]];
	}
}

- (void) _onPhotoSynced:(FLAction*) action photo:(FLZenfolioPhoto*) photo
{
	if(action.didSucceed)
	{
#if IOS
		[self.progressController updateProgress:++_photoCount totalAmount:_totalPhotoCount];
		[self.progressController.progressView setProgressBarText:[NSString stringWithFormat:(NSLocalizedString(@"%d of %d Photos", nil)), _photoCount, _totalPhotoCount]];
#endif
		[self.delegate syncPerformSync:self didDownloadPhoto:photo error:nil];
		
		[self _syncNextPhoto];
	}
	else
	{
		[self _syncDidFinish:[action error]];
	}
}

- (void) _onUpdatePhotoInfoInCache:(FLOperation*) photoOperation photo:(FLZenfolioPhoto*) photo
{
	[[[self.context userStorageService].cacheDatabase saveObject:photo];
	
	// wish we didn't have to iterate the list to update this...
	NSMutableArray* array = self.syncingPhotoSet.Photos;
	NSUInteger i = 0;
	for(FLZenfolioPhoto* p in array)
	{	
		if( photo.IdValue != 0 && 
			p.IdValue == photo.IdValue)
		{
			[array replaceObjectAtIndex:i withObject:photo];
			break;
		}
		++i;
	}
	
	// are we on the last photo?
	
	if(_currentPhotoIndex + 1 >= array.count)
	{
		FLZenfolioSyncState* tgElement = [[FLZenfolioSyncService instance] syncStateForGroupElementId:self.syncingPhotoSet.Id];
		tgElement.isSyncedValue = YES;
		tgElement.lastSyncDate = [NSDate date];
		[[FLZenfolioSyncService instance] saveSyncState:tgElement];
		
		[[[self.context userStorageService].cacheDatabase saveObject:self.syncingPhotoSet]; // for updated photo list.
	}
}

- (void) _decideToLoadPhoto:(FLPerformSelectorOperation*) operation 
                      photo:(FLZenfolioPhoto*) photo
{
	BOOL loadPhoto = YES;
	FLZenfolioPhoto* inCache = [[[self.context userStorageService].cacheDatabase loadObject:photo];
	if(inCache)
	{
		loadPhoto = ![inCache.Sequence isEqualToString:photo.Sequence] || inCache.TextCnValue != photo.TextCnValue;
	}
	if(loadPhoto)
	{
        FLZenfolioApiSoapLoadPhoto* nextOperation = [FLZenfolioApiSoapLoadPhoto networkOperationWithServerContext:[FLZenfolioApiSoap instance]];
        nextOperation.input.photoId = photo.Id;
        nextOperation.input.level = kZenfolioInformatonLevelFull;
    
        [operation insertNextOperation:nextOperation];
    }
}

- (void) _beginSyncingPhoto:(FLZenfolioPhoto*) photo 
{

// NOTE that the photo is coming in from a freshly loaded photoset so the sequence numbers will be the 
// latest - this is important in setting the FLZenfolioDownloadImageHttpRequest below and deciding whether to load
// the image in _decideToLoadPhoto

	FLAction* action = [self createAction];
	action.networkRequired = YES;
	action.actionDescription.actionType = FLActionTypeSync;
	action.actionDescription.actionItemName = FLActionDescriptionItemNamePhoto;

    [action addOperationWithBlock:^(id operation) {
        [self _decideToLoadPhoto:operation photo:photo];
    }];
	
    FLZenfolioLoadImageFromCacheOperation* loadThumbnail =
        [FLZenfolioLoadImageFromCacheOperation cachedObjectOperation:
            [FLZenfolioDownloadImageHttpRequest downloadImageOperation:photo photoSize:kGalleryThumbnailDownloadSize]];
    
    loadThumbnail.cache = [[self.context userStorageService].cacheDatabase;
    loadThumbnail.canLoadFromCache = YES;
    loadThumbnail.canSaveToCache = YES;
    [action addOperation:loadThumbnail];
	
    FLZenfolioLoadImageFromCacheOperation* downloadImage =
        [FLZenfolioLoadImageFromCacheOperation cachedObjectOperation:
            [FLZenfolioDownloadImageHttpRequest downloadImageOperation:photo photoSize:kImageDownloadSize]];
    
    downloadImage.cache = [[self.context userStorageService].cacheDatabase;
    downloadImage.canLoadFromCache = YES;
    downloadImage.canSaveToCache = YES;
    [action addOperation:downloadImage];
		
	if(_downloadLargeImages) {

        FLAssertFailed_v(@"Long timeout needs to be set for large images");
		FLZenfolioDownloadImageHttpRequest* downloadHighResPhoto =
            [FLZenfolioDownloadImageHttpRequest downloadImageOperation:photo photoSize:kImageHighResDownloadSize];

// TODO: fix this
//		loadPhotoHttpRequest.activityTimerExplanation = kLongDownloadExplanation;
//		loadPhotoHttpRequest.timeoutInterval = kLongDownloadTimeout;

		FLZenfolioLoadImageFromCacheOperation* operation = [FLZenfolioLoadImageFromCacheOperation cachedObjectOperation:downloadHighResPhoto];
		operation.cache = [[self.context userStorageService].cacheDatabase;
		operation.canLoadFromCache = YES;
		operation.canSaveToCache = YES;
		[action addOperation:operation];
	}
	
	[action addOperationWithBlock:^(id operation) {
        [self _onUpdatePhotoInfoInCache:operation photo:photo];
    } ];

    [self.actionContext startAction:action completion: ^(id<FLAsyncResult> result) {
        [self _onPhotoSynced:action photo:photo];
        }];
}

- (void) _finishedSyncingPhotoSets
{
	if(_groupSyncList.count)
	{
		for(FLZenfolioGroupElementSyncInfo* element in _groupSyncList)
		{
			FLZenfolioSyncState* state = [[FLZenfolioSyncService instance] syncStateForGroupElementId:element.syncObjectId];
			state.isSyncedValue = YES;
			state.lastSyncDate = [NSDate date];
			[[FLZenfolioSyncService instance] saveSyncState:state];
		}
	}
	
	[self _syncDidFinish:nil];
}

- (void) _onUpdatePhotoSetInCacheForSync:(FLOperation*) operation
{
	if(operation.didSucceed)
	{
		FLZenfolioPhotoSet* newPhotoSet = [operation loadPhotoSetResult];

		self.syncingPhotoSet = newPhotoSet;
        
		if(newPhotoSet.PhotoCountValue == 0)
		{
			FLZenfolioSyncState* tgElement = [[FLZenfolioSyncService instance] syncStateForGroupElementId:newPhotoSet.Id];
			tgElement.isSyncedValue = YES;
			tgElement.lastSyncDate = [NSDate date];
			[[FLZenfolioSyncService instance] saveSyncState:tgElement];
		}
        
        [[[self.context userStorageService].cacheDatabase saveObject:newPhotoSet];
		
#if LOG		   
		FLLog(@"Syncing FLZenfolioPhotoSet: %@", newPhotoSet.Title);
#endif
	}
}

- (FLOperation*) _createLoadFullPhotoSet:(NSNumber*) photoSetID
{
    FLOperation* loadFullPhotoSet = [FLZenfolioWebService loadPhotoSetHttpRequest:photoSetID];
    [loadFullPhotoSet.observeFinish:^(id theOperation) {
        [self _onUpdatePhotoSetInCacheForSync:theOperation];
    }];
    return loadFullPhotoSet;
}

- (void) _onLoadedSmallestPhotoSet:(FLOperation*) operation
{
	if(operation.didSucceed) {
		FLZenfolioPhotoSet* newPhotoSet = [operation loadPhotoSetResult];
			
		FLZenfolioPhotoSet* photoSet = [[[self.context photoSetStorage] loadPhotoSetWithID:newPhotoSet.IdValue];
		if( photoSet && 
			photoSet.TextCnValue == newPhotoSet.TextCnValue && 
			photoSet.PhotoListCnValue == newPhotoSet.PhotoListCnValue &&
			photoSet.PhotoCountValue == (int) photoSet.Photos.count)
		{
            self.syncingPhotoSet = photoSet;
            
			if(photoSet.PhotoCountValue == 0)
			{
				FLZenfolioSyncState* tgElement = [[FLZenfolioSyncService instance] syncStateForGroupElementId:photoSet.Id];
				tgElement.isSyncedValue = YES;
				tgElement.lastSyncDate = [NSDate date];
				[[FLZenfolioSyncService instance] saveSyncState:tgElement];
			}
		}
        else
        {
            [operation insertNextOperation:[self _createLoadFullPhotoSet:newPhotoSet.Id]];
        }
	}
}

- (void) _decideToLoadPhotoSet:(FLPerformSelectorOperation*) operation 
                      photoSet:(FLZenfolioGroupElementSyncInfo*) photoSet
{
	FLZenfolioPhotoSet* inCache = [[[self.context photoSetStorage] loadPhotoSetWithID:photoSet.syncObjectIdValue];
	if(!inCache || ![inCache allPhotosAreLoaded])
	{
        [operation insertNextOperation:[self _createLoadFullPhotoSet:photoSet.syncObjectId]];
    }
    else
    {
  		FLOperation* newOperation = [FLZenfolioWebService loadPhotoSetHttpRequest:photoSet.syncObjectId level:FLZenfolioInformatonLevelLevel1 loadPhotos:NO];
        [newOperation observeFinish:^(id theOperation) {
            [self _onLoadedSmallestPhotoSet:theOperation]; 
        }];
        [operation insertNextOperation:newOperation];
    }
}


- (void) _beginSyncingNextPhotoSet
{
	self.syncingPhotoSet = nil;

	if(_photoSetSyncList.count == 0)
	{
		[self _finishedSyncingPhotoSets];
	}
	else
	{
		FLZenfolioGroupElementSyncInfo* photoSet = FLAutorelease(FLRetain([_photoSetSyncList objectAtIndex:0]));
		[_photoSetSyncList removeObjectAtIndex:0];
	
		FLAction* action = [self createAction];
		action.networkRequired = YES;
		action.actionDescription.actionType = FLActionTypeSync;
		action.actionDescription.actionItemName = FLActionDescriptionItemNameGallery;

        [action addOperationWithBlock:^(id operation) {
            [self _decideToLoadPhotoSet:operation photoSet:photoSet];
        }];

        [self.actionContext startAction:action completion: ^(id<FLAsyncResult> result) {
            [self _onPhotoSetDownloadedForSync:action];
        }];

	}
}

- (void) _syncNextPhoto
{	
	NSArray* photoArray = self.syncingPhotoSet.Photos;
	
	if(++_currentPhotoIndex >= photoArray.count)
	{
		[self.delegate syncPerformSync:self didUpdateGroupElement:self.syncingPhotoSet	error:nil];
		
		[self _beginSyncingNextPhotoSet];
	}
	else
	{
		[self _beginSyncingPhoto:[photoArray objectAtIndex:(NSUInteger) _currentPhotoIndex]];
	}
}

- (void) _beginSync
{
	if(_groupSyncList.count > 0 || _photoSetSyncList.count > 0)
	{
		_photoCount = 0;
		
		FLZenfolioPreferences* prefs = [FLZenfolioPreferences loadPreferences];
		_downloadLargeImages = prefs.syncLargeImagesValue;
		
		_photoCount = 1;		

#if IOS
		[self.progressController setTitle:NSLocalizedString(@"Synchronizing…", nil)];
		[self.progressController setSecondaryText:@""];
		[self.progressController updateProgress:_photoCount totalAmount:_totalPhotoCount];
		[self.progressController.progressView setProgressBarText:[NSString stringWithFormat:(NSLocalizedString(@"%d of %d Photos", nil)), _photoCount, _totalPhotoCount]];
#endif
		[self _beginSyncingNextPhotoSet];
	}
	else
	{
		[self _syncDidFinish:nil];
	}
}

- (void) _syncDidFinishPrep
{
	FLSetObjectWithRetain(_photoSetSyncList, [NSMutableArray array]);
	FLSetObjectWithRetain(_groupSyncList, [NSMutableArray array]);
	
	for(id key in _prepareSyncDictionary)
	{
		FLZenfolioGroupElementSyncInfo* element = [_prepareSyncDictionary objectForKey:key];
		if(element.isGroupValue)
		{
			[_groupSyncList addObject:element];
		}
		else
		{
			[_photoSetSyncList addObject:element];
		}
	}
	FLReleaseWithNil(_prepareSyncList);
	FLReleaseWithNil(_prepareSyncDictionary);

	[self _beginSync];
}

- (void) _onUpdateCachedGroupForExpandingForPrep:(FLZenfolioApiSoapLoadGroup*) operation
{
	if(operation.didSucceed)
	{
		FLZenfolioGroup* newGroup = operation.output.LoadGroupResult;
		[[[self.context userStorageService].cacheDatabase saveObject:newGroup];
	}
}

- (void) _addElementToSyncQueueForPrep:(FLZenfolioGroupElement*) element
{
	if(!element.isGroupElement)
	{
		_totalPhotoCount += (NSUInteger) ((FLZenfolioPhotoSet*) element).PhotoCountValue;
	}

	FLZenfolioGroupElementSyncInfo* info = [[FLZenfolioGroupElementSyncInfo alloc] init];
	info.name = element.Title;
	info.isGroupValue = element.isGroupElement;
	info.syncObjectId = element.Id;
	[_prepareSyncList addObject:info];
	FLRelease(info);
}

- (void) _addElementsToSyncQueueForPrep:(NSArray*) elements
{
	for(FLZenfolioGroupElement* element in elements)
	{
		[self _addElementToSyncQueueForPrep:element];
	}
}

- (void) _onGroupLoadedForExpandingForPrep:(FLAction*) action
{
	if(action.didSucceed)
	{
		FLZenfolioGroup* newGroup = [[[action lastOperation] operationOutput] LoadGroupResult];
		[self _addElementsToSyncQueueForPrep:newGroup.Elements];
		[self _beginExpandingNextItemForPrep];
	}
	else
	{	 
		[self _syncDidFinish:[action error]];
	}
}

- (void) _beginExpandingGroupForPrep:(int) groupId
{
	FLAction* action = [self createAction];
	
	action.networkRequired = YES;
	action.actionDescription.actionType = FLActionTypeSync;
	action.actionDescription.actionItemName = FLActionDescriptionItemNameGroup;
	
	FLZenfolioApiSoapLoadGroup* operation = FLAutorelease([[FLZenfolioApiSoapLoadGroup alloc] initWithServerContext:[FLZenfolioApiSoap instance]]);
	operation.input.groupIdValue = groupId;
	operation.input.level = kZenfolioInformatonLevelFull;
	operation.input.includeChildrenValue = YES;
    operation.willStartBlock = ^(id theOperation) { [self _onUpdateCachedGroupForExpandingForPrep:theOperation]; };
//	[operation setDidPerformCallback:self action:@selector(_onUpdateCachedGroupForExpandingForPrep:)];
	[action addOperation:operation];
    
	[self.actionContext startAction:action completion: ^(id<FLAsyncResult> result) {
        [self _onGroupLoadedForExpandingForPrep:action];
    }];

}

- (void) _beginExpandingNextItemForPrep
{
	BOOL didSomething = NO;
		
	while(_prepareSyncList.count)
	{
		FLZenfolioGroupElementSyncInfo* groupElement = FLAutorelease(FLRetain([_prepareSyncList objectAtIndex:0]));
		[_prepareSyncList removeObjectAtIndex:0];
	
		if([_prepareSyncDictionary objectForKey:groupElement.syncObjectId] == nil)
		{
			[_prepareSyncDictionary setObject:groupElement forKey:groupElement.syncObjectId];
				
			if(groupElement.isGroupValue)
			{
				didSomething = YES;
#if IOS
				[self.progressController setSecondaryText:groupElement.name];
#endif
				[self _beginExpandingGroupForPrep:groupElement.syncObjectIdValue];
			}
		}

		if(didSomething)
		{
			break;
		}
	}
	
	if(!didSomething)
	{
		[self _syncDidFinishPrep];
	}
}

@end
#endif