//
//  FLZenfolioUpdatePhotoSetOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioUpdatePhotoSetOperation.h"
#import "FLZenfolioUtils.h"
#import "FLZenfolioDownloadImageHttpRequest.h"
#import "FLZenfolioCacheService.h"
#import "FLZenfolioSyncService.h"
#import "FLZenfolioHttpRequest.h"

@interface FLZenfolioUpdatePhotoSetOperation ()
@property (readwrite, strong, nonatomic) NSNumber* photoSetID;
@property (readwrite, strong, nonatomic) FLZenfolioImageDisplaySize* displaySize;
@end

@implementation FLZenfolioUpdatePhotoSetOperation

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
        displaySize:(FLZenfolioImageDisplaySize*) displaySize {
    
    self = [super init];
    if(self) {
        self.photoSetID = photoSetID;
        _syncPhotos = syncPhotos;
        _syncLargeImages = syncLargeImages;
        self.displaySize = displaySize;
    }
    return self;
}

- (FLZenfolioPhotoSet*) _loadCachedPhotoSetIfPossible {

    FLZenfolioPhotoSet* inCache = [[self.context cacheService] loadPhotoSetWithID:_photoSetID.intValue];
	if(!inCache || ![inCache allPhotosAreLoaded]) {
        return nil;
    }
    
    FLZenfolioPhotoSet* minSet = FLConfirmResultType(
        [[FLZenfolioHttpRequest loadPhotoSetHttpRequest:_photoSetID
                                                    level:kZenfolioInformatonLevelLevel1
                                            includePhotos:NO] sendSynchronouslyInContext:self.context],
                                            FLZenfolioPhotoSet);
    
    if(![inCache isStaleComparedToPhotoSet:minSet]) {
        return inCache;
    }

    return nil;
}

- (void) _syncLargeImageForPhoto:(FLZenfolioPhoto*) photo {

    FLAssertFailed_v(@"Long timeout needs to be set for large images");

    FLZenfolioLoadImageFromCacheOperation* operation = [FLZenfolioLoadImageFromCacheOperation downloadImageOperation:photo imageSize:[_displaySize highResolutionImageDownloadSize]];
// TODO: fix this
//		loadPhotoHttpRequest.activityTimerExplanation = kLongDownloadExplanation;
//		loadPhotoHttpRequest.timeoutInterval = kLongDownloadTimeout;
    FLConfirmResultType([operation runSynchronouslyInContext:self.context], FLStorableImage);
}

- (void) _syncPhoto:(FLZenfolioPhoto*) photo
         inPhotoSet:(FLZenfolioPhotoSet*) photoSet {

// NOTE that the photo is coming in from a freshly loaded photoset so the sequence numbers will be the 
// latest - this is important in setting the FLZenfolioDownloadImageHttpRequest below and deciding whether to load
// the image in _decideToLoadPhoto

    FLConfirmResultType([[FLZenfolioLoadImageFromCacheOperation downloadImageOperation:photo imageSize:[_displaySize photoThumbnailSize]] runSynchronouslyInContext:self.context], FLStorableImage);
    FLConfirmResultType([[FLZenfolioLoadImageFromCacheOperation downloadImageOperation:photo imageSize:[_displaySize imageDownloadSize]]  runSynchronouslyInContext:self.context], FLStorableImage);

    if(_syncLargeImages) {
        [self _syncLargeImageForPhoto:photo];
	}

	[[self.context cacheService] savePhoto:photo];

    // wish we didn't have to iterate the list to update this...
	NSMutableArray* array = photoSet.Photos;
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
}

- (FLZenfolioPhotoSet*) _loadLatestPhotoSet {
    FLZenfolioPhotoSet* photoSet = [self _loadCachedPhotoSetIfPossible];
    if(!photoSet) {
        FLZenfolioSyncState* tgElement = [[self.context syncService] syncStateForGroupElementId:_photoSetID];
		tgElement.isSyncedValue = NO;
		tgElement.lastSyncDate = [NSDate date];
		[[self.context syncService] saveSyncState:tgElement];
    
        FLHttpRequest* request = [FLZenfolioHttpRequest loadPhotoSetHttpRequest:_photoSetID];
    
        photoSet = FLConfirmResultType([request sendSynchronouslyInContext:self.context], FLZenfolioPhotoSet);
    }
    return photoSet;
}

- (FLZenfolioPhoto*) _loadLatestPhoto:(FLZenfolioPhoto*) photo {
	
    FLZenfolioPhoto* inCache = [[self.context cacheService] loadPhotoWithID:photo.IdValue];
    
    if(inCache && ![inCache isStaleComparedToPhoto:photo]) {
        return inCache;
    }
    
    return FLConfirmResultType([[FLZenfolioHttpRequest loadPhotoHttpRequest:photo.Id
                                                            level:kZenfolioInformatonLevelFull] sendSynchronouslyInContext:self.context], FLZenfolioPhoto);
}

- (FLResult) runOperation {

    FLZenfolioPhotoSet* photoSet = [self _loadLatestPhotoSet];
    
    if(photoSet.PhotoCountValue == 0) {
        FLZenfolioSyncState* tgElement = [[self.context syncService] syncStateForGroupElementId:photoSet.Id];
        tgElement.isSyncedValue = YES;
        tgElement.lastSyncDate = [NSDate date];
        [[self.context syncService] saveSyncState:tgElement];
    }
    else if(_syncPhotos) {
        for(FLZenfolioPhoto* photo in photoSet.Photos) {
            [self _syncPhoto:[self _loadLatestPhoto:photo] inPhotoSet:photoSet];
        }
        
   		FLZenfolioSyncState* tgElement = [[self.context syncService] syncStateForGroupElementId:photoSet.Id];
		tgElement.isSyncedValue = YES;
		tgElement.lastSyncDate = [NSDate date];
		[[self.context syncService] saveSyncState:tgElement];
	}
    
    [[self.context cacheService] savePhotoSet:photoSet];

    return photoSet;
}

@end
