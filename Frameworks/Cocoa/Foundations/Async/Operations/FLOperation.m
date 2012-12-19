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
@property (readwrite, assign) FLCancellable* cancelHandler;
@end

@implementation FLOperation

@synthesize operationID = _operationID;
@synthesize runBlock = _runBlock;
@synthesize context = _context;
@synthesize tag = _tag;
@synthesize cancelHandler = _cancelHandler;

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

- (void) cancelSelf {
}

- (FLFinisher*) requestCancel:(FLResultBlock) completion {
    return [self.cancelHandler requestCancel:completion];
}

- (FLResult) runSelf:(id) input {
    return FLSuccessfullResult;
}

- (void) abortIfNeeded {
    if(self.cancelHandler) {
        [FLAbortException raise];
    }
}

- (id) runSynchronously {
    return [self runSynchronously:nil];
}

- (id) runSynchronously:(id) input {

    FLCancellable* cancelHandler = [FLCancellable cancelHandler];
    id result = nil;
    
    @try {
        self.cancelHandler = cancelHandler;
    
        [self postObservation:@selector(operationWillRun:)];
        
        if(self.runBlock) {
            result = self.runBlock(self, input);
        }
        else {
            result = [self runSelf:input];
        }
    }
    @catch(NSException* ex) {
        result = ex.error;
    }
    @finally {
        self.cancelHandler = nil;
    }
    
    result = [cancelHandler setFinished:result];  
    
    [self postObservation:@selector(operationDidFinish:withResult:) withObject:result];
    
    return result;
}

- (FLFinisher*) startOperationInDispatcher:(id<FLDispatcher>) inDispatcher 
                                completion:(FLCompletionBlock) completion{
                                
    FLFinisher* outFinisher = [inDispatcher dispatchAsyncBlock:^(FLFinisher* finisher){
        [finisher setFinishedWithResult:[self runSynchronously]];
    }];
    
    return outFinisher;
}

- (FLFinisher*) startOperation:(FLCompletionBlock) completion{
    return [self startOperationInDispatcher:FLDefaultQueue completion:completion];
}

- (void) operationWasCancelled:(FLOperation*) operation {
    [self requestCancel:nil];
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
