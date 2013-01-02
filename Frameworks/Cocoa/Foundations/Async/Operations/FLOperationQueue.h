//
//	FLOperationQueue.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/4/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLCore.h"
#import "FLOperation.h"
#import "FLCollectionIterator.h"
#import "FLContextuallyDispatchable.h"

@class FLOperationQueue;

typedef void (^FLOperationQueueVisitor)(id operation, BOOL* stop);
typedef id (^FLCreateOperationBlock)();


@interface FLOperationQueue : FLObservable<FLContextuallyDispatchable, NSFastEnumeration> {
@private
	NSMutableArray* _operations;
    BOOL _cancelled;
    FLOperation* _currentOperation;
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

- (id) operationByClass:(Class) class;

//
- (FLResult) firstOperationOutput:(NSDictionary*) inResult;

- (FLResult) lastOperationOutput:(NSDictionary*) inResult;

- (id) outputByOperationClass:(Class) aClass  inResult:(NSDictionary*) inResult;

- (void) removeOperation:(FLOperation*) operation;

- (void) removeAllOperations;

// optional overrides
- (void) operationWasAdded:(FLOperation*) operation;
- (void) operationWasRemoved:(FLOperation*) operation;
@end

@protocol FLOperationQueueObserver <NSObject>
- (void) operationQueue:(FLOperationQueue*) queue operationWasAdded:(FLOperation*) operation;
- (void) operationQueue:(FLOperationQueue*) queue operationWasRemoved:(FLOperation*) operation;

- (void) operationQueue:(FLOperationQueue*) queue operationWillRun:(FLOperation*) operation;
- (void) operationQueue:(FLOperationQueue*) queue operationDidFinish:(FLOperation*) operation;
- (void) operationQueue:(FLOperationQueue*) queue operationWasCancelled:(FLOperation*) operation;
@end

