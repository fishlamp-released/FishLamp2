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
@property (readwrite, assign) id context;
@property (readwrite, assign, getter=wasCancelled) BOOL cancelled;
@end

@implementation FLOperation

@synthesize operationID = _operationID;
@synthesize runBlock = _runBlock;
@synthesize context = _context;
@synthesize tag = _tag;
@synthesize cancelled = _cancelled;

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

- (FLResult) runOperationWithInput:(id) input {
    return FLSuccessfullResult;
}

- (void) abortIfNeeded {
    FLThrowAbortExeptionIf(self.wasCancelled);
}

- (FLResult) runSynchronously {
    return [self runSynchronouslyWithInput:nil];
}

- (FLResult) runSynchronouslyWithInput:(id) input {

    self.cancelled = NO;
    id result = nil;
    
    @try {
        [self postObservation:@selector(operationWillRun:)];
        
        if(self.runBlock) {
            result = self.runBlock(self, input);
        }
        else {
            result = [self runOperationWithInput:input];
        }
    }
    @catch(NSException* ex) {
        result = ex.error;
    }
    
    [self postObservation:@selector(operationDidFinish:withResult:) withObject:result];
    
    return result;
}

- (void) operationWasCancelled:(FLOperation*) operation {
    [self requestCancel];
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
