//
//  FLOperationQueue.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/20/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLOperationQueue.h"
#import "FLAsyncOperationQueueElement.h"
#import "FLDispatchQueue.h"
#import "FLLog.h"
#import "FLSuccessfulResult.h"
#import "FLOperation.h"
#import "FLSynchronousOperation.h"

@interface FLOperationQueue ()
@property (readwrite, assign) NSInteger finishedCount;
@property (readwrite, assign) NSInteger totalCount;
@property (readwrite, assign) BOOL processing;
@property (readwrite, strong) NSError* error;

@property (readonly, strong) NSMutableArray* operationFactories;
@property (readonly, strong) NSMutableArray* activeQueue;
@property (readonly, strong) NSMutableArray* objectQueue;
@property (readonly, strong) FLFifoAsyncQueue* fifoQueue;
// optional overrides

- (void) willStartOperation:(FLAsyncOperationQueueElement*) operation;
- (void) didFinishOperation:(FLAsyncOperationQueueElement*) operation;

@end

@interface FLOperationQueue (FifoQueue)
- (FLOperation*) createOperationForQueuedInputObject:(id) object;
- (void) respondToProcessQueueEvent;
- (void) respondToCancelEvent;
- (void) respondToAddObjectArrayEvent:(NSArray*) array;
- (void) respondToAddObjectEvent:(id) object;
@end

@implementation NSObject (FLOperationQueue)
- (FLOperation*) createOperationForOperationQueue:(FLOperationQueue*) operationQueue {
    return nil;
}
@end

@implementation FLOperation (FLOperationQueue)
- (FLOperation*) createOperationForOperationQueue:(FLOperationQueue*) operationQueue {
    return self;
}
@end

@implementation FLOperationQueue

@synthesize maxConcurrentOperations = _maxConcurrentOperations;
@synthesize finishedCount = _finishedCount;
@synthesize totalCount = _totalCount;
@synthesize processing = _processing;
@synthesize error = _error;
@synthesize activeQueue = _activeQueue;
@synthesize objectQueue = _objectQueue;
@synthesize fifoQueue = _fifoQueue;
@synthesize queueName = _queueName;

FLSynthesizeObservableProperties(_observers);
FLSynthesizeLazyGetter(operationFactories, NSMutableArray*, _operationFactories, NSMutableArray);

- (id) initWithName:(NSString*) name {
	self = [super init];
	if(self) {
        _name = FLRetain(name);
        _fifoQueue = [[FLFifoAsyncQueue alloc] init];
        _activeQueue = [[NSMutableArray alloc] init];
        _objectQueue = [[NSMutableArray alloc] init];
        _maxConcurrentOperations = 1;
	}
	return self;
}

- (id) init {	
    return [self initWithName:nil];
}

- (id) operationQueue {
    return FLAutorelease([[[self class] alloc] init]);
}

- (id) operationQueueWithName:(NSString*) name {
    return FLAutorelease([[[self class] alloc] initWithName:name]);
}

- (void) addOperationFactory:(id<FLOperationQueueOperationFactory>)factory {
    FLAssertWithComment(self.processing == NO, @"can't add a factory while processing");

    [self.operationFactories addObject:factory];
}

- (void) willStartOperation:(FLAsyncOperationQueueElement*) operation {
    [self.observers.notify operationQueue:self
                        didStartOperation:operation.operation
                                forObject:operation.input];
}

- (void) didFinishOperation:(FLAsyncOperationQueueElement*) operation {
    [self.observers.notify operationQueue:self
                       didFinishOperation:operation.operation
                                forObject:operation.input
                               withResult:operation.operationResult];
}

- (void) didFinish {
    self.processing = NO;
    id result = self.error ? self.error : FLSuccess;

    [self.observers.notify operationQueue:self
                      didFinishWithResult:result];
}

- (void) processQueue {
    [self.fifoQueue queueTarget:self action:@selector(respondToProcessQueueEvent)];
}

- (FLAsyncOperationQueueElement*) queueElement:(id) input operation:(id) operation {
// TODO: cache/reuse these?
    return [FLAsyncOperationQueueElement asyncOperationQueueElement:input operation:operation];
}

- (void) queueObjectsInArray:(NSArray*) queuedObjects {
    [self.fifoQueue queueTarget:self action:@selector(respondToAddObjectArrayEvent:) withObject:queuedObjects];
}

- (void) queueObject:(id) object {
    [self.fifoQueue queueTarget:self action:@selector(respondToAddObjectEvent:) withObject:object];
}

- (void) queueOperation:(FLOperation*) operation {
    [self.fifoQueue queueTarget:self action:@selector(respondToAddObjectEvent:) withObject:operation];
}

- (void) startProcessing {
    self.error = nil;
    self.processing = YES;
    [self processQueue];
}

- (void) stopProcessing {
    self.processing = NO;
}

- (void) requestCancel {
    self.error = [NSError cancelError];
    [self.fifoQueue queueTarget:self action:@selector(respondToCancelEvent)];
}


#if FL_MRC 
- (void) dealloc {
    [_name release];
    [_observers release];
    [_error release];
    [_operationFactories release];
    [_activeQueue release];
    [_fifoQueue release];
    [_objectQueue release];
    [super dealloc];
}
#endif

@end

@implementation FLOperationQueue (FifoQueue)

- (void) respondToCancelEvent {
    for(FLOperation* operation in self.activeQueue) {
        FLTrace(@"cancelled: %@", [operation description]);
        [operation requestCancel];
    }
    FLTrace(@"cancelled %d queued operations", _objectQueue.count);

    [self.objectQueue removeAllObjects];
}

- (void) respondToAddObjectArrayEvent:(NSArray*) array {
    [_objectQueue addObjectsFromArray:array];
    self.totalCount += array.count;
    [self processQueue];
}

- (void) respondToAddObjectEvent:(id) object {
    [_objectQueue addObject:object];
    self.totalCount ++;
    [self processQueue];
}

- (void) respondToFinishProcessingObjectEvent:(FLAsyncOperationQueueElement*) element {

    self.finishedCount++;

// don't do anything if we already hit an error
    if(!self.error) {
        
        if([element.operationResult isError]) {
            self.error = element.operationResult;
        }
        
        FLTrace(@"finished operation: %@ withResult: %@", element.operation, [element.operationResult isError] ? element.operationResult : @"OK");

        [self didFinishOperation:element];
    }

    [_activeQueue removeObject:element];
    [self respondToProcessQueueEvent];
}

- (FLOperation*) createOperationForQueuedInputObject:(id) object {

    FLOperation* operation = [object createOperationForOperationQueue:self];

    if(!operation) {
        for(id<FLOperationQueueOperationFactory> factory in _operationFactories) {
            operation = [factory createOperationForQueuedObject:object];

            if(operation) {
                break;
            }
        }
    }

    FLAssertNotNilWithComment(operation, @"no operation created for queue for: %@", [object description]);

    return operation;
}

- (void) respondToProcessQueueEvent {
    if(self.processing) {
        NSInteger max = self.maxConcurrentOperations;

        FLAssertWithComment(max > 0, @"zero max concurrent operations");
        FLTrace(@"max connections: %d", max);

        while(!self.error && _activeQueue.count < max && _objectQueue.count) {
            id object = [_objectQueue removeFirstObject_fl];
            FLAsyncOperationQueueElement* element = [self queueElement:object operation:[self createOperationForQueuedInputObject:object]];
            [_activeQueue addObject:element];

            [self willStartOperation:element];
            
            FLTrace(@"starting operation: %@", operation);

            [element beginOperationInQueue:self completion:^{
                [self.fifoQueue queueBlock: ^{
                    [self respondToFinishProcessingObjectEvent:element];
                }];
            }];
        }
        
        if(self.error) {
            [self respondToCancelEvent];
        }
        
        if(_activeQueue.count == 0 && _objectQueue.count == 0) {
            [self didFinish];
        }
    }
}


@end



@implementation FLBatchOperationQueue : FLOperationQueue
static NSInteger s_threadCount = FLAsyncOperationQueueOperationDefaultMaxConcurrentOperations;

- (id) init {	
	self = [super init];
	if(self) {
		self.maxConcurrentOperations = 0;
	}
	return self;
}

- (void) setMaxConcurrentOperations:(UInt32)maxConcurrentOperations {
    [super setMaxConcurrentOperations:maxConcurrentOperations];

    if(self.processing) {
        [self processQueue];
    }
}

- (UInt32) maxConcurrentOperations {
    UInt32 max = [super maxConcurrentOperations];
    if(!max) {
        max = [FLBatchOperationQueue defaultConnectionLimit];
    }
    return max;
}

+ (void) setDefaultConnectionLimit:(UInt32) threadCount {
    FLAtomicSetInteger(s_threadCount, threadCount);
}

+ (UInt32) defaultConnectionLimit {
    return FLAtomicGetInteger(s_threadCount);
}

@end
