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
@property (readwrite, assign) BOOL processing;

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
@synthesize processing = _processing;

static NSInteger s_threadCount = FLAsyncOperationQueueOperationDefaultMaxConcurrentOperations;

+ (void) setDefaultConnectionLimit:(NSInteger) threadCount {
    FLAtomicSetInteger(s_threadCount, threadCount);
}

+ (NSInteger) defaultConnectionLimit {
    return FLAtomicGetInteger(s_threadCount);
}

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
        _totalObjectCount = _objectQueue.count;
        _fifoQueue = [[FLFifoAsyncQueue alloc] init];
        _activeQueue = [[NSMutableArray alloc] init];
        
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

    FLTrace(@"finished operation: %@ withResult: %@", operation, [result error] ? result : @"OK");
    [_activeQueue removeObject:operation];
    self.processedObjectCount++;
    
    [self didFinishOperationInAsyncQueue:operation withResult:result];
    [self processQueue];
}

- (void) willStartOperationInAsyncQueue:(id) operation {
    FLPerformSelector2(self.delegate, self.willStartOperationSelectorForDelegate, self, operation);
}

- (void) didFinishOperationInAsyncQueue:(id) operation withResult:(FLResult) result {
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

- (void) didProcessAllObjectsInAsyncQueue {
    self.processing = NO;
    [self setFinished];
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
    if(self.processing) {
        NSInteger max = self.maxConcurrentOperations;
        if(max == 0) {
            max = [FLAsyncOperationQueue defaultConnectionLimit];
        }
        FLTrace(@"max connections: %d", max);
        
        while(_activeQueue.count < max && _objectQueue.count) {
            id object = [_objectQueue removeFirstObject];

            FLOperation* operation = [self createOperationForObject:object];
            operation.delegate = self;
            [_activeQueue addObject:operation];

            [self willStartOperationInAsyncQueue:operation];
            FLTrace(@"starting operation: %@", operation);
            [self runChildAsynchronously:operation];
        }
        
        if(_activeQueue.count == 0 && _objectQueue.count == 0) {
            [self didProcessAllObjectsInAsyncQueue];
        }
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

- (void) startProcessing {
    self.processing = YES;
    FLDispatchSelectorAsync(self.fifoQueue, self, @selector(processQueue), nil);
}

//- (void) performUntilFinished:(FLFinisher*) finisher {
//    [super performUntilFinished:finisher];
//    
//    FLTrace(@"starting async queue processing: %@", self);
//    [self setQueueNeedsProcessing];
//}

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
