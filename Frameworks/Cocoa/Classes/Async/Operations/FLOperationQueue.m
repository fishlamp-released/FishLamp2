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
#import "FLFinisher.h"
#import "FLAsyncQueue.h"

#if DEBUG
#define LOG 0
#endif
#if LOG
#warning LOG enabled
#endif

@interface FLOperationQueue ()
@property (readwrite, strong, nonatomic) NSArray* operations;
@property (readwrite, strong) FLSynchronousOperation* currentOperation;
@end

@implementation FLOperationQueue

@synthesize operations = _operations;
@synthesize currentOperation = _currentOperation;

- (id) init {
    self = [super init];
    if(self) {
        _operations = [[NSMutableArray alloc] init];
    }
    return self;

}

+ (FLOperationQueue*) operationQueue {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) dealloc {
#if FL_MRC 
    [_currentOperation release];
    [_operations release];
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

- (void) operationWasAdded:(FLSynchronousOperation*) operation {
    
//    [operation addObserver:self];
//    
//    
//    [self sendMessage:@"operationQueue:operationWasAdded:" withObject:operation];
}

- (void) addOperation:(FLSynchronousOperation*) operation {
    FLAssertIsNotNil(operation);
    @synchronized(self) {
        [_operations addObject:operation];
    }
    [self operationWasAdded:operation];
}

- (void) addOperationsWithArray:(NSArray*) operations {
    @synchronized(self) {
        for(FLSynchronousOperation* operation in operations) {
            [_operations addObject:operation];
        }
    }
    
    for(FLSynchronousOperation* operation in operations) {
        [self operationWasAdded:operation];
    }
}

- (void) addOperationWithTarget:(id) target action:(SEL) action {
    [self addOperation:[FLPerformSelectorOperation performSelectorOperation:target action:action ]];
}

//- (void) addOperationWithBlock:(FLBlockWithOperation) operationBlock {
//    [self addOperation:[FLSynchronousOperation operation:operationBlock]];
//}

//- (void) insertOperation:(FLSynchronousOperation*) newOperation
//          afterOperation:(FLSynchronousOperation*) afterOperation {
//
//    FLAssertIsNotNilWithComment(newOperation, nil);
//    FLAssertIsNotNilWithComment(afterOperation, nil);
//
////	if(self.wasCancelled) {
////		[newOperation requestCancel];
////	}
//    
////	newOperation.operationQueue = self;
//    [_operations insertObject:newOperation afterObject:afterOperation];
//}

//- (id) operationByTag:(NSInteger) tag {
//    FLAssertWithComment(tag != 0, @"tag must be nonzero");
//
//    @synchronized(self) {
//        for(FLSynchronousOperation* operation in _operations){
//            if(operation.tag == tag) {   
//                return operation;
//            }
//        }
//    }
//    
//    return nil;
//}

- (id) operationByID:(id) operationID {
    FLAssertIsNotNilWithComment(operationID, nil);
    @synchronized(self) {
        if(operationID) {
            for(FLSynchronousOperation* operation in _operations) {
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
        for(FLSynchronousOperation* operation in _operations) {
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

- (id) lastOperationOutput:(NSDictionary*) inResult {
    return [inResult objectForKey:[[self lastOperation] operationID]];
}

- (id) firstOperationOutput:(NSDictionary*) inResult {
    return [inResult objectForKey:[[self firstOperation] operationID]];
}


- (id) outputByOperationClass:(Class) aClass inResult:(NSDictionary*) inResult {
    return [inResult objectForKey:[[self operationByClass:aClass] operationID]];
}

- (void) operationWasRemoved:(FLSynchronousOperation*) operation {
//    [operation removeObserver:self];
//    [self sendMessage:@"operationQueue:operationWasRemoved:" withObject:operation];
}

- (void) removeOperation:(FLSynchronousOperation*) operation {
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
        
        for(FLSynchronousOperation* operation in notifyList) {
            [self operationWasRemoved:operation];
        }
    }
    @finally {
        FLRelease(notifyList);
    }
}

- (id<FLCollectionIterator>) forwardIterator {
    return [_operations forwardIterator];
}

- (id<FLCollectionIterator>) reverseIterator {
    return [_operations reverseIterator];
}

- (void) requestCancel {
    [super requestCancel];
    [self.currentOperation requestCancel];
}

- (void) operationWillRun:(FLSynchronousOperation*) operation {
//    [self sendMessage:@"operationQueue:operationWillRun:" withObject:operation];
}

- (void) operationDidFinish:(FLSynchronousOperation*) operation {
//    [self sendMessage:@"operationQueue:operationDidFinish:" withObject:operation];
}

- (void) operationWasCancelled:(FLSynchronousOperation*) operation {
//    [self sendMessage:@"operationQueue:operationWasCancelled:" withObject:operation];
}

- (FLResult) performSynchronously:(FLSynchronousOperation*) operation {

    @try {
        self.currentOperation = operation;
        return [self runChildSynchronously:operation];
    }
    @catch(NSException* ex) {
        return ex.error;
    }
    @finally {
        self.currentOperation = nil;
    }
    
}

- (FLResult) performSynchronously {

    id outResult = [NSMutableDictionary dictionary];
    
    for(FLSynchronousOperation* operation in self.operations.forwardIterator) {
        id operationResult = [self performSynchronously:operation];

        if(self.abortNeeded) {
            operationResult = [NSError cancelError];
        }

        [outResult setObject:operationResult forKey:operation.operationID];

        if([operationResult error]) {
            break;
        }
    }

    return outResult;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state 
                                  objects:(id __unsafe_unretained [])buffer 
                                    count:(NSUInteger)len {
    return [_operations countByEnumeratingWithState:state objects:buffer count:len];
}

@end



