//
//  FLWorkerContext.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLWorkerContext.h"
#import "FLAsyncQueue.h"
#import "FLDispatch.h"

NSString* const FLWorkerContextStarting = @"FLWorkerContextStarting";
NSString* const FLWorkerContextFinished = @"FLWorkerContextFinished";

NSString* const FLWorkerContextClosed = @"FLWorkerContextClosed";
NSString* const FLWorkerContextOpened = @"FLWorkerContextOpened"; 

@interface FLWorkerContext ()
@property (readwrite, assign, getter=isContextOpen) BOOL contextOpen; 
@property (readwrite, assign) NSUInteger contextID;
@end

@implementation FLWorkerContext
@synthesize asyncQueue = _asyncQueue;
@synthesize contextOpen = _contextOpen;
@synthesize contextID = _contextID;

- (id) init {
    self = [super init];
    if(self) {
        _objects = [[NSMutableSet alloc] init];
        self.asyncQueue = [FLAsyncQueue fifoQueue];
    }
    
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_objects release];
    [super dealloc];
}
#endif

+ (id) workerContext {
    return FLAutorelease([[[self class] alloc] init]);
}

- (FLFinisher*) visitObjects:(FLDispatchableObjectVisitor) visitor
                  completion:(FLBlockWithResult) completion {

    visitor = FLCopyWithAutorelease(visitor);

    return [self.asyncQueue queueBlock:^{
        
        BOOL stop = NO;
        for(id worker in _objects) {
            visitor(worker, &stop);
            
            if(stop) {
                break;
            }
        }
        
    } 
    completion:completion];
}

- (FLFinisher*) visitObjects:(FLDispatchableObjectVisitor) visitor {
    return [self visitObjects:visitor completion:nil];
}

- (void) openContext {
    self.contextID++;
    self.contextOpen = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:FLWorkerContextOpened object:self];
}

- (void) requestCancel {
    NSArray* toCancel = nil;
    @synchronized(self) {
        toCancel = FLAutorelease([_objects copy]);
    }
    for(id worker in toCancel) {
        FLPerformSelector(worker, @selector(requestCancel));
    }
}

- (void) closeContext {
    self.contextOpen = NO;
    [self requestCancel];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:FLWorkerContextClosed object:self];
}

- (void) openService:(id)opener {
    [super openService:opener];
    
    [self openContext];
}

- (void) closeService:(id)closer {
    [super closeService:closer];
    
    [self closeContext];;
}

- (void) didAddWorker:(id) object {
}

- (void) didRemoveWorker:(id) object {
}

- (void) didStartWorking {
    [[NSNotificationCenter defaultCenter] postNotificationName:FLWorkerContextStarting object:self];
}

- (void) didStopWorking {
    [[NSNotificationCenter defaultCenter] postNotificationName:FLWorkerContextFinished object:self];
}

- (void) addObject:(id) worker  {
    
    @synchronized(self) {
        if(_objects.count == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self didStartWorking];
            });
        }
    
        [_objects addObject:worker];
        [worker didMoveToContext:self];
        
        if(!self.isContextOpen) {
            [worker requestCancel];
        }
    }

    [self didAddWorker:worker];
}

- (void) removeObject:(id) worker {
    @synchronized(self) {
        [_objects removeObject:worker];
        [worker didMoveToContext:nil];

        if(_objects.count == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self didStopWorking];
            });
        }
    }
    [self didRemoveWorker:worker];
}

- (FLResult) runWorker:(id<FLContextWorker>) worker 
          withObserver:(id) observer {

    FLFinisher* finisher = [FLFinisher finisher];
    finisher.observer = observer;
    
    @try {
        [self addObject:worker];
        
        [worker startWorking:finisher];
    }
    @catch(NSException* ex) {
        [finisher setFinishedWithResult:ex.error];
    }
    @finally {
        [self removeObject:worker];
    }

    id result = [finisher waitUntilFinished];
    FLAssertNotNil_v(result, @"result should not be nil!!");

    return result;
}

//- (FLFinisher*) startWorker:(id<FLContextWorker>) worker
//                  inDispatcher:(id<FLAsyncQueue>) asyncQueue
//                  withObserver:(id) observer 
//                    completion:(FLBlockWithResult) completion {
//
//    FLAssertNotNil_(worker);
//
//    completion = FLCopyWithAutorelease(completion);
//
//    FLFinisher* finisher = [FLFinisher finisher:^(FLResult result) {
//    
//        if(completion) {
//            completion(result);
//        }
//    
//        [self removeObject:worker];
//    }];
//
//    finisher.observer = observer;
//    
//    FLBlockWithFinisher block = ^(FLFinisher* theFinisher){
//        
//        @try {
//            [worker startWorking:finisher];
//        }
//        @catch(NSException* ex) {
//            [theFinisher setFinishedWithResult:ex.error];
//        }
//    };
//
//    [self addObject:worker];
//    
//    [asyncQueue queueFinishableBlock:block withFinisher:finisher];
//    
//    return finisher;
//}

- (void) startWorker:(id<FLContextWorker>) worker withObserver:(id) observer completion:(FLBlockWithResult) completion {
    FLFinisher* finisher = [FLFinisher finisher:completion];
    finisher.observer = observer;
    [self startWorker:worker withFinisher:finisher];
}

- (void) startWorker:(id<FLContextWorker>) worker withFinisher:(FLFinisher*) finisher {

    FLAssertNotNil_(worker);

    [self addObject:worker];
    
    id<FLAsyncQueue> asyncQueue = worker.asyncQueue;
    if(!asyncQueue) {
        asyncQueue = [FLAsyncQueue defaultQueue];
    }
    
    [asyncQueue queueFinishableBlock:^(FLFinisher* theFinisher) {
        
        @try {
            [worker startWorking:theFinisher];
        }
        @catch(NSException* ex) {
            [theFinisher setFinishedWithResult:ex.error];
        }

        [self removeObject:worker];

    }
    withFinisher:finisher];
}

//- (FLFinisher*) startWorker:(id<FLContextWorker>) worker withObserver:(id) observer {
//    return [self startWorker:worker inDispatcher:[FLAsyncQueue defaultQueue] withObserver:observer completion:nil];
//}
//
//- (void) startWorker:(id<FLContextWorker>) worker withObserver:(id) observer withFinisher:(FLFinisher*) finisher {
//    [self startWorker:worker inDispatcher:worker.asyncQueue withObserver:observer completion:^(FLResult result) {
//        [finisher setFinishedWithResult:result];
//    }];
//}   
//
//- (void) startWorker:(id<FLContextWorker>) worker withObserver:(id) observer completion:(FLBlockWithResult) completion {
//    [self startWorker:worker inDispatcher:worker.asyncQueue withObserver:observer completion:completion];
//}

   
@end

//@implementation FLExecutable
//
//@synthesize workerContext = _workScheduler;
//
//- (void) startWorking:(FLFinisher*) finisher {
//    [finisher setFinished];
//}
//
////- (void) didMoveToAsyncWorkerContext:(FLContextWorkerContext*) context {
////    self.context = context;
////}
//
////- (void) setExecutionContext:(id<FLWorkerContext>) workerContext {
////    @synchronized(self) {
////        if(_workScheduler == workerContext) {
////            return;
////        }
////        id prev = _workScheduler;
////        _workScheduler = nil;
////
////        if(prev) {
////            [prev removeObject:self];
////        }
////        
////        if(workerContext) {
////            [workerContext addObject:self];
////            _workScheduler = workerContext;
////        }
////    }
////}
////
////- (id<FLWorkerContext>) workerContext {
////    @synchronized(self) {
////        return _workScheduler;
////    }
////}
//
//@end
