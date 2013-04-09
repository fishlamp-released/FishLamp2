//
//  ZFBatchMovePhotosOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFBatchMovePhotosOperation.h"
#import "ZFCacheService.h"

@interface ZFBatchMovePhotosOperation ()
@property (readwrite, strong, nonatomic) ZFPhotoSet* sourcePhotoSet;
@property (readwrite, strong, nonatomic) ZFPhotoSet* destPhotoSet;
@end

@implementation ZFBatchMovePhotosOperation

@synthesize sourcePhotoSet = _parentPhotoSet;
@synthesize destPhotoSet = _destPhotoSet;

- (id) initWithPhotoArray:(NSArray*) photos
               moveFromPhotoSet:(ZFPhotoSet*) moveFrom
                 moveToPhotoSet:(ZFPhotoSet*) moveTo {

    self = [super init];
    if(self) {
        self.sourcePhotoSet = moveFrom;
        self.destPhotoSet = moveTo;
        [self addBatchObjects:photos];
    }
    
    return self;
}

+ (id) batchMovePhotosOperation:(NSArray*) photos
               moveFromPhotoSet:(ZFPhotoSet*) moveFrom
                 moveToPhotoSet:(ZFPhotoSet*) moveTo {
    return FLAutorelease([[[self class] alloc] initWithPhotoArray:photos moveFromPhotoSet:moveFrom moveToPhotoSet:moveTo]);
    
}


- (void) dealloc
{
	FLRelease(_parentPhotoSet);
	FLRelease(_destPhotoSet);
	FLSuperDealloc();
}

- (void) processBatchObject:(id) object {

#if REFACTOR
    FLSynchronousOperation* operation = nil;

	if(_destPhotoSet.TypeValue == ZFPhotoSetTypeGallery) {
        operation = [[self httpRequestFactory] movePhotoOperation:photo fromPhotoSet:_parentPhotoSet toPhotoSet:_destPhotoSet];
    }
	else {
        operation = [ZFHttpRequestFactory addPhotoToCollectionOperation:photo collection:_destPhotoSet];
    }
    
    FLThrowIfError([operation runChildSynchronously:self.userContext]);

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