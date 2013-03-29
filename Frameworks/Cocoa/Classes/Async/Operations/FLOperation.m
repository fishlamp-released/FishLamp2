//
//  FLOperation.m
//  FishLamp
//
//	Created by Mike Fullerton on 8/28/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLOperation.h"
#import "FLFinisher.h"
#import "FLAsyncQueue.h"
#import "FLObjectStorage.h"

@interface FLOperation ()
@property (readwrite, assign, getter=wasCancelled) BOOL cancelled;
@end

@implementation FLOperation

@synthesize operationID = _operationID;
@synthesize cancelled = _cancelled;
@synthesize delegate = _delegate;
@synthesize finishSelectorForDelegate = _finishSelectorForDelegate;
@synthesize finishSelectorForObserver = _finishSelectorForObserver;

- (id) init {
    self = [super init];
    if(self) {
  		static int32_t s_counter = 0;
        self.operationID = [NSNumber numberWithInt:FLAtomicIncrement32(s_counter)];
        self.finishSelectorForDelegate = @selector(operationDidFinish:withResult:);
        self.finishSelectorForObserver = @selector(operationDidFinish:withResult:);
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_operationID release];
    [super dealloc];
}
#endif

- (id<FLObjectStorage>) objectStorage {
    return [self.delegate operationGetObjectStorage:self];

//    FLPerformSelector2(self.delegate, _finishSelectorForDelegate, self, result);
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
    if(self.wasCancelled) {
        FLThrowError([NSError cancelError]);
    }
}

- (BOOL) abortNeeded {
    return self.wasCancelled;
}

- (FLResult) runOperation {
    return [self runOperationInContext:self.workerContext withObserver:self.observer];
}

- (void) startWorking:(FLFinisher*) finisher {

    id result = nil;

    @try {
        [self abortIfNeeded];
        result = [self runOperation];
    }
    @catch(NSException* ex) {
        result = ex.error;
    }
    
    if(self.wasCancelled) {
        result = [NSError cancelError];
    }
    
    [finisher setFinishedWithResult:result];
    
    FLPerformSelector2(self.delegate, _finishSelectorForDelegate, self, result);
    self.cancelled = NO;

    // this happens in another thread, probably.
    [self sendObservation:_finishSelectorForObserver withObject:result];
}

@end

//@implementation FLOperationObserver
//
//@synthesize willRunBlock = _willRunBlock;
//@synthesize didFinishBlock = _didFinishBlock;
//
//+ (id) operationObserver {
//    return FLAutorelease([[[self class] alloc] init]);
//}
//
//#if FL_MRC
//- (void) dealloc {
//    [_willRunBlock release];
//    [_didFinishBlock release];
//    [super dealloc];
//}
//#endif
//
//- (void) operationWillRun:(FLOperation*) operation {
//    if(_willRunBlock) {
//        _willRunBlock();
//    }
//}
//
//- (void) operationDidFinish:(FLOperation*) operation 
//                 withResult:(FLResult) withResult {
//    if(_didFinishBlock) {
//        _didFinishBlock(withResult);
//    }
//}                 
//
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
