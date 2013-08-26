//
//  FLAsyncEvent+FLDispatchQueue.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 8/25/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAsyncEvent+FLDispatchQueue.h"
#import "FLDispatchQueue.h"
#import "FLFinisher.h"
#import "FLPromise.h"
#import "FLOperation.h"

@implementation FLAsyncEvent (FLDispachQueue)

- (void) performWithFinisher:(FLFinisher*) finisher inQueue:(id<FLAsyncQueue>) queue {
}

- (FLPromise*) dispatchAsyncInQueue:(FLDispatchQueue*) queue
                         completion:(fl_completion_block_t) completion {

    FLFinisher* finisher = self.finisher;
    FLPromise* promise = [finisher addPromiseWithBlock:completion];

    fl_block_t block = ^{
        @try {
            [self performWithFinisher:finisher inQueue:queue];
        }
        @catch(NSException* ex) {
            [finisher setFinishedWithResult:ex.error];
        }
    };

    NSTimeInterval delay = self.delay;
    if(delay) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (delay * NSEC_PER_SEC)), queue.dispatch_queue_t, block);
    }
    else {
        dispatch_async(queue.dispatch_queue_t, block);
    }

    return promise;
}

- (FLPromisedResult) dispatchSyncInQueue:(FLDispatchQueue*) queue {

    FLFinisher* finisher = self.finisher;
    FLPromise* promise = [finisher addPromise];

    fl_block_t block = ^{
        @try {
            [self performWithFinisher:finisher inQueue:queue];
        }
        @catch(NSException* ex) {
            [finisher setFinishedWithResult:ex.error];
        }
    };

    dispatch_sync(queue.dispatch_queue_t, block);

    return promise.result;
}


@end

@implementation FLBlockEvent (FLDispatchQueue)
- (void) performWithFinisher:(FLFinisher*) finisher inQueue:(id<FLAsyncQueue>) queue {
    if(self.block) {
        self.block();
    }
    [finisher setFinished];
}
@end

@implementation FLFinisherBlockEvent (FLDispatchQueue)
- (void) performWithFinisher:(FLFinisher*) finisher inQueue:(id<FLAsyncQueue>) queue {
    if(self.block) {
        self.block(finisher);
    }
}
@end

@implementation FLOperationEvent (FLDispatchQueue)

- (void) performWithFinisher:(FLFinisher*) finisher inQueue:(id<FLAsyncQueue>) queue {
    [self.operation startInQueue:queue];
}

- (FLFinisher*) finisher {
    return [self.operation finisher];
}

@end

