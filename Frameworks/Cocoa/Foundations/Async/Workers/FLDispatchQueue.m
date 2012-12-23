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

- (FLFinisher*) dispatchBlock:(dispatch_block_t) block {
    return [self dispatchBlock:block completion:nil];
}

- (FLFinisher*) dispatchBlock:(dispatch_block_t) block 
                completion:(FLCompletionBlock) completion {

    FLFinisher* finisher = [FLScheduledFinisher finisherWithResultBlock:completion];

    FLAssertNotNil_(block);
    FLAssertNotNil_(finisher);

    dispatch_async(_dispatch_queue, ^{
        @try {
            if(block) {
                block();
            }
            [finisher setFinished];
        }
        @catch(NSException* ex) {
            [finisher setFinishedWithResult:ex.error];
        }
    });

    return finisher;
}

- (FLFinisher*) dispatchFinishableBlock:(FLFinishableBlock) block {
    return [self dispatchFinishableBlock:block completion:nil];
}

- (FLFinisher*) dispatchFinishableBlock:(FLFinishableBlock) block 
                       completion:(FLCompletionBlock) completion {

    FLFinisher* finisher = [FLScheduledFinisher finisherWithResultBlock:completion];

    FLAssertNotNil_(block);
    FLAssertNotNil_(finisher);

    dispatch_async(_dispatch_queue, ^{
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

#pragma mark -- async dispatcher

- (FLFinisher*) dispatchAsync:(id) dispatchableObject {
    return [self dispatchAsync:dispatchableObject completion:nil];
}

- (FLFinisher*) dispatchAsync:(id) dispatchableObject 
                   completion:(FLCompletionBlock) completion {

    FLAssertNotNil_(dispatchableObject);

    return [self dispatchFinishableBlock:^(FLFinisher* finisher) {
        [dispatchableObject startAsync:finisher];
    }
    completion:completion];
}

#pragma mark -- object dispatcher 

- (FLFinisher*) dispatchSynchronousObject:(id) object {
    
    return [self dispatchFinishableBlock:^(FLFinisher *finisher) {
        [finisher setFinishedWithResult:[object runSynchronously]];
    }];
}

- (FLFinisher*) dispatchSynchronousObject:(id) object
                     withInput:(id) input {
    return [self dispatchFinishableBlock:^(FLFinisher *finisher) {
        [finisher setFinishedWithResult:[object runSynchronouslyWithInput:input]];
    }];
}

- (FLFinisher*) dispatchSynchronousObject:(id) object
                   completion:(FLCompletionBlock) completion {

    return [self dispatchFinishableBlock:^(FLFinisher *finisher) {
        [finisher setFinishedWithResult:[object runSynchronously]];
    }
    completion:completion];
}

- (FLFinisher*) dispatchSynchronousObject:(id) object
                    withInput:(id) input
                   completion:(FLCompletionBlock) completion {
    
    return [self dispatchFinishableBlock:^(FLFinisher *finisher) {
        [finisher setFinishedWithResult:[object runSynchronouslyWithInput:input]];
    }
    completion:completion];
}

#pragma mark -- selector dispatcher

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector {
    return [self dispatchBlock:^{
        FLPerformSelector(target, selector);
    }];
}

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object {
    return [self dispatchBlock:^{
        FLPerformSelector1(target, selector, object);
    }];
}

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object1
                    withObject:(id) object2 {
    return [self dispatchBlock:^{
        FLPerformSelector2(target, selector, object1, object2);
    }];
}

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object1
                    withObject:(id) object2
                    withObject:(id) object3 {
    return [self dispatchBlock:^{
        FLPerformSelector3(target, selector, object1, object2, object3);
    }];
}

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    completion:(FLCompletionBlock) completion {
    return [self dispatchBlock:^{
        FLPerformSelector(target, selector);
    }
    completion:completion];
}

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object
                    completion:(FLCompletionBlock) completion {
    return [self dispatchBlock:^{
        FLPerformSelector1(target, selector, object);
    }
    completion:completion];

}

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object1
                    withObject:(id) object2
                    completion:(FLCompletionBlock) completion {
    return [self dispatchBlock:^{
        FLPerformSelector2(target, selector, object1, object2);
    }
    completion:completion];

}

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object1
                    withObject:(id) object2
                    withObject:(id) object3
                    completion:(FLCompletionBlock) completion {

    return [self dispatchBlock:^{
        FLPerformSelector3(target, selector, object1, object2, object3);
    }
    completion:completion];
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


