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
#import "FLGcdDispatcher.h"

NSString* const FLOperationFinishedEvent;

@interface FLOperation ()
@property (readwrite, copy, nonatomic) FLBlockWithOperation runBlock;
@property (readwrite, assign, getter=wasCancelled) BOOL cancelled;
@end

@implementation FLOperation

@synthesize operationID = _operationID;
@synthesize runBlock = _runBlock;
@synthesize cancelled = _cancelled;

- (id) initWithRunBlock:(FLBlockWithOperation) callback {
    if((self = [self init])) {
        self.runBlock = callback;
    }
    return self;
}

+ (id) operation:(FLBlockWithOperation) callback {
    return FLAutorelease([[[self class] alloc] initWithRunBlock:callback]);
}

#if FL_MRC
- (void) dealloc {
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
//        [self postObservation:@selector(operationWillRun:)];
        
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
    
//    [self postObservation:@selector(operationDidFinish:withResult:) withObject:result];

    [finisher setFinishedWithResult:result];
    [self.context removeObject:self];
}

- (void) operationWasCancelled:(FLOperation*) operation {
    [self requestCancel];
}

- (FLResult) runSynchronously {
    FLFinisher* finisher = [FLFinisher finisher];
    [self startWorking:finisher];
    return [finisher result];
}

- (FLResult) runSynchronouslyWithObserver:(FLOperationObserver*) observer {
    [self startWorking:observer];
    return [observer result];
}

- (FLResult) runSubOperation:(FLOperation*) operation {
    @try {
        if(operation.context == nil) {
            [self.context addObject:operation];
        }
        
        return [operation runSynchronously];
    }
    @catch(NSException* ex) {
        return [ex error];
    }
}

@end

@implementation FLOperationObserver

@synthesize willRun = _willRun;
//@synthesize didFinish = _didFinish;

+ (id) operationObserver {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    [_willRun release];
//    [_didFinish release];
    [super dealloc];
}
#endif

- (void) operationWillRun:(FLOperation*) operation {
    if(_willRun) {
        _willRun();
    }
}

- (void) operationDidFinish:(FLOperation*) operation 
                 withResult:(FLResult) withResult {
//    if(_didFinish) {
//        _didFinish(withResult);
//    }
}                 


@end
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
