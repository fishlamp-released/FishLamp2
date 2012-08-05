//
//	FLOperationQueue.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/4/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLOperationQueue.h"

#if DEBUG
#define LOG 0
#endif
#if LOG
#warning LOG enabled
#endif

@implementation FLOperationQueue

@synthesize failedOperation = _failedOperation;
@synthesize onWillBeginOperation = _onWillBeginOperation;
@synthesize onDidFinishOperation = _onDidFinishOperation;

- (id) init {
	if((self = [super init])) {
		_operations = [[FLLinkedList alloc] init];
	}
	return self;
}

- (void) clearOperationQueue {
	if(_operations) {
		[_operations removeAllObjects];
	}
}

#if FL_DEALLOC 
- (void) dealloc {
	FLRelease(_operations);
	FLRelease(_onWillBeginOperation);
	FLRelease(_onDidFinishOperation);
	FLSuperDealloc();
}
#endif

- (FLOperation*) currentOperation {
	return _currentOperation;
}

- (void) _runCurrentOperation:(FLOperation*) operation {
    _currentOperation = operation;
    @try
    {
        if(_onWillBeginOperation) {
            _onWillBeginOperation(self, operation);
        }
    
       [operation performSynchronously];
        if(operation.error) {
            _failedOperation = operation;
        }
    }
    @catch(NSException* ex) {
        _failedOperation = operation;
        _failedOperation.error = ex.error;
    }
    @finally  {

        if(_onDidFinishOperation) {
            _onDidFinishOperation(self, operation);
        }
        _currentOperation = nil;
    }
}

- (void) performSelf {
	_failedOperation = nil;
	
    for(FLOperation* operation in _operations) {
        FLPerformBlockInAutoreleasePool(^{
            [self _runCurrentOperation:operation];
		});
        
        if(_cancelled || _failedOperation) {
            break;
        }
    }
    
    // Note: NOT calling [super] for operation queues
}

- (NSError*) error {
	return _failedOperation ? [_failedOperation error] : [super error];
}

- (void) queueOperationWithFactory:(FLCreateOperationBlock) block {
    if(block) {
        [self queueOperation:block()];
    }
}

- (void) queueOperation:(FLOperation*) operation {
    FLAssertIsNotNil(operation);

	if(self.wasCancelled) {
		[operation requestCancel];
	}
	
	operation.parentOperationQueue = self;
	[_operations addObject:operation];
}

- (void) queueTarget:(id) target action:(SEL) action {
    FLOperation* operation = [FLOperation operation];
    operation.onPerform = ^(id theOperation) {
            [target performSelector:action withObject:theOperation];
            };
    [self queueOperation:operation];
} 

- (void) queueBlock:(FLOperationBlock) operationBlock {
    FLOperation* operation = [FLOperation operation];
    operation.onPerform = operationBlock;
    [self queueOperation:operation];
}

- (void) insertOperation:(FLOperation*) newOperation
          afterOperation:(FLOperation*) afterOperation {
    FLAssertIsNotNil(newOperation);
    FLAssertIsNotNil(afterOperation);

	if(self.wasCancelled) {
		[newOperation requestCancel];
	}
    
	newOperation.parentOperationQueue = self;
    [_operations insertObject:newOperation afterObject:afterOperation];
}

//- (void) describeSelf:(FLStringBuilder*) builder {
//	[super describeSelf:builder];
//	
//	for(FLOperation* operation in _operations) {
//		[operation describeToStringBuilder:builder];
//	}
//	
//	if(self.failedOperation) {
//		[builder appendString:@"Failed Operation: "];
//		[self.failedOperation describeToStringBuilder:builder];
//	}
//}

- (id) operationByTag:(NSInteger) operationTag {
    FLAssert(operationTag != 0, @"tag must be nonzero");

    for(FLOperation* operation in _operations){
        if(operation.operationTag == operationTag) {   
            return operation;
        }
    }
    
    return nil;
}

- (id) operationById:(id) operationId {
    FLAssertIsNotNil(operationId);

    if(operationId) {
        for(FLOperation* operation in _operations) {
            if(operation.operationId && [operationId isEqual:operation.operationId]) {   
                return operation;
            }
        }
    }
	
	return nil; 
}

- (id) operationByClass:(Class) class {
	for(FLOperation* operation in _operations) {
		if([operation isKindOfClass:class]) {
			return operation;
		}
	}
	
	return nil;
}

- (id) firstOperation {
    return [_operations firstObject];
}

- (id) lastOperation {
	return [_operations lastObject];
}

- (NSUInteger) operationCount {
	return _operations.count;
}

- (void) requestCancel {
    [super requestCancel];
    _cancelled = YES;
    [_currentOperation requestCancel];
}

- (BOOL) wasCancelled {
	return _cancelled; 
}	

- (id) lastOperationOutput {
    return [[self lastOperation] operationOutput];
}

- (id) firstOperationOutput {
    return [[self firstOperation] operationOutput];
}

- (id) outputById:(id) operationId {
    return [[self operationById:operationId] operationOutput];
}

- (id) outputByTag:(NSInteger) operationTag {
    return [[self operationByTag:operationTag] operationOutput];
}

- (id) outputByOperationClass:(Class) aClass {
    return [[self operationByClass:aClass] operationOutput];
}

@end

