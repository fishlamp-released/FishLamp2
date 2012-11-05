//
//	FLOperationQueue.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/4/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"
#import "FLOperation.h"
#import "FLCollectionIterator.h"

@class FLOperationQueue;

typedef void (^FLOperationQueueVisitor)(id operation, BOOL* stop);
typedef id (^FLCreateOperationBlock)();


@interface FLOperationQueue : FLObservable<FLWorker, FLRunnable> {
@private
	NSMutableArray* _operations;
}

+ (FLOperationQueue*) operationQueue;

@property (readonly, strong) id<FLCollectionIterator> forwardIterator;

@property (readonly, strong) id<FLCollectionIterator> reverseIterator;

@property (readonly, strong) id firstOperation;

@property (readonly, strong) id lastOperation; 

@property (readonly, assign) NSUInteger count;

//- (id) operationAtIndex:(NSUInteger) index;

- (void) addOperationWithFactoryBlock:(FLCreateOperationBlock) factoryBlock;

- (void) addOperation:(FLOperation*) operation;

- (void) addOperationWithBlock:(FLRunOperationBlock) operationBlock;

- (void) addOperationWithTarget:(id) target action:(SEL) action; // @selector(callback:) parameter is the operation

- (void) addOperationsWithArray:(NSArray*) operations;

//- (void) insertOperation:(FLOperation*) newOperation
//          afterOperation:(FLOperation*) afterOperation;

- (id) operationByID:(id) operationID;

- (id) operationByTag:(NSInteger) tag;

- (id) operationByClass:(Class) class;

///// @return YES is if stopped
//- (BOOL) visitOperationsInReverseOrder:(FLOperationQueueVisitor) visitor;
//
///// @return YES is if stopped
//- (BOOL) visitOperations:(FLOperationQueueVisitor) visitor;

// output helpers

@property (readonly, strong) id firstOperationOutput;

@property (readonly, strong) id lastOperationOutput;

- (id) outputById:(id) operationID;

- (id) outputByTag:(NSInteger) tag;

- (id) outputByOperationClass:(Class) aClass;

- (void) cancelOperationByID:(id) operationID;

- (void) removeOperation:(FLOperation*) operation;

- (void) removeAllOperations;

- (void) cancelAllOperations;

@end

@interface FLOperationQueue (FLOptionalOverrides)
- (void) operationWasAdded:(FLOperation*) operation;
- (void) operationWasRemoved:(FLOperation*) operation;
@end

@interface FLOperationQueueRunner : FLOperation {
}
@property (readonly, strong) FLOperationQueue* operations;
- (id) initWithOperationQueue:(FLOperationQueue*) queue;
+ (id) operationQueueRunner:(FLOperationQueue*) queue;
@end


@protocol FLOperationQueueObserver <NSObject>
@optional
- (void) operationQueue:(FLOperationQueue*) queue operationWasAdded:(FLOperation*) operation;
- (void) operationQueue:(FLOperationQueue*) queue operationWasRemoved:(FLOperation*) operation;

- (void) operationQueue:(FLOperationQueue*) queue operationWillRun:(FLOperation*) operation;
- (void) operationQueue:(FLOperationQueue*) queue operationDidFinish:(FLOperation*) operation;
- (void) operationQueue:(FLOperationQueue*) queue operationDidFail:(FLOperation*) operation;
- (void) operationQueue:(FLOperationQueue*) queue operationWasCancelled:(FLOperation*) operation;
@end

