//
//  FLSynchronousOperation.m
//  FishLamp
//
//	Created by Mike Fullerton on 8/28/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLSynchronousOperation.h"
#import "FLFinisher.h"
#import "FLAsyncQueue.h"
#import "FLObjectStorage.h"
#import "FishLampAsync.h"

@interface FLSynchronousOperation ()
@end

@implementation FLSynchronousOperation

+ (id) synchronousOperation {
	return FLAutorelease([[[self class] alloc] init]);
}

- (id) performSynchronously {
    return [FLSuccessfulResult successfulResult];
}

- (void) abortIfNeeded {
    if(self.abortNeeded) {
        FLThrowError([NSError cancelError]);
    }
}

- (BOOL) abortNeeded {
    return self.wasCancelled;
}

- (void) startOperation {
    [self runSynchronously];
}

- (FLPromisedResult*) runSynchronously {

    id result = nil;
    NSError* error = nil;

    @try {
        [self abortIfNeeded];
        result = [self performSynchronously];
    }
    @catch(NSException* ex) {
        error = ex.error;
    }
    
    if(self.wasCancelled) {
        error = [NSError cancelError];
    }
    
    if(!result && !error) {
        error = [NSError failedResultError];
    }
    
    [self.finisher setFinishedWithResult:result error:error];

    return [FLPromisedResult promisedResult:result error:error];
}
@end

@implementation FLBatchSynchronousOperation
//- (void) sendIterationObservation:(FLPromisedResult) result {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        FLPerformSelector1(_batchObserver, _batchAction, result);
//    });
//}

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
//                 withResult:(FLPromisedResult) withResult {
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
