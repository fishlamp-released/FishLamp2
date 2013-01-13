//
//  FLOperation.m
//  FishLamp
//
//	Created by Mike Fullerton on 8/28/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLOperation.h"
#import "FLTraceOff.h"
#import "FLFinisher.h"
#import "FLDispatchQueue.h"

NSString* const FLOperationFinishedEvent;

@interface FLOperation ()
@property (readwrite, copy, nonatomic) FLRunOperationBlock runBlock;
@property (readwrite, assign, getter=wasCancelled) BOOL cancelled;
@property (readwrite, assign) FLOperation* parent;
@property (readwrite, strong) id context;

@end

@implementation FLOperation

@synthesize operationID = _operationID;
@synthesize runBlock = _runBlock;
@synthesize cancelled = _cancelled;
@synthesize context = _context;
@synthesize parent = _parent;

- (id) initWithRunBlock:(FLRunOperationBlock) callback {
    if((self = [self init])) {
        self.runBlock = callback;
    }
    return self;
}

+ (id) operation:(FLRunOperationBlock) callback {
    return FLAutorelease([[[self class] alloc] initWithRunBlock:callback]);
}

#if FL_MRC
- (void) dealloc {
    [_context release];
    [_runBlock release];
    [_operationID release];
    [super dealloc];
}
#endif

- (id) init {
	if((self = [super init])) {
  		static int32_t s_counter = 0;
        self.operationID = [NSNumber numberWithInt:FLAtomicIncrement32(s_counter)];
    }
	
	return self;
}

+ (id) operation {
	return FLAutorelease([[[self class] alloc] init]);
}

- (void) requestCancel {
    self.cancelled = YES;
}

- (FLResult) runOperation {
    return FLSuccessfullResult;
}

- (void) abortIfNeeded {
    FLThrowAbortExeptionIf(self.wasCancelled);
}

- (BOOL) abortNeeded {
    return self.wasCancelled;
}

- (void) startWorking:(FLFinisher*) finisher {
    self.cancelled = NO;
    id result = nil;
    
    @try {
        [self postObservation:@selector(operationWillRun:)];
        
        if(self.runBlock) {
            result = self.runBlock(self);
        }
        else {
            result = [self runOperation];
        }
    }
    @catch(NSException* ex) {
        result = ex.error;
    }
    
    if(self.wasCancelled) {
        result = [NSError cancelError];
    }
    
    [self postObservation:@selector(operationDidFinish:withResult:) withObject:result];

    [finisher setFinishedWithResult:result];
    [self.context operationDidFinish:self];
}

- (void) operationWasCancelled:(FLOperation*) operation {
    [self requestCancel];
}

- (void) didMoveToContext:(id)context {
    self.context = context;
}

- (FLResult) runSynchronouslyInContext:(id) context {
    [self didMoveToContext:context];
    [self.context operationDidStart:self];
    
    FLFinisher* finisher = [FLFinisher finisher];
    [self startWorking:finisher];
    return [finisher waitUntilFinished];
}

// async operations will run in:
// 1. dispatcher provided by context
// 2. global default dispatcher (FLDefaultDispatcher)
- (FLFinisher*) startOperationInContext:(id) context 
                             completion:(FLCompletionBlock) completion {
                             
    [self didMoveToContext:context];
    [self.context operationDidStart:self];
    
    id<FLDispatching> dispatcher = nil;
    
    if([self.context respondsToSelector:@selector(operationDispatcher:)]) {
        dispatcher = [self.context operationDispatcher:self];
    }
    
    if(!dispatcher) {
        dispatcher = FLDefaultDispatcher;
    }
    
    return [dispatcher dispatchObject:self completion:completion];
}





@end

//
//@interface FLOperationObserver ()
//@property (readwrite, copy, nonatomic) FLOperationObserverBlock block;
//@end
//
//@implementation FLOperationObserver
//
//synthesize_(block = _block;
//
//- (id) initWithBlock:(FLOperationObserverBlock) block {
//    self = [super init];
//    if(self) {
//        self.block = block;
//    }
//    return self;
//}
//
//+ (id) operationObserver:(FLOperationObserverBlock) block {
//    return FLAutorelease([[[self class] alloc] initWithBlock:block]);
//}
//
//#if FL_MRC
//- (void) dealloc {
//    [_block release];
//    [super dealloc];
//}
//#endif
//
//- (void) invokeBlockWithOperation:(FLOperation*) operation {
//    if(_block) {
//        _block(operation);
//    }
//}
//@end
//
//@implementation FLOperationWillStartObserver
//- (void) operationWillRun:(FLOperation*) operation {
//    [self invokeBlockWithOperation:operation];
//}
//@end
//
//@implementation FLOperationDidFinishObserver
//- (void) operationDidFinish:(FLOperation*) operation {
//    [self invokeBlockWithOperation:operation];
//}
//@end

//
//@implementation FLOperation (Deprecated)
//
//
//@end
