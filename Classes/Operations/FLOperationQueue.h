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
#import "FLLinkedList.h"

typedef id (^FLCreateOperationBlock)();

typedef void (^FLOperationQueueBlock)(FLOperationQueue* queue, id operation);

@interface FLOperationQueue : FLOperation {
@private
	FLLinkedList* _operations;
	FLOperation* _currentOperation;
    FLOperationQueueBlock _onWillBeginOperation;
    FLOperationQueueBlock _onDidFinishOperation;

    BOOL _cancelled;

    __weak FLOperation* _failedOperation;
} 

@property (readonly, strong, nonatomic) id failedOperation;

@property (readonly, strong, nonatomic) id firstOperation;

@property (readonly, strong, nonatomic) id currentOperation;

@property (readonly, strong, nonatomic) id lastOperation; 

@property (readonly, assign, nonatomic) NSUInteger operationCount;

@property (readwrite, copy, nonatomic) FLOperationQueueBlock onWillBeginOperation;

@property (readwrite, copy, nonatomic) FLOperationQueueBlock onDidFinishOperation;

- (void) queueOperationWithFactory:(FLCreateOperationBlock) factoryBlock;

- (void) queueOperation:(FLOperation*) operation;

- (void) queueBlock:(FLOperationBlock) operationBlock;

- (void) queueTarget:(id) target action:(SEL) action; // @selector(callback:) parameter is the operation

- (void) insertOperation:(FLOperation*) newOperation
          afterOperation:(FLOperation*) afterOperation;

- (id) operationById:(id) operationId;

- (id) operationByTag:(NSInteger) operationTag;

- (id) operationByClass:(Class) class;

// output helpers

@property (readonly, retain, nonatomic) id firstOperationOutput;

@property (readonly, retain, nonatomic) id lastOperationOutput;

- (id) outputById:(id) operationId;

- (id) outputByTag:(NSInteger) operationTag;

- (id) outputByOperationClass:(Class) aClass;

@end

