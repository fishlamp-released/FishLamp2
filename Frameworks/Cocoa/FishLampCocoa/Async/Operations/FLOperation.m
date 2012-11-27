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
@property (readwrite, strong) id input;
@property (readwrite, strong) id output;
@property (readwrite, assign) id context;
@property (readwrite, strong) FLFinisher* cancelFinisher;
@end

@implementation FLOperation

@synthesize error = _error;
@synthesize operationID = _operationID;
@synthesize runBlock = _runBlock;
@synthesize disabled = _disabled;
@synthesize wasStarted = _wasStarted;
@synthesize isFinished = _isFinished;
@synthesize context = _context;
@synthesize cancelFinisher = _cancelFinisher;
@synthesize input = _operationInput;
@synthesize output = _operationOutput;
@synthesize tag = _tag;

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

#if FL_MRC
- (void) dealloc {
    [_cancelFinisher release];
    [_error release];
    [_operationInput release];;
    [_operationOutput release];
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
    return !self.cancelWasRequested && !self.didSucceed && !self.didFail && !self.didRun;
}

- (BOOL) wasCancelled {
    return self.cancelFinisher && self.cancelFinisher.isFinished;
}

- (BOOL) cancelWasRequested {
    return self.cancelFinisher != nil;
}

- (FLFinisher*) requestCancel:(FLResultBlock) completion {

    FLFinisher* finisher = [FLFinisher finisherWithResultBlock:completion];
    if(self.didRun || self.wasCancelled) {
        [finisher setFinished];
        return finisher;
    }
    
    @synchronized(self) {
        if(!self.cancelFinisher) {
            self.cancelFinisher = finisher;
            
            self.error = [NSError cancelError];

            if(!self.isBusy) {
                [self.cancelFinisher setFinished];
            }
        }
        else {
            [self.cancelFinisher addSubFinisher:finisher];
        }
    }
    
    return finisher;
}

- (BOOL) didFail {
    return self.error != nil;
}

- (void) runSelf {
}

- (BOOL) willRun {
   return   !self.wasCancelled &&
            !self.didFail &&
            !self.isFinished &&
            !self.isDisabled;
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

- (id) result {
    if(self.didRun) {
        if(self.error) {
            return self.error;
        }
        if(self.output) {
            return self.output;
        }
        return FLSuccessfullResult;
    }
    return nil;
}

- (void) abortIfNeeded {
    if(self.error) {
        [FLAbortException raise];
    }
}

- (id) runSynchronously {
    @try {
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
    @catch(FLAbortException* ex) {
        if(!self.error) {
            self.error = [NSError abortError];
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
    
    if(self.cancelFinisher) {
         [self.cancelFinisher setFinished];
         [self postObservation:@selector(operationWasCancelled:)];
    }

    [self postObservation:@selector(operationDidFinish:)];
    
    return self.result;
}

- (FLFinisher*) startOperationInDispatcher:(id<FLDispatcher>) inDispatcher 
                                completion:(FLCompletionBlock) completion{
                                
    FLFinisher* outFinisher = [inDispatcher dispatchAsyncBlock:^(FLFinisher* finisher){
        [finisher setFinishedWithResult:[self runSynchronously]];
    }];
    
// TODO: awkward    
    outFinisher.requestCancelBlock = ^{ 
        [self requestCancel:nil]; 
    };
    
    return outFinisher;
}

- (FLFinisher*) startOperation:(FLCompletionBlock) completion{
    return [self startOperationInDispatcher:FLDefaultQueue completion:completion];
}

- (void) _resetState {
    self.error = nil;
    self.wasStarted = NO;
    self.isFinished = NO;
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
    [self requestCancel:nil];
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
