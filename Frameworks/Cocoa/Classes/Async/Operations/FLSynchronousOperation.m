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
@end

@implementation FLSynchronousOperation

+ (id) synchronousOperation {
	return FLAutorelease([[[self class] alloc] init]);
}

- (FLResult) performSynchronously {
    return FLSuccessfullResult;
}

- (void) abortIfNeeded {
    if(self.abortNeeded) {
        FLThrowError([NSError cancelError]);
    }
}

- (BOOL) abortNeeded {
    return self.wasCancelled;
}

- (void) performUntilFinished:(FLFinisher*) finisher {
    [finisher setFinishedWithResult:[self runSynchronously]];
}

- (FLResult) runSynchronously {

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
    
    [self operationDidFinishWithResult:result];
    return result;
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
