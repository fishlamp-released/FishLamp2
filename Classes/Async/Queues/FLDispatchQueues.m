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

//@interface FLDispatchFinisher : FLFinisher {
//@private
//    FLDispatchQueue* _queue;
//}
//@property (readwrite, strong) FLDispatchQueue* queue;
//
//- (id) initWithAsyncBlock:(FLAsyncBlock) completion queue:(FLDispatchQueue*) queue;
//+ (id) dispatchFinisher:(FLAsyncBlock) completion queue:(FLDispatchQueue*) queue;
//
//@end
//
//@implementation FLDispatchFinisher 
//@synthesize queue = _queue;
//
//- (id) initWithAsyncBlock:(FLAsyncBlock) completion queue:(FLDispatchQueue*) queue{
//    
//    self = [super initWithAsyncBlock:completion];
//    if(self) {
//        self.queue = queue;
//    }
//    return self;
//}
//
//+ (id) dispatchFinisher:(FLAsyncBlock) completion queue:(FLDispatchQueue*) queue {
//    return autorelease_([[[self class] alloc] initWithAsyncBlock:completion queue:queue]);
//}
//
//#if FL_MRC
//- (void) dealloc {
//    [_queue release];
//    [super dealloc];
//}
//#endif
//
//- (void) setFinishedWithResult:(FLFinisher*) result {
//    
//    if(!self.queue || self.queue == [FLDispatchQueue currentQueue]) {
//        [super setFinishedWithResult:result];
//    }
//    else {
//        [self.queue dispatchBlock:^{
//            [super setFinishedWithResult:result];
//            }];
//    }
//}
//
//@end

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

- (void) rescheduleWorkFinisher:(FLFinisher*) finisher {
}

+ (FLDispatchQueue*) currentQueue {
    return bridge_(FLDispatchQueue*, dispatch_queue_get_specific(dispatch_get_current_queue(), s_queue_key));
}

- (dispatch_queue_t) dispatchQueue {
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

- (FLFinisher*) dispatchAsyncBlock:(FLAsyncBlock) block {
    return [self dispatchAsyncBlock:block finisher:[FLFinisher finisher]];
}

- (FLFinisher*) dispatchBlock:(void (^)()) block {
    return [self dispatchBlock:block finisher:[FLFinisher finisher]];
}

- (FLFinisher*) dispatchBlock:(void (^)()) block
                        finisher:(FLFinisher*) finisher {
    
    FLAssertNotNil_(block);
    FLAssertNotNil_(finisher);
    
    [self rescheduleWorkFinisher:finisher];

    block = FLCopyBlock(block);

    dispatch_async([self dispatchQueue], ^{
        @try {
            if(block) {
                block();
            }
            [finisher setFinished];
        }
        @catch(NSException* ex) {
            [finisher setFinishedWithError:ex.error]; 
        }
    });

    return finisher;
}



- (FLFinisher*) dispatchAsyncBlock:(FLAsyncBlock) block
                        finisher:(FLFinisher*) finisher {
    
    FLAssertNotNil_(block);
    FLAssertNotNil_(finisher);
    
    [self rescheduleWorkFinisher:finisher];

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
            [finisher setFinishedWithError:ex.error]; 
        }
        
    });

    return finisher;
}

- (FLFinisher*) dispatchWorker:(id<FLWorker>) aWorker {
    return [self dispatchWorker:aWorker finisher:[FLFinisher finisher]];
}

- (FLFinisher*) dispatchWorker:(id<FLWorker>) aWorker
                         finisher:(FLFinisher*) finisher {
    
    FLAssertNotNil_(aWorker);
    FLAssertNotNil_(finisher);
    
    [self rescheduleWorkFinisher:finisher];

    dispatch_async([self dispatchQueue],  
    ^{
        @try {
            [aWorker startWorking:finisher];
        }
        @catch(NSException* ex) {
            [finisher setFinishedWithError:ex.error];
        }
    });

    return finisher;

}

@end

@implementation FLHighPriorityQueue
- (dispatch_queue_t) dispatchQueue {
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
}
FLSynthesizeSingleton(FLHighPriorityQueue);

@end

@implementation FLActionQueue

- (void) rescheduleWorkFinisher:(FLFinisher*) finisher {
    
    finisher.notificationScheduler = ^(FLFinisher* theFinisher) {
        if(![NSThread isMainThread]) {
            [((id) theFinisher) performSelectorOnMainThread:@selector(setFinished) withObject:nil waitUntilDone:NO];
        }
        else {
            [ theFinisher setFinished];
        }
    };
}

- (dispatch_queue_t) dispatchQueue {
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
}

FLSynthesizeSingleton(FLActionQueue);

@end

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

