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

@interface FLOperation ()
@property (readwrite, copy, nonatomic) FLRunOperationBlock runBlock;
@property (readwrite, assign) BOOL wasStarted;
@property (readwrite, assign) BOOL isFinished;
@property (readwrite, assign) BOOL didFail;
@property (readwrite, assign) BOOL wasCancelled;
@property (readwrite, strong) id input;
@property (readwrite, strong) id output;
@property (readwrite, assign) id context;
@end

@implementation FLOperation

synthesize_(operationID);
synthesize_(tag);
synthesize_(predicate);
synthesize_(runBlock);
synthesize_(disabled);
synthesize_(error);
synthesize_(wasStarted);
synthesize_(isFinished);
synthesize_(didFail);
synthesize_(wasCancelled);
synthesize_(context);

@synthesize input = _operationInput;
@synthesize output = _operationOutput;

- (void) removeFromContext:(id) context {
    self.context = nil;
}

- (void) addToContext:(id) context {
    self.context = context;
}

- (id) initWithRunBlock:(FLRunOperationBlock) callback {
    if((self = [self init])) {
        self.runBlock = callback;
    }
    return self;
}

+ (id) operation:(FLRunOperationBlock) callback {
    return autorelease_([[[self class] alloc] initWithRunBlock:callback]);
}

dealloc_ (
    [_error release];
    [_operationInput release];;
    [_operationOutput release];
    [_runBlock release];
    [_operationID release];
	[_predicate release];
)

//- (FLOperationType) operationType {
//    return FLOperationTypeNormal;
//}

- (id) init {
	if((self = [super init])) {
  		static int32_t s_counter = 0;
        self.operationID = [NSNumber numberWithInt:FLAtomicIncrement32(s_counter)];
    }
	
	return self;
}

- (id) initWithInput:(id) input {
    self = [super init];
    if(self) {
        self.operationInput = input;
    }
    return self;
}

+ (id) operationWithInput:(id) input {
    return autorelease_([[[self class] alloc] initWithInput:input]);
}

- (NSError*) error  {
    
    NSError* error = nil;
    @synchronized(self) {
        if(!_error && self.wasCancelled) {
            FLRetainObject_(_error, [NSError cancelError]);
        }
        error = _error;
    }
    return error;
}

- (void) setError:(NSError*) error  {
    
    @synchronized(self) {
        FLRetainObject_(_error, error);
        
        if(_error) {
            self.didFail = YES;
            
            if(_error.isCancelError) {
                self.wasCancelled = YES;
            }
        }
        else {
            self.didFail = NO;
        }

        FLTraceIf(_error && !_error.isCancelError, @"operation got error:%@", [_error description]);
    }
}

- (BOOL) didSucceed {
    return self.isFinished && !self.didFail && !self.wasCancelled;
}

- (BOOL) didRun {
    return self.wasStarted && self.isFinished;
}

+ (id) operation {
	return autorelease_([[[self class] alloc] init]);
}

- (void) cancelSelf {
}

- (BOOL) canCancel {
    return !self.wasCancelled && !self.didSucceed && !self.didFail && !self.didRun;
}

- (void) requestCancel {
    BOOL shouldCancel = NO;
    if([self canCancel] ) {
        @synchronized(self) {
            if([self canCancel]) {
                shouldCancel = YES;
                self.wasCancelled = YES;
            }
        }
    }
    if(shouldCancel) {
        [self cancelSelf];
        [self postObservation:@selector(operationWasCancelled:)];
    }
}

- (void) runSelf {
}

- (BOOL) willRun {
   return   !self.wasCancelled &&
            !self.didFail &&
            !self.isFinished &&
            !self.isDisabled &&
            (!_predicate || [_predicate isSatisfiedByObject:self]);
}

- (BOOL) isBusy {
    return FLAtomicGet32(_busy) > 0;
}

- (void) setMoreBusy {
    if(FLAtomicIncrement32(_busy) == 1) {
        [self postObservation:@selector(operationBusyStateDidChange:)];
    }
}

- (void) setLessBusy {
    if(FLAtomicDecrement32(_busy) == 0) {
        [self postObservation:@selector(operationBusyStateDidChange:)];
    }
}

- (void) prepareSelf {

}

- (void) finishSelf {

}

- (FLFinisher*) startWorking:(FLFinisher*) finisher {

    @try {
        if(finisher.input) {
            self.input = finisher.input;
        }
        
        [self setMoreBusy];
       
        [self resetRunStateIfNeeded];

        if(self.willRun) {
            [self postObservation:@selector(operationWillRun:)];
        }
    
        if(self.willRun) {
            self.wasStarted = YES;
            [self prepareSelf];
        }
        
        if(self.willRun) {
            if(self.runBlock) {
                self.runBlock(self);
            }
            else {
                [self runSelf];
            }
        }
    }
    @catch(NSException* ex) {
        self.error = ex.error;
    }

    @try {
        [self finishSelf];  
    }
    @catch(NSException* ex) {
        self.error = ex.error;
    }
    
    [self setLessBusy];
    self.isFinished = YES;

    if(!self.error) {
        [finisher setFinishedWithOutput:self.operationOutput];
    }
    else {
        [finisher setFinishedWithError:self.error];
    }    
    
    [self postObservation:@selector(operationDidFinish:)];
    
    return finisher;
}

- (FLFinisher*) runSynchronouslyWithInput:(id) input {
    FLFinisher* finisher = [FLFinisher finisher];
    finisher.input = input;
    [self startWorking:finisher];
    return finisher;
}

- (FLFinisher*) runSynchronously {
    return [self runSynchronouslyWithInput:nil];
}

//- (id<FLPromisedResult>) start:(FLFinisher*) completion {
////    FLFinisher* finisher = [FLFinisher finisher:completion];
//    [finisher startWorker:self];
//    return finisher;
//}

- (void) _resetState {
    self.error = nil;
    self.wasStarted = NO;
    self.isFinished = NO;
    self.didFail = NO;
}

- (void) resetRunState {
    [self _resetState];
}

- (void) resetRunStateIfNeeded {
    if(self.wasStarted) {
        [self _resetState];
    }
}

//- (void) observeStart:(FLOperationBlock) block {
//    [self addObserver:[FLOperationWillStartObserver operationObserver:block]];
//}
//
//- (void) observeFinish:(FLOperationBlock) block {
//    [self addObserver:[FLOperationDidFinishObserver operationObserver:block]];
//}

- (void) operationWasCancelled:(FLOperation*) operation {
    [self requestCancel];
}

- (void) _finishSubOperation:(FLOperation*) operation {
}

- (void) runSubOperation:(FLOperation*) operation
               withBlock:(void (^)()) block {
    
    [self addObserver:operation];
    [operation addObserver:self];
    
    if(operation.context == nil) {
        [operation addToContext:self.context];
    }
    @try {
        if(block) {
            block();
        }
        else {
            [operation runSynchronously];
        }
        
        [operation throwAbortIfFailed];
    }
    @catch(FLAbortException* ex) {
        @throw;
    }
    @catch(NSException* ex) {
        operation.error = ex.error;
        @throw;
    }
    @finally {
        [self removeObserver:operation];
        [operation removeObserver:self];
        
        if(operation.error) {
            self.error = operation.error;
        }
    }
}

- (void) runSubOperation:(FLOperation*) operation {
    [self runSubOperation:operation withBlock:nil];
}


- (void) throwAbortIfFailed {
    if(self.didFail || self.wasCancelled) {
        @throw [FLAbortException abortException];
    }
}

- (id) operationOutput {
    return self.output;
}

- (void) setOperationOutput:(id) output {
    self.output = output;
}

- (id) operationInput {
    return self.input;
}

- (void) setOperationInput:(id) input {
    self.input = input;
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
//    return autorelease_([[[self class] alloc] initWithBlock:block]);
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
