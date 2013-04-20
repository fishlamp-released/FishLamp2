//
//  ZFAsyncGroupPhotoSetDownloader.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/20/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFAsyncGroupPhotoSetDownloader.h"
#import "FLAsyncOperationQueueOperation.h"
#import "ZFAsyncPhotoSetDownloader.h"

@implementation ZFAsyncGroupPhotoSetDownloader

- (id) initWithGroup:(ZFGroup*) group {	
	self = [super init];
	if(self) {
		_group = FLRetain(group);
	}
	return self;
}

#if FL_MRC
- (void) dealloc {
	[_group release];
	[super dealloc];
}
#endif

+ (id) asyncGroupPhotoSetDownloader:(ZFGroup*) group {
    return FLAutorelease([[[self class] alloc] initWithGroup:group]);
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
/*
            [group replaceElement:set];
            
            [self sendObservation:@selector(photoSetDownloader:didDownloadPhotoSet:) withObject:set];
*/

- (void) finishedDownloadingPhotoSets:(FLAsyncOperationQueueOperation*) operation 
                           withResult:(FLResult) result {
    [self setFinishedWithResult:result];
}

- (void) asyncOperationQueueOperation:(FLAsyncOperationQueueOperation*) queue 
                   didFinishOperation:(id) operation 
                           withResult:(FLResult) result {

    if(![result error]) {
        [self sendObservation:@selector(asyncGroupPhotoSetDownloader:didDownloadPhotoSet:) withObject:result];
    }
}

- (void) performUntilFinished:(FLFinisher*) finisher {

    [super performUntilFinished:finisher];

    NSMutableArray* photoSets = [NSMutableArray array];
    [self addPhotoSetsToList:photoSets forGroup:_group];
    
    FLAsyncOperationQueueOperation* loadPhotoSets = [FLAsyncOperationQueueOperation asyncOperationQueue:photoSets];
    loadPhotoSets.delegate = self;
    loadPhotoSets.finishedSelectorForDelegate = @selector(finishedDownloadingPhotoSets:withResult:);
    
    loadPhotoSets.operationFactory = ^(id object) {
        return [ZFAsyncPhotoSetDownloader downloadPhotoSet:object];
    };
    
    [self runChildAsynchronously:loadPhotoSets];
}


@end
