//
//  FLZfUpdatePhotoSetOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZfUpdatePhotoSetOperation.h"
#import "FLZfUtils.h"
#import "FLZfDownloadImageHttpRequest.h"
#import "FLZfCacheService.h"
#import "FLZfSyncService.h"

@interface FLZfUpdatePhotoSetOperation ()
@property (readwrite, strong, nonatomic) NSNumber* photoSetID;
@property (readwrite, strong, nonatomic) FLZfImageDisplaySize* displaySize;
@end

@implementation FLZfUpdatePhotoSetOperation

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
        displaySize:(FLZfImageDisplaySize*) displaySize {
    
    self = [super init];
    if(self) {
        self.photoSetID = photoSetID;
        _syncPhotos = syncPhotos;
        _syncLargeImages = syncLargeImages;
        self.displaySize = displaySize;
    }
    return self;
}

- (FLZfPhotoSet*) _loadCachedPhotoSetIfPossible {

    FLZfPhotoSet* inCache = [[self.context cacheService] loadPhotoSetWithID:_photoSetID.intValue];
	if(!inCache || ![inCache allPhotosAreLoaded]) {
        return nil;
    }
    
    FLZfPhotoSet* minSet = FLConfirmResultType(
        [[FLZfHttpRequest loadPhotoSetHttpRequest:_photoSetID
                                                    level:kZfInformatonLevelLevel1
                                            includePhotos:NO] sendSynchronouslyInContext:self.context],
                                            FLZfPhotoSet);
    
    if(![inCache isStaleComparedToPhotoSet:minSet]) {
        return inCache;
    }

    return nil;
}

- (void) _syncLargeImageForPhoto:(FLZfPhoto*) photo {

    FLAssertFailed_v(@"Long timeout needs to be set for large images");

    FLZfLoadImageFromCacheOperation* operation = [FLZfLoadImageFromCacheOperation downloadImageOperation:photo imageSize:[_displaySize highResolutionImageDownloadSize]];
// TODO: fix this
//		loadPhotoHttpRequest.activityTimerExplanation = kLongDownloadExplanation;
//		loadPhotoHttpRequest.timeoutInterval = kLongDownloadTimeout;
    FLConfirmResultType([operation runSynchronouslyInContext:self.context], FLStorableImage);
}

- (void) _syncPhoto:(FLZfPhoto*) photo
         inPhotoSet:(FLZfPhotoSet*) photoSet {

// NOTE that the photo is coming in from a freshly loaded photoset so the sequence numbers will be the 
// latest - this is important in setting the FLZfDownloadImageHttpRequest below and deciding whether to load
// the image in _decideToLoadPhoto

    FLConfirmResultType([[FLZfLoadImageFromCacheOperation downloadImageOperation:photo imageSize:[_displaySize photoThumbnailSize]] runSynchronouslyInContext:self.context], FLStorableImage);
    FLConfirmResultType([[FLZfLoadImageFromCacheOperation downloadImageOperation:photo imageSize:[_displaySize imageDownloadSize]]  runSynchronouslyInContext:self.context], FLStorableImage);

    if(_syncLargeImages) {
        [self _syncLargeImageForPhoto:photo];
	}

	[[self.context cacheService] savePhoto:photo];

    // wish we didn't have to iterate the list to update this...
	NSMutableArray* array = photoSet.Photos;
	NSUInteger i = 0;
	for(FLZfPhoto* p in array)
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

- (FLZfPhotoSet*) _loadLatestPhotoSet {
    FLZfPhotoSet* photoSet = [self _loadCachedPhotoSetIfPossible];
    if(!photoSet) {
        FLZfSyncState* tgElement = [[self.context syncService] syncStateForGroupElementId:_photoSetID];
		tgElement.isSyncedValue = NO;
		tgElement.lastSyncDate = [NSDate date];
		[[self.context syncService] saveSyncState:tgElement];
    
        FLHttpRequest* request = [FLZfHttpRequest loadPhotoSetHttpRequest:_photoSetID];
    
        photoSet = FLConfirmResultType([request sendSynchronouslyInContext:self.context], FLZfPhotoSet);
    }
    return photoSet;
}

- (FLZfPhoto*) _loadLatestPhoto:(FLZfPhoto*) photo {
	
    FLZfPhoto* inCache = [[self.context cacheService] loadPhotoWithID:photo.IdValue];
    
    if(inCache && ![inCache isStaleComparedToPhoto:photo]) {
        return inCache;
    }
    
    return FLConfirmResultType([[FLZfHttpRequest loadPhotoHttpRequest:photo.Id
                                                            level:kZfInformatonLevelFull] sendSynchronouslyInContext:self.context], FLZfPhoto);
}

- (FLResult) runOperation {

    FLZfPhotoSet* photoSet = [self _loadLatestPhotoSet];
    
    if(photoSet.PhotoCountValue == 0) {
        FLZfSyncState* tgElement = [[self.context syncService] syncStateForGroupElementId:photoSet.Id];
        tgElement.isSyncedValue = YES;
        tgElement.lastSyncDate = [NSDate date];
        [[self.context syncService] saveSyncState:tgElement];
    }
    else if(_syncPhotos) {
        for(FLZfPhoto* photo in photoSet.Photos) {
            [self _syncPhoto:[self _loadLatestPhoto:photo] inPhotoSet:photoSet];
        }
        
   		FLZfSyncState* tgElement = [[self.context syncService] syncStateForGroupElementId:photoSet.Id];
		tgElement.isSyncedValue = YES;
		tgElement.lastSyncDate = [NSDate date];
		[[self.context syncService] saveSyncState:tgElement];
	}
    
    [[self.context cacheService] savePhotoSet:photoSet];

    return photoSet;
}

@end
