//
//  FLDispatchQueue.m
//  FishLampCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDispatchQueues.h"

#import "NSObject+FLSelectorPerforming.h"
#import "FLFinisher.h"
#import "FLFallible.h"

static void * const s_queue_key = (void*)&s_queue_key;

@implementation FLDispatchQueue

FLSynthesizeSingleton(FLDispatchQueue);

- (id) init {
    self = [super init];
    if(self) {
        dispatch_queue_set_specific([self dispatchQueue], s_queue_key, bridge_(void*, self), nil);
    }

    return self;
}

- (void) dealloc {
    dispatch_queue_set_specific([self dispatchQueue], s_queue_key, nil, nil);


#if FL_MRC
    [super dealloc];
#endif
}

+ (FLDispatchQueue*) currentQueue {
    return bridge_(FLDispatchQueue*, dispatch_queue_get_specific(dispatch_get_current_queue(), s_queue_key));
}

- (dispatch_queue_t) dispatchQueue {
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

+ (FLFinisher*) dispatchBlock:(dispatch_block_t) block {
    return [self.instance dispatchBlock:block finisher:nil];
}

+ (FLFinisher*) dispatchBlock:(dispatch_block_t) block 
                     finisher:(FLFinisher*) finisher {
    return [self.instance dispatchBlock:block finisher:finisher];
}

+ (FLFinisher*) dispatch:(FLAsyncTaskBlock) block {
    return [self.instance dispatch:block finisher:nil];
}

+ (FLFinisher*) dispatch:(FLAsyncTaskBlock) block 
                     finisher:(FLFinisher*) finisher {
    return [self.instance dispatch:block finisher:finisher];
}

- (FLFinisher*) dispatchBlock:(dispatch_block_t) block {
    return [self dispatchBlock:block finisher:[FLFinisher finisher]];
}

- (FLFinisher*) dispatchBlock:(dispatch_block_t) block 
                finisher:(FLFinisher*) finisher {

    block = FLCopyBlock(block);
    
    return [self dispatch:^(id asyncResult) {
        if(block) {
            block();
        }
        [asyncResult setFinished];
    }];
    
    return finisher;
}

- (FLFinisher*) dispatch:(FLAsyncTaskBlock) block {
    return [self dispatch:block finisher:[FLFinisher finisher]];
}

- (FLFinisher*) dispatch:(FLAsyncTaskBlock) block 
                finisher:(FLFinisher*) finisher {

    FLAssertNotNil_(block);
    FLAssertNotNil_(finisher);
    
    if([NSThread isMainThread]) {
        finisher.notificationScheduler = ^(dispatch_block_t finishBlock) {
            if(![NSThread isMainThread]) {
                [self performBlockOnMainThread:finishBlock];
            }
            else {
                finishBlock();
            }
        };    
    }
    
    dispatch_async([self dispatchQueue], ^{
        @try {
            if(block) {
                block(finisher);
            }
        }
        @catch(NSException* ex) {
            [finisher setFinishedWithResult:ex.error];
        }
    });

    return finisher;
}



//- (FLFinisher*) dispatch:(id<FLWorker>) aWorker {
//    return [self dispatch:aWorker finisher:[FLFinisher finisher]];
//}
//
//- (FLFinisher*) dispatch:(id<FLWorker>) aWorker 
//                finisher:(FLFinisher*) finisher {
//
//    FLAssertNotNil_(aWorker);
//    FLAssertNotNil_(finisher);
//    
//    if([NSThread isMainThread]) {
//        finisher.notificationScheduler = ^(dispatch_block_t finishBlock) {
//            if(![NSThread isMainThread]) {
//                [self performBlockOnMainThread:finishBlock];
//            }
//            else {
//                finishBlock();
//            }
//        };    
//    }
//    
//    dispatch_async([self dispatchQueue],  
//    ^{
//        @try {
//            [aWorker startWorking:finisher];
//        }
//        @catch(NSException* ex) {
//            [finisher setFinishedWithResult:ex.error];
//        }
//    });
//
//    return finisher;
//}

@end

@implementation FLHighPriorityQueue
- (dispatch_queue_t) dispatchQueue {
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
}
FLSynthesizeSingleton(FLHighPriorityQueue);

@end

//@implementation FLActionQueue
//
//- (void) rescheduleWorkFinisher:(FLFinisher*) finisher {
//    
//    finisher.notificationScheduler = ^(dispatch_block_t finishBlock) {
//        if(![NSThread isMainThread]) {
//            [self performBlockOnMainThread:finishBlock];
//        }
//        else {
//            finishBlock();
//        }
//    };
//}
//
//- (dispatch_queue_t) dispatchQueue {
//    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
//}
//
//FLSynthesizeSingleton(FLActionQueue);
//
//@end

@implementation FLForegroundQueue

- (dispatch_queue_t) dispatchQueue {
    return dispatch_get_main_queue();
}

FLSynthesizeSingleton(FLForegroundQueue);

@end

@implementation FLBackgroundQueue
- (dispatch_queue_t) dispatchQueue {
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
}
FLSynthesizeSingleton(FLBackgroundQueue);

@end

@implementation FLLowPriorityQueue
- (dispatch_queue_t) dispatchQueue {
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
}
FLSynthesizeSingleton(FLLowPriorityQueue);

@end

@interface FLFifoQueue ()
@property (readonly, assign) dispatch_queue_t fifo_queue;
@end

@implementation FLFifoQueue

FLSynthesizeSingleton(FLFifoQueue);

@synthesize fifo_queue = _fifo_queue;

- (dispatch_queue_t) dispatchQueue {
    return self.fifo_queue;
}

- (id) init {
    self = [super init];
    if(self) {
        _fifo_queue = dispatch_queue_create("com.fishlamp.queue.fifo", DISPATCH_QUEUE_SERIAL);
    }
    
    return self;
}

- (void) dealloc {
      dispatch_release(_fifo_queue);
    
#if FL_MRC
    [super dealloc];
#endif
}
@end

