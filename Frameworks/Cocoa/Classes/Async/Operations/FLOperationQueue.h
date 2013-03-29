//
//	FLOperationQueue.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/4/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"
#import "FLSynchronousOperation.h"
#import "FLCollectionIterator.h"

@class FLOperationQueue;

typedef void (^FLOperationQueueVisitor)(id operation, BOOL* stop);
typedef id (^FLCreateOperationBlock)();


@interface FLOperationQueue : FLSynchronousOperation<NSFastEnumeration> {
@private
	NSMutableArray* _operations;
    FLSynchronousOperation* _currentOperation;
}

+ (FLOperationQueue*) operationQueue;

@property (readonly, strong) id<FLCollectionIterator> forwardIterator;

@property (readonly, strong) id<FLCollectionIterator> reverseIterator;

@property (readonly, strong) id firstOperation;

@property (readonly, strong) id lastOperation; 

@property (readonly, assign) NSUInteger count;

//- (id) operationAtIndex:(NSUInteger) index;

- (void) addOperationWithFactoryBlock:(FLCreateOperationBlock) factoryBlock;

- (void) addOperation:(FLSynchronousOperation*) operation;

- (void) addOperationWithTarget:(id) target action:(SEL) action; // @selector(callback:) parameter is the operation

- (void) addOperationsWithArray:(NSArray*) operations;

//- (void) insertOperation:(FLSynchronousOperation*) newOperation
//          afterOperation:(FLSynchronousOperation*) afterOperation;

- (id) operationByID:(id) operationID;

- (id) operationByClass:(Class) class;

//
- (FLResult) firstOperationOutput:(NSDictionary*) inResult;

- (FLResult) lastOperationOutput:(NSDictionary*) inResult;

- (id) outputByOperationClass:(Class) aClass  inResult:(NSDictionary*) inResult;

- (void) removeOperation:(FLSynchronousOperation*) operation;

- (void) removeAllOperations;

// optional overrides
- (void) operationWasAdded:(FLSynchronousOperation*) operation;
- (void) operationWasRemoved:(FLSynchronousOperation*) operation;
@end

@protocol FLOperationQueueObserver <NSObject>
- (void) operationQueue:(FLOperationQueue*) queue operationWasAdded:(FLSynchronousOperation*) operation;
- (void) operationQueue:(FLOperationQueue*) queue operationWasRemoved:(FLSynchronousOperation*) operation;

- (void) operationQueue:(FLOperationQueue*) queue operationWillRun:(FLSynchronousOperation*) operation;
- (void) operationQueue:(FLOperationQueue*) queue operationDidFinish:(FLSynchronousOperation*) operation;
- (void) operationQueue:(FLOperationQueue*) queue operationWasCancelled:(FLSynchronousOperation*) operation;
@end

