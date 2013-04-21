//
//  FLAsyncOperationQueue.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/20/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAsyncOperationQueue.h"
#import "FLAsyncQueue.h"
#import "FLFinisher.h"
#import "FLSelectorPerforming.h"
#import "FLDispatchQueue.h"

#import "FLTrace.h"

@interface FLAsyncOperationQueue ()
@property (readwrite, strong) FLFifoAsyncQueue* fifoQueue; 
@property (readwrite, assign) NSInteger processedObjectCount;
@property (readwrite, assign) NSInteger totalObjectCount;

- (void) processQueue;
@end

@implementation FLAsyncOperationQueue

@synthesize maxConcurrentOperations = _maxConcurrentOperations;
@synthesize fifoQueue = _fifoQueue;
@synthesize operationFactory = _operationFactory;
@synthesize processedObjectCount = _processedObjectCount;
@synthesize totalObjectCount = _totalObjectCount;
@synthesize willStartOperationSelectorForDelegate = _willStartOperationSelectorForDelegate;
@synthesize didFinishOperationSelectorForDelegate = _didFinishOperationSelectorForDelegate;
@synthesize finishWhenEmpty = _finishWhenEmpty;

- (id) init {	
    return [self initWithQueuedObjects:nil];
}

- (id) initWithQueuedObjects:(NSArray*) items {	
	self = [super init];
	if(self) {
        if(items) {
            _objectQueue = [items mutableCopy];
        }
        else {
            _objectQueue = [[NSMutableArray alloc] init];
        }
        _finishWhenEmpty = YES;
        _totalObjectCount = _objectQueue.count;
        _fifoQueue = [[FLFifoAsyncQueue alloc] init];
        _activeQueue = [[NSMutableArray alloc] init];
        _maxConcurrentOperations = FLAsyncOperationQueueOperationDefaultMaxConcurrentOperations;
        
        self.willStartOperationSelectorForDelegate = @selector(asyncOperationQueueOperation:willStartOperation:);
        self.didFinishOperationSelectorForDelegate = @selector(asyncOperationQueueOperation:didFinishOperation:withResult:); 
	}
	return self;
}

+ (id) asyncOperationQueue:(NSArray*) queuedObjects {
    return FLAutorelease([[[self class] alloc] initWithQueuedObjects:queuedObjects]);
}

- (FLOperation*) createOperationForObject:(id) object {
    return _operationFactory ? _operationFactory(object) : (FLOperation*) object;
}

- (void) processFinishedOperation:(FLOperation*) operation result:(FLResult) result {

    FLTrace(@"finished operation: %@ withResult: %@", operation, result);

    if([result isErrorResult]) {
        
    }
    
    [_activeQueue removeObject:operation];
    self.processedObjectCount++;
    
    [self didFinishOperation:operation withResult:result];
    [self processQueue];
}

- (void) willStartOperation:(FLOperation*) operation {
    FLPerformSelector2(self.delegate, self.willStartOperationSelectorForDelegate, self, operation);
}

- (void) didFinishOperation:(FLOperation*) operation withResult:(FLResult) result {
    FLPerformSelector3(self.delegate, self.didFinishOperationSelectorForDelegate, self, operation, result);
}


- (void) operationDidFinish:(id) operation withResult:(id)result {

    FLDispatchSelectorAsync2(self.fifoQueue, 
                             self, 
                             @selector(processFinishedOperation:result:), 
                             operation, 
                             result, 
                             nil);
}

- (void) didProcessAllObjects {

    if((self.wasCancelled || self.processedObjectCount > 0) && self.finishWhenEmpty) {
#if TRACE
        FLTrace(@"async queue processing is done: %@", self);
#endif
    
        [self setFinished];
    }
}

- (void) processCancelRequest {
    
    for(FLOperation* operation in _activeQueue) {
        FLTrace(@"cancelled: %@", self);
        [operation requestCancel];
    }
    FLTrace(@"cancelled %d queued operations", _objectQueue.count);

    [_objectQueue removeAllObjects];
    [self processQueue];
}

- (void) requestCancel {
    [super requestCancel];
    FLDispatchSelectorAsync(self.fifoQueue, self, @selector(processCancelRequest), nil);
}

- (void) processQueue {
    while(_activeQueue.count < _maxConcurrentOperations && _objectQueue.count) {
        id object = [_objectQueue removeFirstObject];

        FLOperation* operation = [self createOperationForObject:object];
        operation.delegate = self;
        [_activeQueue addObject:operation];

        [self willStartOperation:operation];
        FLTrace(@"starting operation: %@", operation);
        [self runChildAsynchronously:operation];
    }
    
    if(_activeQueue.count == 0 && _objectQueue.count == 0) {
        [self didProcessAllObjects];
    }
}

- (void) processAddObjects:(NSArray*) array {
    
    [_objectQueue addObjectsFromArray:array];
    self.totalObjectCount += array.count;

    [self processQueue];
}

- (void) processAddObject:(id) object {
    [_objectQueue addObject:object];
    [self processQueue];
}

- (void) addObjectsFromArray:(NSArray*) queuedObjects {
    FLDispatchSelectorAsync1(self.fifoQueue, self, @selector(processAddObjects:), queuedObjects, nil);
}

- (void) addObject:(id) object {
    FLDispatchSelectorAsync1(self.fifoQueue, self, @selector(processAddObject:), object, nil);
}

- (void) setQueueNeedsProcessing {
    FLDispatchSelectorAsync(self.fifoQueue, self, @selector(processQueue), nil);
}

- (void) performUntilFinished:(FLFinisher*) finisher {
    [super performUntilFinished:finisher];
    
    FLTrace(@"starting async queue processing: %@", self);
    [self setQueueNeedsProcessing];
}

#if FL_MRC 
- (void) dealloc {
    [_operationFactory release];
    [_activeQueue release];
    [_fifoQueue release];
    [_objectQueue release];
    [super dealloc];
}
#endif

@end
