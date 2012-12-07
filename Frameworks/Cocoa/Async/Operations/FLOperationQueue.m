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
#import "FLDispatchQueue.h"

#if DEBUG
#define LOG 0
#endif
#if LOG
#warning LOG enabled
#endif

@interface FLOperationQueue ()
@property (readwrite, strong, nonatomic) NSArray* operations;
@property (readwrite, assign) FLCancellable* cancelHandler;

@end

@implementation FLOperationQueue

@synthesize operations = _operations;
@synthesize cancelHandler = _cancelHandler;

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
    for(FLOperation* operation in _operations) {
        [operation removeObserver:self];
    }

#if FL_MRC 
    [_cancelHandler release];
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

- (id) lastOperationOutput:(NSDictionary*) inResult {
    return [inResult objectForKey:[[self lastOperation] operationID]];
}

- (id) firstOperationOutput:(NSDictionary*) inResult {
    return [inResult objectForKey:[[self firstOperation] operationID]];
}

- (id) outputByTag:(NSInteger) tag inResult:(NSDictionary*) inResult {
    return [inResult objectForKey:[[self operationByTag:tag] operationID]];
}

- (id) outputByOperationClass:(Class) aClass inResult:(NSDictionary*) inResult {
    return [inResult objectForKey:[[self operationByClass:aClass] operationID]];
}

- (void) cancelOperationByID:(id) operationID {
    id operation = [self operationByID:operationID];
    if(operation) {
#if TRACE
        FLDebugLog(@"Cancelling operation: %@", operationID);
#endif        
        [operation requestCancel:nil];
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
        FLRelease(notifyList);
    }
}

- (id<FLCollectionIterator>) forwardIterator {
    return [_operations forwardIterator];
}

- (id<FLCollectionIterator>) reverseIterator {
    return [_operations reverseIterator];
}

- (FLFinisher*) requestCancel:(FLResultBlock) completion {
    return [self.cancelHandler requestCancel:completion];
}


//- (FLFinisher*) requestCancel:(FLResultBlock) completion {
//
////    FLFinisher* finisher = [FLFinisher finisherWithResultBlock:completion];
////
////    @synchronized(self) {
////
////        if(!self.cancelFinisher) {
////            self.cancelFinisher = finisher;
////            
////            int32_t count = 0;
////            __block int32_t cancelledCount = 0;
////            for(FLOperation* operation in self.operations) {
////                if(operation.didRun) {
////                    continue;
////                }
////                ++count;
////                [operation requestCancel:^(FLResult result) {
////                    ++cancelledCount;
////                    
////                    if(cancelledCount == count) {
////                        [self.cancelFinisher setFinished];
////                    }
////                }];
////            }       
////        }
////        else {
////            [self.cancelFinisher addSubFinisher:finisher];
////        }
////
////    }
//    
//
//    
//    return finisher;
//}

- (void) operationWillRun:(FLOperation*) operation {
    [self postObservation:@selector(operationQueue:operationWillRun:) withObject:operation];
}

- (void) operationDidFinish:(FLOperation*) operation {
    [self postObservation:@selector(operationQueue:operationDidFinish:) withObject:operation];
}

- (void) operationWasCancelled:(FLOperation*) operation {
    [self postObservation:@selector(operationQueue:operationWasCancelled:) withObject:operation];
}

- (id) runSynchronously {
    FLCancellable* cancelHandler = [FLCancellable cancelHandler];
    id outResult = [NSMutableDictionary dictionary];
    
    @try {
        self.cancelHandler = cancelHandler;
    
        for(FLOperation* operation in self.operations.forwardIterator) {
            
            id operationResult = [self.cancelHandler runBlock:^ FLResult {
                return [operation runSynchronously];
            } forDependent:operation];
            
            [outResult setObject:operationResult forKey:operation.operationID];
            
            if([operationResult error] || self.cancelHandler.wasCancelled) {
                break;
            }
        }
    }
    @catch(NSException* ex) {
        outResult = ex.error;
    }
    @finally {
        self.cancelHandler = nil;
    }
    
    return [cancelHandler setFinished:outResult];
}

- (FLFinisher*) startOperationsInDispatcher:(id<FLDispatcher>) inDispatcher {
    return [inDispatcher dispatchAsyncBlock:^(FLFinisher* finisher){
        [finisher setFinishedWithResult:[self runSynchronously]];
    }];
}

- (FLFinisher*) startOperations {
    return [self startOperationsInDispatcher:FLDefaultQueue];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state 
                                  objects:(id __unsafe_unretained [])buffer 
                                    count:(NSUInteger)len {
    return [_operations countByEnumeratingWithState:state objects:buffer count:len];
}

@end



