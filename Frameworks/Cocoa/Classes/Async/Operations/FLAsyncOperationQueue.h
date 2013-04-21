//
//  FLAsyncOperationQueue.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/20/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAsyncOperation.h"

typedef FLOperation* (^FLOperationFactory)(id object);

#define FLAsyncOperationQueueOperationDefaultMaxConcurrentOperations 3

@interface FLAsyncOperationQueue : FLAsyncOperation {
@private
    NSMutableArray* _objectQueue;
    FLFifoAsyncQueue* _fifoQueue;
    NSMutableArray* _activeQueue;
    FLOperationFactory _operationFactory;
    NSInteger _maxConcurrentOperations;

    SEL _willStartOperationSelectorForDelegate;
    SEL _didFinishOperationSelectorForDelegate;
    
    NSInteger _processedObjectCount;
    NSInteger _totalObjectCount;
    
    BOOL _finishWhenEmpty;
}

@property (readonly, assign) NSInteger processedObjectCount;
@property (readonly, assign) NSInteger totalObjectCount;
@property (readwrite, assign) BOOL finishWhenEmpty;

@property (readwrite, assign, nonatomic) NSInteger maxConcurrentOperations;

@property (readwrite, assign, nonatomic) SEL willStartOperationSelectorForDelegate;
@property (readwrite, assign, nonatomic) SEL didFinishOperationSelectorForDelegate;

@property (readwrite, strong, nonatomic) FLOperationFactory operationFactory;

- (id) initWithQueuedObjects:(NSArray*) objects; 
+ (id) asyncOperationQueue:(NSArray*) queuedObjects;

- (void) addObjectsFromArray:(NSArray*) queuedObjects;
- (void) addObject:(id) object;

- (void) setQueueNeedsProcessing;

// optional overrides
- (FLOperation*) createOperationForObject:(id) object;
- (void) willStartOperation:(FLOperation*) operation;
- (void) didFinishOperation:(FLOperation*) operation withResult:(FLResult) result ;
- (void) didProcessAllObjects;
@end

@protocol FLAsyncOperationQueueOperationDelegate <NSObject>
@optional

- (void) asyncOperationQueueOperation:(FLAsyncOperationQueue*) queue willStartOperation:(id) operation;

- (void) asyncOperationQueueOperation:(FLAsyncOperationQueue*) queue didFinishOperation:(id) operation withResult:(FLResult) result;

@end