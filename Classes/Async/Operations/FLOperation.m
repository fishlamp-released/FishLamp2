//
//  FLOperation.m
//  FishLamp
//
//	Created by Mike Fullerton on 8/28/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLOperation.h"
#import "FLTraceOff.h"

@interface FLOperation ()
@property (readwrite, copy, nonatomic) FLRunOperationBlock runBlock;
@property (readwrite, assign) BOOL wasStarted;
@property (readwrite, assign) BOOL isFinished;
@property (readwrite, assign) BOOL didFail;
@property (readwrite, assign) BOOL wasCancelled;
@property (readwrite, strong) id input;
@property (readwrite, strong) id output;
@end

@implementation FLOperation
@synthesize operationID = _operationId;
@synthesize tag = _tag;
@synthesize predicate = _predicate;
@synthesize runBlock = _runBlock;
@synthesize disabled = _disabled;
@synthesize error = _error;
@synthesize wasStarted = _didStart;
@synthesize isFinished = _didFinish;
@synthesize didFail = _didFail;
@synthesize wasCancelled = _wasCancelled;
@synthesize input = _input;
@synthesize output = _output;

- (id) initWithRunBlock:(FLRunOperationBlock) callback {
    if((self = [self init])) {
        self.runBlock = callback;
    }
    return self;
}

+ (id) operation:(FLRunOperationBlock) callback {
    return autorelease_([[[self class] alloc] initWithRunBlock:callback]);
}

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


#if FL_MRC
- (void) dealloc {
    [_error release];
    [_operationInput release];;
    [_operationOutput release];
    mrc_release_(_runBlock);
    mrc_release_(_operationId);
	mrc_release_(_predicate);
    [super dealloc];
}
#endif

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

- (void) runSynchronouslySelf {

    @try {
        [self setMoreBusy];
       
        [self resetRunStateIfNeeded];

        if(self.willRun) {
            [self postObservation:@selector(operationWillRun:)];
        }
    
        if(self.willRun) {
            self.wasStarted = YES;
            
            [self prepareSelf];
            
            if(self.runBlock) {
                self.runBlock(self);
            }
            else {
                [self runSelf];
            }
            
            if(!self.error) {
                [self finishSelf];
            }
        }
    }
    @catch(FLAbortException* ex) {
    
    }
    @catch(NSException* ex) {
        self.error = ex.error;
        [self postObservation:@selector(operationDidFail:)];
    }
    @finally {
        [self postObservation:@selector(operationDidFinish:)];
        [self setLessBusy];
        self.isFinished = YES;
    }
}

- (FLResult) runSynchronously {
    return [[self start:nil] waitForResult];
}

- (void) startWorking:(id<FLFinisher>) finisher {

    [self runSynchronouslySelf];

    if(self.didSucceed) {
        [finisher setFinishedWithOutput:self.operationOutput];
    }
    else {
        [finisher setFinishedWithError:self.error];
    }
}

- (id<FLPromisedResult>) start:(FLResultBlock) completion {
    FLWorkFinisher* finisher = [FLWorkFinisher finisher:completion];
    [self startWorking:finisher];
    return finisher;
}

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
//@synthesize block = _block;
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
