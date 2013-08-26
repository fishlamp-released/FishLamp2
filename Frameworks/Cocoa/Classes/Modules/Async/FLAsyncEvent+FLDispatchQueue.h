//
//  FLAsyncEvent+FLDispatchQueue.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 8/25/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAsyncEvent.h"
#import "FLAsyncBlockTypes.h"

@class FLDispatchQueue;
@class FLPromise;
@protocol FLAsyncQueue;

@interface FLAsyncEvent (FLDispatchQueue)
- (FLPromise*) dispatchAsyncInQueue:(FLDispatchQueue*) queue
                    completion:(fl_completion_block_t) completion;

- (FLPromisedResult) dispatchSyncInQueue:(FLDispatchQueue*) queue;

- (void) performWithFinisher:(FLFinisher*) finisher
                     inQueue:(id<FLAsyncQueue>) queue;

@end