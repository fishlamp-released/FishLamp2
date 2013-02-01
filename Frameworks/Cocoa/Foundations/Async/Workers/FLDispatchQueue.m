//
//  FLDispatchQueue.m
//  FLCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDispatchQueue.h"

#import "NSObject+FLSelectorPerforming.h"
#import "FLFinisher.h"

static void * const s_queue_key = (void*)&s_queue_key;



@implementation FLDispatchQueue

@synthesize dispatch_queue_t = _dispatch_queue;
@synthesize label = _label;

- (id) initWithDispatchQueue:(dispatch_queue_t) queue {
    if(!queue) {
        return nil;
    }
    
    self = [super init];
    if(self) {
        _dispatch_queue = queue;
        dispatch_retain(_dispatch_queue);
        dispatch_queue_set_specific(_dispatch_queue, s_queue_key, bridge_(void*, self), nil);
        _label = [[NSString alloc] initWithCString:dispatch_queue_get_label(_dispatch_queue) encoding:NSASCIIStringEncoding];
    }
    return self;
}

- (id) initWithLabel:(NSString*) label  
                attr:(dispatch_queue_attr_t) attr {

    dispatch_queue_t queue = dispatch_queue_create([label cStringUsingEncoding:NSASCIIStringEncoding], attr);
    if(!queue) {
        return nil;
    }
    @try {
        self = [self initWithDispatchQueue:queue];
    }
    @finally {
        dispatch_release(queue);
    }

    return self;
}

+ (FLDispatchQueue*) dispatchQueue:(dispatch_queue_t) queue {
    return FLAutorelease([[[self class] alloc] initWithDispatchQueue:queue]);
}

+ (FLDispatchQueue*) dispatchQueueWithLabel:(NSString*) label attr:(dispatch_queue_attr_t) attr {
    return FLAutorelease([[[self class] alloc] initWithLabel:label attr:attr]);
}

+ (FLDispatchQueue*) fifoDispatchQueue:(NSString*) label {
    return FLAutorelease([[[self class] alloc] initWithLabel:label attr:DISPATCH_QUEUE_SERIAL]);
}

+ (FLDispatchQueue*) concurrentDispatchQueue:(NSString*) label {
    return FLAutorelease([[[self class] alloc] initWithLabel:label attr:DISPATCH_QUEUE_CONCURRENT]);
}

- (void) dealloc {
    if(_dispatch_queue) {
        dispatch_queue_set_specific(_dispatch_queue, s_queue_key, nil, nil);
        dispatch_release(_dispatch_queue);
    }
    
#if FL_MRC
    [_label release];
    [super dealloc];
#endif
}

+ (FLDispatchQueue*) currentQueue {
    return bridge_(FLDispatchQueue*, dispatch_queue_get_specific(dispatch_get_current_queue(), s_queue_key));
}



- (void) dispatchBlockWithDelay:(NSTimeInterval) delay
                          block:(FLDispatcherBlock) block 
                   withFinisher:(FLFinisher*) finisher {

    [finisher setWillBeDispatchedByDispatcher:self];
 
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (delay * NSEC_PER_SEC)), _dispatch_queue, ^{
        @try {
            [finisher setWillStartInDispatcher:self];
            
            if(block) {
                block();
            }
            [finisher setFinished];
        }
        @catch(NSException* ex) {
            [finisher setFinishedWithResult:ex.error];
        }
    });
}                                 


- (void) dispatchBlock:(FLDispatcherBlock) block 
          withFinisher:(FLFinisher*) finisher {

    [finisher setWillBeDispatchedByDispatcher:self];
    
    dispatch_async(_dispatch_queue, ^{
        @try {
            [finisher setWillStartInDispatcher:self];
            
            if(block) {
                block();
            }
            [finisher setFinished];
        }
        @catch(NSException* ex) {
            [finisher setFinishedWithResult:ex.error];
        }
    });
}

- (void) dispatchFinishableBlock:(FLDispatcherFinisherBlock) block 
                    withFinisher:(FLFinisher*) finisher {
    
    [finisher setWillBeDispatchedByDispatcher:self];

    dispatch_async(_dispatch_queue, ^{
        @try {
            [finisher setWillStartInDispatcher:self];
            
            if(block) {
                block(finisher);
            }
        }
        @catch(NSException* ex) {
            [finisher setFinishedWithResult:ex.error];
        }
    });
}

+ (void)sleepForTimeInterval:(NSTimeInterval)milliseconds {
    
    if([NSThread isMainThread]) {
        NSTimeInterval timeout = [NSDate timeIntervalSinceReferenceDate] + milliseconds;
        while([NSDate timeIntervalSinceReferenceDate] < timeout) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate date]];
        }
    } 
    else {
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        dispatch_semaphore_wait(semaphore, 
                                dispatch_time(DISPATCH_TIME_NOW, (milliseconds * NSEC_PER_MSEC)));
        dispatch_release(semaphore);
    } 
}    



@end

@implementation FLDispatchQueue (SystemQueues)

+ (FLDispatchQueue*) sharedLowPriorityQueue {
    FLReturnStaticObject( [[FLDispatchQueue alloc] initWithDispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)]);
}
+ (FLDispatchQueue*) sharedDefaultQueue {
    FLReturnStaticObject( [[FLDispatchQueue alloc] initWithDispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)]);
}
+ (FLDispatchQueue*) sharedHighPriorityQueue {
    FLReturnStaticObject([[FLDispatchQueue alloc] initWithDispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)]);
}
+ (FLDispatchQueue*) sharedBackgroundQueue {
    FLReturnStaticObject([[FLDispatchQueue alloc] initWithDispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)]);
}
+ (FLDispatchQueue*) sharedForegroundQueue {
    FLReturnStaticObject([[FLDispatchQueue alloc] initWithDispatchQueue:dispatch_get_main_queue()]);
}
@end

@implementation FLFifoDispatchQueue  

+ (id) fifoDispatchQueue {
    return FLAutorelease([[[self class] alloc] init]);
}

- (id) init {
    static int s_count = 0;
    return [super initWithLabel:[NSString stringWithFormat:@"com.fishlamp.queue.fifo%d", s_count++] attr:DISPATCH_QUEUE_SERIAL];
}

+ (FLDispatchQueue*) sharedFifoQueue {
    FLReturnStaticObject([[FLFifoDispatchQueue alloc] init]);
}

+ (FLObjectPool*) pool {
    static FLObjectPoolFactory s_factory = ^{
        return [FLFifoDispatchQueue fifoDispatchQueue];
    };

    FLReturnStaticObject([[FLObjectPool alloc] initWithObjectFactory:s_factory]); 
}


@end


