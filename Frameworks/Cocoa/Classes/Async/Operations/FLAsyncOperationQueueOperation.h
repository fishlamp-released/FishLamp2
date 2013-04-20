//
//  FLAsyncOperationQueueOperation.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/20/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAsyncOperation.h"

typedef FLOperation* (^FLOperationFactory)(id object);

#define FLAsyncOperationQueueOperationDefaultMaxConcurrentOperations 3

@interface FLAsyncOperationQueueOperation : FLAsyncOperation {
@private
    NSMutableArray* _queue;
    FLFifoAsyncQueue* _fifoQueue;
    NSMutableArray* _activeQueue;
    FLOperationFactory _operationFactory;
    NSInteger _maxConcurrentOperations;

    SEL _willStartOperationSelectorForDelegate;
    SEL _didFinishOperationSelectorForDelegate;
}
@property (readwrite, assign, nonatomic) NSInteger maxConcurrentOperations;

@property (readwrite, assign, nonatomic) SEL willStartOperationSelectorForDelegate;
@property (readwrite, assign, nonatomic) SEL didFinishOperationSelectorForDelegate;


@property (readwrite, strong, nonatomic) FLOperationFactory operationFactory;

+ (id) asyncOperationQueue:(NSArray*) queuedObjects;

@end

//@property (readwrite, assign, nonatomic) FLOperationQueueActions delegateActions;
//@property (readwrite, assign, nonatomic) FLOperationQueueActions observerActions;
//@property (readonly, strong) FLOperationQueue* operationQueue;

@protocol FLAsyncOperationQueueOperationDelegate <NSObject>
@optional

- (void) asyncOperationQueueOperation:(FLAsyncOperationQueueOperation*) queue willStartOperation:(id) operation;

- (void) asyncOperationQueueOperation:(FLAsyncOperationQueueOperation*) queue didFinishOperation:(id) operation withResult:(FLResult) result;

@end