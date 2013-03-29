//
//  FLOperationContext.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLOperationContext.h"
#import "FLAsyncQueue.h"
#import "FLDispatch.h"
#import "FLDispatchQueue.h"
#import "FLAsyncQueue.h"
#import "FLOperation.h"

NSString* const FLWorkerContextStarting = @"FLWorkerContextStarting";
NSString* const FLWorkerContextFinished = @"FLWorkerContextFinished";

NSString* const FLWorkerContextClosed = @"FLWorkerContextClosed";
NSString* const FLWorkerContextOpened = @"FLWorkerContextOpened"; 

@interface FLOperationContext ()
@property (readwrite, assign, getter=isContextOpen) BOOL contextOpen; 
@property (readwrite, assign) NSUInteger contextID;
@end

@implementation FLOperationContext
@synthesize contextOpen = _contextOpen;
@synthesize contextID = _contextID;

- (id) init {
    self = [super init];
    if(self) {
        _operations = [[NSMutableSet alloc] init];
        _asyncQueue = [[FLFifoAsyncQueue alloc] init];
        _contextOpen = YES;
    }
    
    return self;
}

- (void) dealloc {
    [_asyncQueue releaseToPool];
#if FL_MRC
    [_operations release];
    [super dealloc];
#endif
}

+ (id) operationContext {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) visitOperations:(FLOperationVisitor) visitor {

    visitor = FLCopyWithAutorelease(visitor);
    
    FLDispatchSync(_asyncQueue, ^{
        BOOL stop = NO;
        for(id operation in _operations) {
            visitor(operation, &stop);
            
            if(stop) {
                break;
            }
        }
    });
    
}

- (void) requestCancel {

    FLDispatchSync(_asyncQueue, ^{
        for(id operation in _operations) {
            FLPerformSelector(operation, @selector(requestCancel));
        }
    });
}

- (void) openContext {

    self.contextID++;
    
    [self visitOperations:^(id operation, BOOL *stop) {
        [operation contextDidOpen];
    }];

    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:FLWorkerContextOpened object:self];
    });
}


- (void) closeContext {
    [self visitOperations:^(id operation, BOOL *stop) {
        [operation contextDidOpen];
    }];

    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:FLWorkerContextClosed object:self];
    });
}

- (void) didAddOperation:(id) object {
}

- (void) didRemoveOperation:(id) object {
}

- (void) didStartWorking {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:FLWorkerContextStarting object:self];
    });
}

- (void) didStopWorking {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:FLWorkerContextFinished object:self];
    });
}

- (void) addOperation:(FLOperation*) operation  {
    
    FLDispatchSync(_asyncQueue, ^{
       
        BOOL wasIdle = _operations.count == 0;
       
        [_operations addObject:operation];
         
        FLOperationContext* oldContext = operation.context;
        if(oldContext && oldContext != self) {
            [operation.context removeOperation:operation];
        }
        [operation wasAddedToContext:self];
        
        [self didAddOperation:operation];

        if(wasIdle) {
            [self didStartWorking];
        }

        if(!self.isContextOpen) {
            [operation requestCancel];
        }
    });
}

- (void) removeOperation:(FLOperation*) operation {

    FLDispatchSync(_asyncQueue, ^{
        [_operations removeObject:operation];
        [operation wasRemovedFromContext:self];

        if(_operations.count == 0) {
            [self didStopWorking];
        }
        [self didRemoveOperation:operation];
    });
}

//- (FLResult) runChildSynchronously:(id<FLOperation>) operation {
//
//    FLFinisher* finisher = [FLFinisher finisher];
//    
//    @try {
//        [self addObject:operation];
//        
//        [operation runAsynchronously:finisher];
//    }
//    @catch(NSException* ex) {
//        [finisher setFinishedWithResult:ex.error];
//    }
//    @finally {
//        [self removeObject:operation];
//    }
//
//    id result = [finisher waitUntilFinished];
//    FLAssertNotNilWithComment(result, @"result should not be nil!!");
//    FLThrowIfError(result);
//
//    return result;
//}

//- (FLFinisher*) startWorker:(id<FLOperation>) operation
//                  inDispatcher:(id<FLAsyncQueue>) asyncQueue
//                  withObserver:(id) observer 
//                    completion:(fl_result_block_t) completion {
//
//    FLAssertNotNil(operation);
//
//    completion = FLCopyWithAutorelease(completion);
//
//    FLFinisher* finisher = [FLFinisher finisher:^(FLResult result) {
//    
//        if(completion) {
//            completion(result);
//        }
//    
//        [self removeObject:operation];
//    }];
//
//    finisher.observer = observer;
//    
//    fl_finisher_block_t block = ^(FLFinisher* theFinisher){
//        
//        @try {
//            [operation runAsynchronously:finisher];
//        }
//        @catch(NSException* ex) {
//            [theFinisher setFinishedWithResult:ex.error];
//        }
//    };
//
//    [self addObject:operation];
//    
//    [asyncQueue queueFinishableBlock:block withFinisher:finisher];
//    
//    return finisher;
//}

//- (FLFinisher*) startWorker:(id<FLOperation>) operation 
//               withObserver:(id) observer 
//                 completion:(fl_result_block_t) completion {
//    FLFinisher* finisher = [FLFinisher finisher:completion];
//    [self queueWorker:operation withFinisher:finisher];
//    return finisher;
//}
//
//- (void) queueWorker:(id<FLOperation>) operation withFinisher:(FLFinisher*) finisher {
//
//    FLAssertNotNil(operation);
//
//    [self addObject:operation];
//    
//    id<FLAsyncQueue> asyncQueue = operation.asyncQueue;
//    if(!asyncQueue) {
//        asyncQueue = [FLAsyncQueue defaultQueue];
//    }
//    
//    [asyncQueue queueFinishableBlock:^(FLFinisher* theFinisher) {
//        
//        @try {
//            [operation runAsynchronously:theFinisher];
//        }
//        @catch(NSException* ex) {
//            [theFinisher setFinishedWithResult:ex.error];
//        }
//
//        [self removeObject:operation];
//
//    }
//    withFinisher:finisher];
//}
//
//- (FLFinisher*) queueWorker:(id<FLOperation>) operation 
//                 completion:(fl_result_block_t) completion {
//   FLFinisher* finisher = [FLFinisher finisher:completion];
//   [self queueWorker:operation withFinisher:finisher];
//   return finisher;                 
//}                 
//
//   
@end



