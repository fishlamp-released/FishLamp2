//
//  FLZfBatchMovePhotosOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZfBatchMovePhotosOperation.h"
#import "FLZfCacheService.h"

@interface FLZfBatchMovePhotosOperation ()
@property (readwrite, strong, nonatomic) FLZfPhotoSet* sourcePhotoSet;
@property (readwrite, strong, nonatomic) FLZfPhotoSet* destPhotoSet;
@end

@implementation FLZfBatchMovePhotosOperation

@synthesize sourcePhotoSet = _parentPhotoSet;
@synthesize destPhotoSet = _destPhotoSet;

- (id) initWithPhotoArray:(NSArray*) photos
               moveFromPhotoSet:(FLZfPhotoSet*) moveFrom
                 moveToPhotoSet:(FLZfPhotoSet*) moveTo {

    self = [super init];
    if(self) {
        self.sourcePhotoSet = moveFrom;
        self.destPhotoSet = moveTo;
        [self addBatchObjects:photos];
    }
    
    return self;
}

+ (id) batchMovePhotosOperation:(NSArray*) photos
               moveFromPhotoSet:(FLZfPhotoSet*) moveFrom
                 moveToPhotoSet:(FLZfPhotoSet*) moveTo {
    return FLAutorelease([[[self class] alloc] initWithPhotoArray:photos moveFromPhotoSet:moveFrom moveToPhotoSet:moveTo]);
    
}


- (void) dealloc
{
	FLRelease(_parentPhotoSet);
	FLRelease(_destPhotoSet);
	FLSuperDealloc();
}

- (void) processBatchObject:(FLZfPhoto*) photo {

//    FLOperation* operation = nil;
//
//	if(_destPhotoSet.TypeValue == FLZfPhotoSetTypeGallery) {
//        operation = [[self httpRequestFactory] movePhotoOperation:photo fromPhotoSet:_parentPhotoSet toPhotoSet:_destPhotoSet];
//    }
//	else {
//        operation = [FLZfHttpRequest addPhotoToCollectionOperation:photo collection:_destPhotoSet];
//    }
//    
//    FLThrowError([operation runSynchronouslyInContext:self.context]);
//
//    _destPhotoSet.PhotoCountValue = _destPhotoSet.PhotoCountValue + 1;
//    [_destPhotoSet addPhoto:photo];
//    [[[self.context cacheService] cacheDatabase] saveObject:_destPhotoSet];
//    
//    if(_parentPhotoSet && _parentPhotoSet.isGalleryElement) {
//        [_parentPhotoSet removePhoto:photo forceCountDecrement:YES];
//        [[[self.context cacheService] cacheDatabase] saveObject:_parentPhotoSet];
//    }
}

@end
