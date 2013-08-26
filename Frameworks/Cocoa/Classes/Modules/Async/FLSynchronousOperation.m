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
#import "FLSuccessfulResult.h"
#import "NSError+FLFailedResult.h"

@interface FLSynchronousOperation ()
@end

@implementation FLSynchronousOperation

+ (id) synchronousOperation {
	return FLAutorelease([[[self class] alloc] init]);
}

- (FLPromisedResult) performSynchronously {
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

- (FLPromisedResult) runSynchronously {

    id result = nil;

    @try {
        [self abortIfNeeded];
        result = [self performSynchronously];
    }
    @catch(NSException* ex) {
        result = ex.error;
        FLAssertNotNil(result);
    }
    
    if(self.wasCancelled) {
        result = [NSError cancelError];
    }
    
    if(!result) {
        result = [NSError failedResultError];
    }
    
    [self.finisher setFinishedWithResult:result];

    return result;
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

@implementation FLBlockOperation

- (id) initWithBlock:(fl_block_t) block {
	self = [super init];
	if(self) {
		_block = [block copy];
	}
	return self;
}

#if FL_MRC
- (void)dealloc {
	[_block release];
	[super dealloc];
}
#endif

+ (id) blockOperation:(fl_block_t) block {
   return FLAutorelease([[[self class] alloc] initWithBlock:block]);
}

- (FLPromisedResult) performSynchronously {
    if(_block) {
        _block();
    }

    return FLSuccess;
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
