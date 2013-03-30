//
//  FLSynchronousOperation.m
//  FishLamp
//
//	Created by Mike Fullerton on 8/28/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLSynchronousOperation.h"
#import "FLFinisher.h"
#import "FLAsyncQueue.h"
#import "FLObjectStorage.h"

@interface FLSynchronousOperation ()
@property (readwrite, assign, getter=wasCancelled) BOOL cancelled;
@end

@implementation FLSynchronousOperation

@synthesize operationID = _operationID;
@synthesize cancelled = _cancelled;
@synthesize objectStorage = _objectStorage;

- (id) init {
    self = [super init];
    if(self) {
  		static int32_t s_counter = 0;
        self.operationID = [NSNumber numberWithInt:FLAtomicIncrement32(s_counter)];
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_objectStorage release];
    [_operationID release];
    [super dealloc];
}
#endif

+ (id) operation {
	return FLAutorelease([[[self class] alloc] init]);
}

- (void) requestCancel {
    self.cancelled = YES;
}

- (FLResult) performSynchronously {
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

- (void) performUntilFinished:(FLFinisher*) finisher {

    id result = nil;

    @try {
        [self abortIfNeeded];
        result = [self performSynchronously];
    }
    @catch(NSException* ex) {
        result = ex.error;
    }
    
    if(self.wasCancelled) {
        result = [NSError cancelError];
    }
    
    FLPerformSelector2(_finishedDelegate, _finishedAction, self, result);
    self.cancelled = NO;

    [finisher setFinishedWithResult:result];
}

- (FLResult) runSynchronously {
    FLFinisher* finisher = [FLFinisher finisher];
    [self performUntilFinished:finisher];
    return finisher.result;
}

- (void) setFinishedDelegate:(id) target action:(SEL) action {
    _finishedDelegate = target;
    _finishedAction = action;
}




@end

@implementation FLBatchSynchronousOperation
- (void) sendIterationObservation:(FLResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        FLPerformSelector1(_batchObserver, _batchAction, result);
    });
}

- (void) setBatchObserver:(id) observer action:(SEL) action {
    _batchObserver = observer;
    _batchAction = action;
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
//- (void) operationWillRun:(FLSynchronousOperation*) operation {
//    if(_willRunBlock) {
//        _willRunBlock();
//    }
//}
//
//- (void) operationDidFinish:(FLSynchronousOperation*) operation 
//                 withResult:(FLResult) withResult {
//    if(_didFinishBlock) {
//        _didFinishBlock(withResult);
//    }
//}                 
//
//@end
//
//@implementation FLOperationWillStartObserver
//- (void) operationWillRun:(FLSynchronousOperation*) operation {
//    [self invokeBlockWithOperation:operation];
//}
//@end
//
//@implementation FLOperationDidFinishObserver
//- (void) operationDidFinish:(FLSynchronousOperation*) operation {
//    [self invokeBlockWithOperation:operation];
//}
//@end

//
//@implementation FLSynchronousOperation (Deprecated)
//
//
//@end
