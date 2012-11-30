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

@interface FLOperation ()
@property (readwrite, copy, nonatomic) FLRunOperationBlock runBlock;
@property (readwrite, assign) BOOL wasStarted;
@property (readwrite, assign) BOOL isFinished;
//@property (readwrite, strong) id input;
//@property (readwrite, strong) id output;
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
//    [_operationInput release];;
//    [_operationOutput release];
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

//- (id) initWithInput:(id) input {
//    self = [super init];
//    if(self) {
//        self.operationInput = input;
//    }
//    return self;
//}

//+ (id) operationWithInput:(id) input {
//    return autorelease_([[[self class] alloc] initWithInput:input]);
//}

- (id) output {
    return nil;
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

- (FLResult) runSelf {
    return FLSuccessfullResult;
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

- (void) finishSelf:(FLResult*) withResult {

}

//- (id) result {
//    if(self.didRun) {
//        if(self.error) {
//            return self.error;
//        }
//        if(self.output) {
//            return self.output;
//        }
//        return FLSuccessfullResult;
//    }
//    return nil;
//}

- (void) abortIfNeeded {
    if(self.error) {
        [FLAbortException raise];
    }
}

- (id) runSynchronously {

    FLResult result = nil;
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
                result = self.runBlock(self);
            }
            else {
                result = [self runSelf];
            }
            
            if(result == nil) {
                result = FLFailedResult;
            }
        }
    }
    @catch(FLAbortException* ex) {
        if(![result error]) {
            result = [NSError abortError];
        }
    }
    @catch(NSException* ex) {
        if(![result error]) {
            result = ex.error;
        }
    }

    @try {
        [self finishSelf:&result];  
    }
    @catch(NSException* ex) {
        if(![result error]) {
            result = ex.error;
        }
    }
    
    [self setLessBusy];
    self.isFinished = YES;
    
    if(self.cancelFinisher) {
    
        result = [NSError cancelError];
        
        [self.cancelFinisher setFinished];
        [self postObservation:@selector(operationWasCancelled:)];
    }

    [self postObservation:@selector(operationDidFinish:)];
    
    return result;
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
    self.wasStarted = NO;
    self.isFinished = NO;
    self.error = nil;
}

- (void) resetRunState {
    [self _resetState];
}

- (void) resetRunStateIfNeeded {
    if(self.wasStarted) {
        [self _resetState];
    }
}
- (void) operationWasCancelled:(FLOperation*) operation {
    [self requestCancel:nil];
}

- (void) throwAbortIfFailed {
    if(self.didFail || self.wasCancelled) {
        @throw [FLAbortException abortException];
    }
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
