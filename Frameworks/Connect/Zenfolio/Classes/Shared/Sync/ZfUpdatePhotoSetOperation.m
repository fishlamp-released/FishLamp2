//
//  ZFUpdatePhotoSetOperation.m
//  ZenLib
//
//  Created by Mike Fullerton on 10/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFUpdatePhotoSetOperation.h"
#import "ZFUtils.h"
#import "ZFDownloadImageHttpRequest.h"
#import "ZFCacheService.h"
#import "ZFSyncService.h"

@interface ZFUpdatePhotoSetOperation ()
@property (readwrite, strong, nonatomic) NSNumber* photoSetID;
@property (readwrite, strong, nonatomic) ZFImageDisplaySize* displaySize;
@end

@implementation ZFUpdatePhotoSetOperation

@synthesize displaySize = _displaySize;
@synthesize photoSetID = _photoSetID;

#if FL_MRC
- (void) dealloc {
    [_displaySize release];
    [_photoSetID release];
    [super dealloc];
}
#endif


- (id) initWithPhotoSetID:(NSNumber*) photoSetID
    syncPhotos:(BOOL) syncPhotos
    syncLargeImages:(BOOL) syncLargeImages
        displaySize:(ZFImageDisplaySize*) displaySize {
    
    self = [super init];
    if(self) {
        self.photoSetID = photoSetID;
        _syncPhotos = syncPhotos;
        _syncLargeImages = syncLargeImages;
        self.displaySize = displaySize;
    }
    return self;
}

- (ZFPhotoSet*) _loadCachedPhotoSetIfPossible {

    ZFPhotoSet* inCache = [[self.context cacheService] loadPhotoSetWithID:_photoSetID.intValue];
	if(!inCache || ![inCache allPhotosAreLoaded]) {
        return nil;
    }
    
    ZFPhotoSet* minSet = FLConfirmResultType(
        [[ZFHttpRequest loadPhotoSetHttpRequest:_photoSetID
                                                    level:kZfInformatonLevelLevel1
                                            includePhotos:NO] sendSynchronouslyInContext:self.context],
                                            ZFPhotoSet);
    
    if(![inCache isStaleComparedToPhotoSet:minSet]) {
        return inCache;
    }

    return nil;
}

- (void) _syncLargeImageForPhoto:(ZFPhoto*) photo {

    FLAssertFailed_v(@"Long timeout needs to be set for large images");

    ZFLoadImageFromCacheOperation* operation = [ZFLoadImageFromCacheOperation downloadImageOperation:photo imageSize:[_displaySize highResolutionImageDownloadSize]];
// TODO: fix this
//		loadPhotoHttpRequest.activityTimerExplanation = kLongDownloadExplanation;
//		loadPhotoHttpRequest.timeoutInterval = kLongDownloadTimeout;
    FLConfirmResultType([operation runSynchronouslyInContext:self.context], FLStorableImage);
}

- (void) _syncPhoto:(ZFPhoto*) photo
         inPhotoSet:(ZFPhotoSet*) photoSet {

// NOTE that the photo is coming in from a freshly loaded photoset so the sequence numbers will be the 
// latest - this is important in setting the ZFDownloadImageHttpRequest below and deciding whether to load
// the image in _decideToLoadPhoto

    FLConfirmResultType([[ZFLoadImageFromCacheOperation downloadImageOperation:photo imageSize:[_displaySize photoThumbnailSize]] runSynchronouslyInContext:self.context], FLStorableImage);
    FLConfirmResultType([[ZFLoadImageFromCacheOperation downloadImageOperation:photo imageSize:[_displaySize imageDownloadSize]]  runSynchronouslyInContext:self.context], FLStorableImage);

    if(_syncLargeImages) {
        [self _syncLargeImageForPhoto:photo];
	}

	[[self.context cacheService] savePhoto:photo];

    // wish we didn't have to iterate the list to update this...
	NSMutableArray* array = photoSet.Photos;
	NSUInteger i = 0;
	for(ZFPhoto* p in array)
	{	
		if( photo.IdValue != 0 && 
			p.IdValue == photo.IdValue)
		{
			[array replaceObjectAtIndex:i withObject:photo];
			break;
		}
		++i;
	}
}

- (ZFPhotoSet*) _loadLatestPhotoSet {
    ZFPhotoSet* photoSet = [self _loadCachedPhotoSetIfPossible];
    if(!photoSet) {
        ZFSyncState* tgElement = [[self.context syncService] syncStateForGroupElementId:_photoSetID];
		tgElement.isSyncedValue = NO;
		tgElement.lastSyncDate = [NSDate date];
		[[self.context syncService] saveSyncState:tgElement];
    
        FLHttpRequest* request = [ZFHttpRequest loadPhotoSetHttpRequest:_photoSetID];
    
        photoSet = FLConfirmResultType([request sendSynchronouslyInContext:self.context], ZFPhotoSet);
    }
    return photoSet;
}

- (ZFPhoto*) _loadLatestPhoto:(ZFPhoto*) photo {
	
    ZFPhoto* inCache = [[self.context cacheService] loadPhotoWithID:photo.IdValue];
    
    if(inCache && ![inCache isStaleComparedToPhoto:photo]) {
        return inCache;
    }
    
    return FLConfirmResultType([[ZFHttpRequest loadPhotoHttpRequest:photo.Id
                                                            level:kZfInformatonLevelFull] sendSynchronouslyInContext:self.context], ZFPhoto);
}

- (FLResult) runOperation {

    ZFPhotoSet* photoSet = [self _loadLatestPhotoSet];
    
    if(photoSet.PhotoCountValue == 0) {
        ZFSyncState* tgElement = [[self.context syncService] syncStateForGroupElementId:photoSet.Id];
        tgElement.isSyncedValue = YES;
        tgElement.lastSyncDate = [NSDate date];
        [[self.context syncService] saveSyncState:tgElement];
    }
    else if(_syncPhotos) {
        for(ZFPhoto* photo in photoSet.Photos) {
            [self _syncPhoto:[self _loadLatestPhoto:photo] inPhotoSet:photoSet];
        }
        
   		ZFSyncState* tgElement = [[self.context syncService] syncStateForGroupElementId:photoSet.Id];
		tgElement.isSyncedValue = YES;
		tgElement.lastSyncDate = [NSDate date];
		[[self.context syncService] saveSyncState:tgElement];
	}
    
    [[self.context cacheService] savePhotoSet:photoSet];

    return photoSet;
}

@end
