//
//  FLZenfolioBatchMovePhotosOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioBatchMovePhotosOperation.h"
#import "FLZenfolioCacheService.h"

@interface FLZenfolioBatchMovePhotosOperation ()
@property (readwrite, strong, nonatomic) FLZenfolioPhotoSet* sourcePhotoSet;
@property (readwrite, strong, nonatomic) FLZenfolioPhotoSet* destPhotoSet;
@end

@implementation FLZenfolioBatchMovePhotosOperation

@synthesize sourcePhotoSet = _parentPhotoSet;
@synthesize destPhotoSet = _destPhotoSet;

- (id) initWithPhotoArray:(NSArray*) photos
               moveFromPhotoSet:(FLZenfolioPhotoSet*) moveFrom
                 moveToPhotoSet:(FLZenfolioPhotoSet*) moveTo {

    self = [super init];
    if(self) {
        self.sourcePhotoSet = moveFrom;
        self.destPhotoSet = moveTo;
        [self addBatchObjects:photos];
    }
    
    return self;
}

+ (id) batchMovePhotosOperation:(NSArray*) photos
               moveFromPhotoSet:(FLZenfolioPhotoSet*) moveFrom
                 moveToPhotoSet:(FLZenfolioPhotoSet*) moveTo {
    return FLAutorelease([[[self class] alloc] initWithPhotoArray:photos moveFromPhotoSet:moveFrom moveToPhotoSet:moveTo]);
    
}


- (void) dealloc
{
	FLRelease(_parentPhotoSet);
	FLRelease(_destPhotoSet);
	FLSuperDealloc();
}

- (void) processBatchObject:(id) object inContext:(id) context withObserver:(id) observer {

#if REFACTOR
    FLOperation* operation = nil;

	if(_destPhotoSet.TypeValue == FLZenfolioPhotoSetTypeGallery) {
        operation = [[self httpRequestFactory] movePhotoOperation:photo fromPhotoSet:_parentPhotoSet toPhotoSet:_destPhotoSet];
    }
	else {
        operation = [FLZenfolioHttpRequest addPhotoToCollectionOperation:photo collection:_destPhotoSet];
    }
    
    FLThrowError([operation runSynchronouslyInContext:self.userContext]);

    _destPhotoSet.PhotoCountValue = _destPhotoSet.PhotoCountValue + 1;
    [_destPhotoSet addPhoto:photo];
    [[[self.userContext objectCache] cacheDatabase] writeObject:_destPhotoSet];
    
    if(_parentPhotoSet && _parentPhotoSet.isGalleryElement) {
        [_parentPhotoSet removePhoto:photo forceCountDecrement:YES];
        [[[self.userContext objectCache] cacheDatabase] writeObject:_parentPhotoSet];
    }
#endif    
}

@end
