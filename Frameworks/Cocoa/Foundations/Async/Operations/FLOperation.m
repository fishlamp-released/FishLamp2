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
#import "FLAsyncQueue.h"

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

- (FLResult) runOperationInContext:(id) context withObserver:(id) observer {
    return FLSuccessfullResult;
}

- (void) abortIfNeeded {
    FLThrowAbortExeptionIf(self.wasCancelled);
}

- (BOOL) abortNeeded {
    return self.wasCancelled;
}

- (id<FLAsyncQueue>) asyncQueue {
    return [FLAsyncQueue defaultQueue];
}

- (void) startWorking:(FLFinisher*) finisher {

    id result = nil;
    
    @try {
        [self abortIfNeeded];
        
        [self sendMessage:@selector(operationWillRun:) toListener:finisher];
       
        if(self.runBlock) {
            result = self.runBlock(self, self.workerContext, finisher.observer);
        }
        else {
            result = [self runOperationInContext:self.workerContext withObserver:finisher.observer];
        }
    }
    @catch(NSException* ex) {
        result = ex.error;
    }
    
    if(self.wasCancelled) {
        result = [NSError cancelError];
    }
    
    [finisher setFinishedWithResult:result];

    [self sendMessage:@selector(operationDidFinish:withResult:) toListener:finisher withObject:self withObject:result];
   
    self.cancelled = NO;
}

- (void) operationWasCancelled:(FLOperation*) operation {
    [self requestCancel];
}

@end

@implementation FLOperationObserver

@synthesize willRunBlock = _willRunBlock;
@synthesize didFinishBlock = _didFinishBlock;

+ (id) operationObserver {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    [_willRunBlock release];
    [_didFinishBlock release];
    [super dealloc];
}
#endif

- (void) operationWillRun:(FLOperation*) operation {
    if(_willRunBlock) {
        _willRunBlock();
    }
}

- (void) operationDidFinish:(FLOperation*) operation 
                 withResult:(FLResult) withResult {
    if(_didFinishBlock) {
        _didFinishBlock(withResult);
    }
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
