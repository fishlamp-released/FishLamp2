//
//  FLDispatchQueue.m
//  FishLampCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDispatchQueues.h"

#import "NSObject+FLSelectorPerforming.h"
#import "FLWorkFinisher.h"
#import "FLFallible.h"

static void * const s_queue_key = (void*)&s_queue_key;

@interface FLDispatchFinisher : FLWorkFinisher {
@private
    FLDispatchQueue* _queue;
}
@property (readwrite, strong) FLDispatchQueue* queue;

- (id) initWithCompletionBlock:(FLResultBlock) completion queue:(FLDispatchQueue*) queue;
+ (id) dispatchFinisher:(FLResultBlock) completion queue:(FLDispatchQueue*) queue;

@end

@implementation FLDispatchFinisher 
@synthesize queue = _queue;

- (id) initWithCompletionBlock:(FLResultBlock) completion queue:(FLDispatchQueue*) queue{
    
    self = [super initWithCompletionBlock:completion];
    if(self) {
        self.queue = queue;
    }
    return self;
}

+ (id) dispatchFinisher:(FLResultBlock) completion queue:(FLDispatchQueue*) queue {
    return FLReturnAutoreleased([[[self class] alloc] initWithCompletionBlock:completion queue:queue]);
}

#if FL_NO_ARC
- (void) dealloc {
    [_queue release];
    [super dealloc];
}
#endif

- (void) setFinishedWithResult:(FLResult) result {
    
    if(!self.queue || self.queue == [FLDispatchQueue currentQueue]) {
        [super setFinishedWithResult:result];
    }
    else {
        [self.queue dispatchBlock:^{
            [super setFinishedWithResult:result];
            }];
    }
}

@end

@implementation FLDispatchQueue

FLSynthesizeSingleton(FLDispatchQueue);

- (id) init {
    self = [super init];
    if(self) {
        dispatch_queue_set_specific([self dispatchQueue], s_queue_key, (__bridge void*) self, nil);
    }

    return self;
}

- (void) dealloc {
    dispatch_queue_set_specific([self dispatchQueue], s_queue_key, nil, nil);


#if FL_NO_ARC
    [super dealloc];
#endif
}

+ (FLDispatchQueue*) currentQueue {
    return (__bridge FLDispatchQueue*) dispatch_queue_get_specific(dispatch_get_current_queue(), s_queue_key);
}

- (dispatch_queue_t) dispatchQueue {
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

- (FLPromisedResult) dispatchAsyncBlock:(FLAsyncBlock) block {
    return [self dispatchAsyncBlock:block completion:nil];
}

- (FLPromisedResult) dispatchBlock:(void (^)()) block {
    return [self dispatchBlock:block completion:nil];
}

- (FLPromisedResult) dispatchBlock:(void (^)()) block
                        completion:(FLResultBlock) completion {
    
    FLWorkFinisher* finisher = [FLDispatchFinisher dispatchFinisher:completion queue:self];

    block = FLCopyBlock(block);

    dispatch_async([self dispatchQueue], ^{
        @try {
            if(block) {
                block(finisher);
            }
            [finisher setFinished];
        }
        @catch(NSException* ex) {
            [finisher setFinishedWithError:ex.error]; 
        }
    });

    return finisher;
}

- (FLPromisedResult) dispatchAsyncBlock:(FLAsyncBlock) block
                        completion:(FLResultBlock) completion {
    
    FLWorkFinisher* finisher = [FLDispatchFinisher dispatchFinisher:completion queue:self];

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

- (FLPromisedResult) dispatchWorker:(id<FLWorker>) aWorker {
    return [self dispatchWorker:aWorker completion:nil];
}

- (FLPromisedResult) dispatchWorker:(id<FLWorker>) aWorker
                    completion:(FLResultBlock) completion {
    
    FLWorkFinisher* finisher = [FLDispatchFinisher dispatchFinisher:completion queue:self];

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
    
#if FL_NO_ARC
    [super dealloc];
#endif
}
@end

