//
//  ZFBatchPhotoSetDownloader.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/20/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFBatchPhotoSetDownloader.h"
#import "FLAsyncOperationQueue.h"
#import "ZFPhotoSetDownloader.h"

@implementation ZFBatchPhotoSetDownloader

- (id) initWithGroup:(ZFGroup*) group  withPhotos:(BOOL) withPhotos{	
	self = [self initWithPhotoSets:nil withPhotos:withPhotos];
	if(self) {
		_group = FLRetain(group);
	}
	return self;
}

- (id) initWithPhotoSets:(NSArray*) photoSets  withPhotos:(BOOL) withPhotos{
    self = [super initWithQueuedObjects:photoSets];
    if(self) {
        _withPhotos = withPhotos;
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
	[_group release];
	[super dealloc];
}
#endif

+ (id) batchPhotoSetDownloaderForGroup:(ZFGroup*) group  withPhotos:(BOOL) withPhotos{
    return FLAutorelease([[[self class] alloc] initWithGroup:group withPhotos:withPhotos]);
}

+ (id) batchPhotoSetDownloader:(NSArray*) arrayOfPhotoSetIDs  withPhotos:(BOOL) withPhotos{
    return FLAutorelease([[[self class] alloc] initWithPhotoSets:arrayOfPhotoSetIDs withPhotos:withPhotos]);
}

- (void) addPhotoSetsToList:(NSMutableArray*) array forGroup:(ZFGroup*) group {

    for(ZFGroupElement* element in group.Elements) {
        if(element.isGroupElement) {
            [self addPhotoSetsToList:array forGroup:(ZFGroup*) element ];
        }
        else {
            [array addObject:[element Id]];
        }
    }    
}

- (void) didFinishOperation:(FLOperation*) operation withResult:(FLResult) result {
    [super didFinishOperation:operation withResult:result];
    
    if(![result error]) {
        if(_group) {
            [_group replaceElement:result];
        }
    }
    FLPerformSelector2(self.delegate, @selector(batchPhotoSetDownloader:didDownloadPhotoSetWithResult:), self, result);
}

- (FLOperation*) createOperationForObject:(id) object {
    return [ZFPhotoSetDownloader downloadPhotoSet:object withPhotos:NO];
}

- (void) performUntilFinished:(FLFinisher*) finisher {

    [super performUntilFinished:finisher];

    if(_group) {
        NSMutableArray* photoSets = [NSMutableArray array];
        [self addPhotoSetsToList:photoSets forGroup:_group];
        [self addObjectsFromArray:photoSets];
    }
}


@end
