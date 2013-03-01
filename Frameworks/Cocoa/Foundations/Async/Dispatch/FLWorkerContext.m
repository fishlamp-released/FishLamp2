//
//  FLWorkerContext.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLWorkerContext.h"
#import "FLGcdDispatcher.h"
#import "FLDispatch.h"

NSString* const FLWorkerContextStarting = @"FLWorkerContextStarting";
NSString* const FLWorkerContextFinished = @"FLWorkerContextFinished";

@implementation FLWorkerContext
@synthesize dispatcher = _dispatcher;

- (id) init {
    self = [super init];
    if(self) {
        _objects = [[NSMutableSet alloc] init];
        self.dispatcher = [FLGcdDispatcher sharedFifoQueue];
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

    return [self.dispatcher dispatchBlock:^{
        
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

- (void) requestCancel {
    
    NSArray* toCancel = nil;
    @synchronized(self) {
        toCancel = FLAutorelease([_objects copy]);
    }
    for(id worker in toCancel) {
        FLPerformSelector(worker, @selector(requestCancel));
    }
}

- (void) addObject:(id) worker  {
    
    @synchronized(self) {
        if(_objects.count == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:FLWorkerContextStarting object:self];
            });
        }
    
        [_objects addObject:worker];
    }
}

- (void) removeObject:(id) worker {
    @synchronized(self) {
        [_objects removeObject:worker];

        if(_objects.count == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:FLWorkerContextFinished object:self];
            });
        }
    }
}

- (FLResult) runWorker:(id<FLAsyncWorker>) worker 
                 withObserver:(id) observer {

    FLFinisher* finisher = [FLFinisher finisher];
    @try {
        [self addObject:worker];
        
        [worker startWorkingInContext:self withObserver:observer finisher:finisher];
    }
    @catch(NSException* ex) {
        [finisher setFinishedWithResult:ex.error];
    }
    @finally {
        [self removeObject:worker];
    }

    return FLThrowIfError([[finisher waitUntilFinished] result]);
}

- (FLFinisher*) startWorker:(id<FLAsyncWorker>) worker
                  inDispatcher:(id<FLDispatcher>) dispatcher
                  withObserver:(id) observer 
                    completion:(FLBlockWithResult) completion {

    FLAssertNotNil_(worker);

    FLSafeguardBlock(completion);

    FLFinisher* finisher = [FLFinisher finisher:^(FLResult result) {
    
        if(completion) {
            completion(result);
        }
    
        [self removeObject:worker];
    }];

    FLBlockWithFinisher block = ^(FLFinisher* theFinisher){
        
        @try {
            [worker startWorkingInContext:self withObserver:observer finisher:theFinisher];
        }
        @catch(NSException* ex) {
            [theFinisher setFinishedWithResult:ex.error];
        }
    };

    [self addObject:worker];
    
    [dispatcher dispatchFinishableBlock:block withFinisher:finisher];
    
    return finisher;
}

- (FLFinisher*) startWorker:(id<FLAsyncWorker>) worker withObserver:(id) observer {
    return [self startWorker:worker inDispatcher:[FLGcdDispatcher sharedDefaultQueue] withObserver:observer completion:nil];
}
   
@end

//@implementation FLExecutable
//
//@synthesize workerContext = _workScheduler;
//
//- (void) startWorking:(FLFinisher*) finisher {
//    [finisher setFinished];
//}
//
////- (void) didMoveToAsyncWorkerContext:(FLAsyncWorkerContext*) context {
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
