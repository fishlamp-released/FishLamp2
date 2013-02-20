//
//  FLExecutionContext.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLExecutionContext.h"
#import "FLGcdDispatcher.h"
#import "FLDispatch.h"

@implementation FLExecutionContext
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

+ (id) context {
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
    
    [self.dispatcher dispatchBlock:^{
        for(id worker in _objects) {
            FLPerformSelector(worker, @selector(requestCancel));
        }
    }];
    
}

- (void) addObject:(id) worker {
    [self.dispatcher dispatchBlock:^{
        [_objects addObject:worker];
    }];
}

- (void) removeObject:(id) worker {
    [self.dispatcher dispatchBlock:^{
        [_objects removeObject:worker];
    }];
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
        [self removeObject:worker];
    }
    return [finisher result];
}

- (FLFinisher*) scheduleWorker:(id<FLAsyncWorker>) worker
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
   
@end

//@implementation FLExecutable
//
//@synthesize executionContext = _executionContext;
//
//- (void) startWorking:(FLFinisher*) finisher {
//    [finisher setFinished];
//}
//
////- (void) didMoveToAsyncWorkerContext:(FLAsyncWorkerContext*) context {
////    self.context = context;
////}
//
////- (void) setExecutionContext:(id<FLExecutionContext>) executionContext {
////    @synchronized(self) {
////        if(_executionContext == executionContext) {
////            return;
////        }
////        id prev = _executionContext;
////        _executionContext = nil;
////
////        if(prev) {
////            [prev removeObject:self];
////        }
////        
////        if(executionContext) {
////            [executionContext addObject:self];
////            _executionContext = executionContext;
////        }
////    }
////}
////
////- (id<FLExecutionContext>) executionContext {
////    @synchronized(self) {
////        return _executionContext;
////    }
////}
//
//@end
