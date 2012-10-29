//
//  FLBackgroundQueue.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/7/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLFifoQueue.h"
#import "NSObject+FLSelectorPerforming.h"

@interface FLAsyncQueue ()
+ (dispatch_queue_t) dispatchQueue;
@end

@implementation FLAsyncQueue

+ (dispatch_queue_t) dispatchQueue {
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
}

+ (id) addWorkerBlock:(FLWorkerBlock) block {
    return [self addWorkerBlock:block completion:nil];
}

+ (id) addWorkerBlock:(FLWorkerBlock) block
                completion:(FLCompletionBlock) completion {
    
    FLFinisher* finisher = [FLFinisher finisher:completion];

    block = FLCopyBlock(block);

    dispatch_async([self dispatchQueue], ^{
        @try {
            if(block) {
                block(finisher);
            }
            else {
                [finisher setFinished];
            }
        }
        @catch(NSException* ex) {
            [finisher setFinishedWithResult:[FLAsyncResult resultWithError:ex.error]];
        }
        
    });

    return finisher;
}

+ (id) addWorker:(id<FLWorker>) aWorker {
    return [self addWorker:aWorker];
}

+ (id) addWorker:(id<FLWorker>) aWorker
                 completion:(FLCompletionBlock) completion {
    
    FLFinisher* finisher = [FLFinisher finisher:completion];

    dispatch_async([self dispatchQueue],  ^{
        @try {
            [aWorker startWorking:finisher];
        }
        @catch(NSException* ex) {
            [((id)aWorker) performIfRespondsToSelector:@selector(handleAsyncWorkerError:) withObject:ex.error];
            [finisher setFinishedWithResult:[FLAsyncResult resultWithError:ex.error]];
        }
    });

    return finisher;

}

@end

@interface FLFifoQueue ()
@property (readonly, assign) dispatch_queue_t queue;
@end

@implementation FLFifoQueue

FLSynthesizeSingleton(FLFifoQueue);

@synthesize queue = _queue;

+ (dispatch_queue_t) dispatchQueue {
    return self.instance.queue;
}

- (id) init {
    self = [super init];
    if(self) {
        _queue = dispatch_queue_create("com.fishlamp.queue.fifo", DISPATCH_QUEUE_SERIAL);
    }
    
    return self;
}

- (void) dealloc {
      dispatch_release(_queue);
    
#if FL_NO_ARC
    [super dealloc];
#endif
}

//+ (id) addWorkerBlock:(FLWorkerBlock) block {
//    return [FLFifoQueue addWorkerBlock:block completion:nil];
//}
//
//+ (id) addWorkerBlock:(FLWorkerBlock) block completion:(dispatch_block_t) completion {
//    block = FLCopyBlock(block);
//    FLFinisher* finisher = [FLFinisher finisher:completion];
//    
//    dispatch_async([FLFifoQueue instance].queue, ^{
//        @try {
//            if(block) {
//                block(finisher);
//            }
//            else {
//                [finisher setFinished];
//            }
//        }
//        @catch(NSException* ex) {
//            [finisher setFinished];
//        }
//    });
//    
//    return finisher;
//}
//
//+ (id) addWorker:(id<FLWorker>) aWorker
//                 completion:(FLCompletionBlock) completion {
// 
//    FLFinisher* finisher = [FLFinisher finisher:completion];
//
//    dispatch_async([FLFifoQueue instance].queue, ^{
//        @try {
//            [aWorker startWorking:finisher];
//
////            // since it's a FIFO thread, we'll have to block the queue until we're done.
////            [finisher waitForResult];
//        }
//        @catch(NSException* ex) {
//            [((id)aWorker) performIfRespondsToSelector:@selector(handleAsyncWorkerError:) withObject:ex.error];
//            [finisher setFinished];
//        }
//    });
//
//    return finisher;
//}
//


@end

@implementation FLForegroundQueue
+ (dispatch_queue_t) dispatchQueue {
    return dispatch_get_main_queue();
}
@end

//@implementation FLAsyncQueue
//@end
