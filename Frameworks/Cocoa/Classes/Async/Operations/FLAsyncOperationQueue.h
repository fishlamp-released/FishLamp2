//
//  FLAsyncOperationQueue.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/20/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
    NSInteger _processedObjectCount;
    NSInteger _totalObjectCount;
    BOOL _processing;
    NSError* _error;

    SEL _startedOperationSelector;
    SEL _finishedOperationSelector;
}

@property (readonly, strong) NSString* queueName;

@property (readonly, assign) NSInteger processedObjectCount;
@property (readonly, assign) NSInteger totalObjectCount;

@property (readwrite, assign) NSInteger maxConcurrentOperations;

@property (readwrite, strong, nonatomic) FLOperationFactory operationFactory;

- (id) initWithQueuedObjects:(NSArray*) objects; 
+ (id) asyncOperationQueue:(NSArray*) queuedObjects;

- (void) addObjectsFromArray:(NSArray*) queuedObjects;
- (void) addObject:(id) object;

- (void) startProcessing;

// optional overrides
- (FLOperation*) createOperationForObject:(id) object;
- (void) willStartOperation:(id) operation withQueuedObject:(id) object;
- (void) didFinishOperation:(id) operation withQueuedObject:(id) object withResult:(FLPromisedResult) result;


// use these to change the delegate selectors
@property (readwrite, assign, nonatomic) SEL startedOperationSelector;
@property (readwrite, assign, nonatomic) SEL finishedOperationSelector;

+ (void) setDefaultConnectionLimit:(NSInteger) threadCount;

+ (NSInteger) defaultConnectionLimit;

@end

@protocol FLAsyncOperationQueueDelegate <NSObject>
@optional

- (void) asyncOperationQueue:(FLAsyncOperationQueue*) queue 
          willStartOperation:(id) operation 
            withQueuedObject:(id) object;

- (void) asyncOperationQueue:(FLAsyncOperationQueue*) queue 
          didFinishOperation:(id) operation 
            withQueuedObject:(id) object 
                  withResult:(FLPromisedResult) result;

@end