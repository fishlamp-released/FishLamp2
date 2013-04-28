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
#import "ZFAsyncObserving.h"

@implementation ZFBatchPhotoSetDownloader

- (id) initWithGroup:(ZFGroup*) group  withPhotos:(BOOL) withPhotos{	
	self = [self initWithPhotoSets:nil withPhotos:withPhotos];
	if(self) {
		_group = [group copy];
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

- (void) sendStartMessagesWithInitialData:(id) initialData {
    [self.observer receiveObservation:@selector(willDownloadPhotoSetBatch)];
}

- (void) sendFinishMessagesWithResult:(FLPromisedResult) result {
    [self.delegate receiveMessage:@selector(didDownloadPhotoSetBatchWithResult:) withObject:result];
    [self.observer receiveObservation:@selector(didDownloadPhotoSetBatchWithResult:) withObject:result];
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

- (void) willStartOperation:(id)operation withQueuedObject:(id)object  {
    [super willStartOperation:operation withQueuedObject:object];
    
    [self.delegate receiveMessage:@selector(batchPhotoSetDownloader:willDownloadPhotoSet:) withObject:self withObject:nil];
}

- (void) didFinishOperation:(id)operation withQueuedObject:(id)object withResult:(FLPromisedResult)result {
    [super didFinishOperation:operation withQueuedObject:object withResult:result];
    
    if(![result error]) {
        if(_group) {
            [_group replaceElement:result];
        }
    }
    [self.delegate receiveMessage:@selector(batchPhotoSetDownloader:didDownloadPhotoSetWithResult:) withObject:self withObject:result];
}

- (FLOperation*) createOperationForObject:(id) object {
    return [ZFPhotoSetDownloader downloadPhotoSet:object withPhotos:_withPhotos];
}

- (id) startAsyncOperation {
 
    if(_group) {
        NSMutableArray* photoSets = [NSMutableArray array];
        [self addPhotoSetsToList:photoSets forGroup:_group];
        [self addObjectsFromArray:photoSets];
    }
    
    [self startProcessing];
    
    return nil;
}

- (id) resultForFinisher {
    return _group;
}

- (void) didProcessAllObjectsInAsyncQueue {
    if(_group) {
        [self.finisher setFinishedWithResult:_group];
    }
    else {
        [self.finisher setFinished];
    }
}


@end