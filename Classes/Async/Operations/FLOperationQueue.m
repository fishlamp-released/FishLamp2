//
//	FLOperationQueue.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/4/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLOperationQueue.h"
#import "FLPerformSelectorOperation.h"
#import "FLCollectionIterator.h"
#import "FLJob.h"
#import "FLFinisher.h"

#if DEBUG
#define LOG 0
#endif
#if LOG
#warning LOG enabled
#endif

@interface FLOperationQueue ()
@property (readwrite, strong, nonatomic) NSArray* operations;
@end

@implementation FLOperationQueue

@synthesize operations = _operations;

- (id) init {
    self = [super init];
    if(self) {
        _operations = [[NSMutableArray alloc] init];
    }
    return self;

}

+ (FLOperationQueue*) operationQueue {
    return autorelease_([[[self class] alloc] init]);
}

- (void) dealloc {
    NSArray* list = retain_(_operations);
    _operations = nil;

    for(FLOperation* operation in list) {
        [operation removeObserver:self];
    }
#if FL_MRC 
    [list release];
    [super dealloc];
#endif
}


//- (BOOL) visitOperations:(FLOperationQueueVisitor) visitor {
//
//    id<FLCollectionIterator> iterator = [_operations forwardIterator];
//    
//    BOOL stop = NO;
//    while(iterator.nextObject) {
//        visitor(iterator.object, &stop);
//        
//        if(stop) {
//            return YES;
//        }
//    }
//    return NO;
//}
//
//
//- (BOOL) visitOperationsInReverseOrder:(FLOperationQueueVisitor) visitor {
//
//    id<FLCollectionIterator> iterator = [_operations reverseIterator];
//    
//    BOOL stop = NO;
//    while(iterator.nextObject) {
//        visitor(iterator.object, &stop);
//        
//        if(stop) {
//            return YES;
//        }
//    }
//    return NO;
//}

- (void) addOperationWithFactoryBlock:(FLCreateOperationBlock) block {
    if(block) {
        [self addOperation:block()];
    }
}

- (void) operationWasAdded:(FLOperation*) operation {
    [operation addObserver:self];
    [self postObservation:@selector(operationQueue:operationWasAdded:) withObject:operation];
}

- (void) addOperation:(FLOperation*) operation {
    FLAssertIsNotNil_(operation);
    @synchronized(self) {
        [_operations addObject:operation];
    }
    [self operationWasAdded:operation];
}

- (void) addOperationsWithArray:(NSArray*) operations {
    @synchronized(self) {
        for(FLOperation* operation in operations) {
            [_operations addObject:operation];
        }
    }
    
    for(FLOperation* operation in operations) {
        [self operationWasAdded:operation];
    }
}

- (void) addOperationWithTarget:(id) target action:(SEL) action {
    [self addOperation:[FLPerformSelectorOperation performSelectorOperation:target action:action ]];
}

- (void) addOperationWithBlock:(FLRunOperationBlock) operationBlock {
    [self addOperation:[FLOperation operation:operationBlock]];
}

//- (void) insertOperation:(FLOperation*) newOperation
//          afterOperation:(FLOperation*) afterOperation {
//
//    FLAssertIsNotNil_v(newOperation, nil);
//    FLAssertIsNotNil_v(afterOperation, nil);
//
////	if(self.wasCancelled) {
////		[newOperation requestCancel];
////	}
//    
////	newOperation.operationQueue = self;
//    [_operations insertObject:newOperation afterObject:afterOperation];
//}

- (id) operationByTag:(NSInteger) tag {
    FLAssert_v(tag != 0, @"tag must be nonzero");

    @synchronized(self) {
        for(FLOperation* operation in _operations){
            if(operation.tag == tag) {   
                return operation;
            }
        }
    }
    
    return nil;
}

- (id) operationByID:(id) operationID {
    FLAssertIsNotNil_v(operationID, nil);
    @synchronized(self) {
        if(operationID) {
            for(FLOperation* operation in _operations) {
                if(operation.operationID && [operationID isEqual:operation.operationID]) {   
                    return operation;
                }
            }
        }
    }
	
	return nil; 
}

- (id) operationByClass:(Class) class {
    @synchronized(self) {
        for(FLOperation* operation in _operations) {
            if([operation isKindOfClass:class]) {
                return operation;
            }
        }
    }
	
	return nil;
}

- (id) firstOperation {
    id operation = nil;
    @synchronized(self) {
        operation = [_operations firstObject];
    }
	return operation;
}

- (id) lastOperation {
    id operation = nil;
    @synchronized(self) {
        operation = [_operations lastObject];
    }
	return operation;
}

- (NSUInteger) count {
    NSUInteger count = 0;
    @synchronized(self) {
        count = _operations.count;
    }

	return count;
}

- (id) lastOperationOutput {
    return [[self lastOperation] operationOutput];
}

- (id) firstOperationOutput {
    return [[self firstOperation] operationOutput];
}

- (id) outputById:(id) operationID {
    return [[self operationByID:operationID] operationOutput];
}

- (id) outputByTag:(NSInteger) tag {
    return [[self operationByTag:tag] operationOutput];
}

- (id) outputByOperationClass:(Class) aClass {
    return [[self operationByClass:aClass] operationOutput];
}

- (void) cancelOperationByID:(id) operationID {
    id operation = [self operationByID:operationID];
    if(operation) {
#if TRACE
        FLDebugLog(@"Cancelling operation: %@", operationID);
#endif        
        [operation requestCancel];
    }
}

- (void) operationWasRemoved:(FLOperation*) operation {
    [operation removeObserver:self];
    [self postObservation:@selector(operationQueue:operationWasRemoved:) withObject:operation];
}

- (void) removeOperation:(FLOperation*) operation {
    @synchronized(self) {
        [_operations removeObject:operation];
    }
    [self operationWasRemoved:operation];
}

- (void) removeAllOperations {

    NSArray* notifyList = nil;
    @try {
        @synchronized(self) {
            notifyList = [_operations copy];
            [_operations removeAllObjects];
        }
        
        for(FLOperation* operation in notifyList) {
            [self operationWasRemoved:operation];
        }
    }
    @finally {
        release_(notifyList);
    }
}

- (id<FLCollectionIterator>) forwardIterator {
    return [_operations forwardIterator];
}

- (id<FLCollectionIterator>) reverseIterator {
    return [_operations reverseIterator];
}

- (void) cancelAllOperations {
    for(FLOperation* operation in self.operations.reverseIterator) {
        if(operation.didRun) {
            break;
        }
        [operation requestCancel];
    }
}

- (void) operationWillRun:(FLOperation*) operation {
    [self postObservation:@selector(operationQueue:operationWillRun:) withObject:operation];
}

- (void) operationDidFinish:(FLOperation*) operation {
    [self postObservation:@selector(operationQueue:operationDidFinish:) withObject:operation];
}

- (void) operationWasCancelled:(FLOperation*) operation {
    [self postObservation:@selector(operationQueue:operationWasCancelled:) withObject:operation];
}

- (FLFinisher*) startWorking:(FLFinisher*) finisher {

    for(FLOperation* operation in self.operations.forwardIterator) {
        
        [operation runSynchronously];
        if(!operation.didSucceed) {
            break;
        }
    };

    [finisher setFinished];
    
    return finisher;
}

//- (id<FLPromisedResult>) start:(FLFinisher*) finisher {
////    FLFinisher* finisher = [FLFinisher finisher:completion];
//    [self startWorking:finisher];
//    return finisher;
//}

//- (FLFinisher*) runSynchronously {
//    return [[self start:nil] waitUntilFinished];
//}


@end

@implementation FLOperationQueueRunner

- (FLOperationQueue*) operations {
    return self.operationInput;
}

- (id) initWithOperationQueue:(FLOperationQueue*) queue {
    self = [self initWithInput:queue];
    if(self) {
    }
    return self;
}

+ (id) operationQueueRunner:(FLOperationQueue*) queue {
    return autorelease_([[[self class] alloc] initWithOperationQueue:queue]);
}

- (void) requestCancel {
    [self.operations cancelAllOperations];
}

- (void) resetRunState {
    for(FLOperation* operation in self.operations.reverseIterator) {
        [operation resetRunState];
    };
}

- (void) resetRunStateIfNeeded {
    for(FLOperation* operation in self.operations.reverseIterator) {
        [operation resetRunStateIfNeeded];
    };
}

- (void) syncStateWithOperation:(FLOperation*) operation {
    if(self.wasCancelled ) {
        if(!operation.wasCancelled) {
            [operation requestCancel];
        }
    }
    else if(operation.wasCancelled) {
        if(!self.wasCancelled) {
            [self requestCancel];
        }
    }
    else if(operation.error) {
        self.error = [NSError abortError];
    }
    else if(self.error) {
        operation.error = self.error;
    }
}

- (void) runSelf {
    
    for(FLOperation* operation in self.operations.forwardIterator) {
        
        [operation runSynchronously];
        [self syncStateWithOperation:operation];
        
        if(!operation.didSucceed) {
            break;
        }
    };
    
}

@end

