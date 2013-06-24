//
//  FLAsyncOperationQueue.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/20/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLAsyncOperationQueue.h"
#import "FishLampAsync.h"

@interface FLAsyncOperationQueue ()
@property (readwrite, strong) FLFifoAsyncQueue* fifoQueue; 
@property (readwrite, assign) NSInteger processedObjectCount;
@property (readwrite, assign) NSInteger totalObjectCount;
@property (readwrite, assign) BOOL processing;
@property (readwrite, strong) NSError* error;

- (void) processQueue;
@end

@interface FLAsyncOperation (FLAsyncOperationQueue)
@property (readwrite, strong) id threadID;
@end


@implementation FLAsyncOperationQueue

@synthesize maxConcurrentOperations = _maxConcurrentOperations;
@synthesize fifoQueue = _fifoQueue;
@synthesize operationFactory = _operationFactory;
@synthesize processedObjectCount = _processedObjectCount;
@synthesize totalObjectCount = _totalObjectCount;
@synthesize processing = _processing;
@synthesize error = _error;
#if REFACTOR
@synthesize startedOperationSelector = _startedOperationSelector;
@synthesize finishedOperationSelector = _finishedOperationSelector;
#endif

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

#if REFACTOR
        _startedOperationSelector = @selector(asyncOperationQueue:willStartOperation:withQueuedObject:);
        _finishedOperationSelector = @selector(asyncOperationQueue:didFinishOperation:withQueuedObject:withResult:error:);
#endif

//        self.willStartOperationSelectorForDelegate = @selector(asyncOperationQueueOperation:willStartOperation:);
//        self.didFinishOperationSelectorForDelegate = @selector(asyncOperationQueueOperation:didFinishOperation:withResult:); 
	}
	return self;
}

+ (id) asyncOperationQueue:(NSArray*) queuedObjects {
    return FLAutorelease([[[self class] alloc] initWithQueuedObjects:queuedObjects]);
}

- (FLOperation*) createOperationForObject:(id) object {
    return _operationFactory ? _operationFactory(object) : (FLOperation*) object;
}

- (void) willStartOperation:(id) operation withQueuedObject:(id) object {
#if REFACTOR
    [self.delegate performOptionalSelector:_startedOperationSelector withObject:self withObject:operation withObject:object];
#endif
}

- (void) didFinishOperation:(id) operation
           withQueuedObject:(id) object
                 withResult:(id) result
                      error:(NSError*) error {
#if REFACTOR

   [self.delegate performOptionalSelector:_finishedOperationSelector
                               withObject:self
                               withObject:operation
                               withObject:object
                               withObject:result
                               withObject:error];
#endif
}

- (void) didFinish {
    self.processing = NO;
    if(self.error) {
        [self setFinishedWithResult:self.error];
    }
    else {
        [self setFinished];
    }
}

- (void) processCancelRequest {
    
    for(FLOperation* operation in _activeQueue) {
        FLTrace(@"cancelled: %@", [operation description]);
        [operation requestCancel];
    }
    FLTrace(@"cancelled %d queued operations", _objectQueue.count);

    [_objectQueue removeAllObjects];
}

- (void) requestCancel {
    [super requestCancel];
    self.error = [NSError cancelError];
    
    FLDispatchSelectorAsync(self.fifoQueue, self, @selector(processCancelRequest), nil);
    FLDispatchSelectorAsync(self.fifoQueue, self, @selector(processQueue), nil);
}

- (NSString*) queueName {
    return @"";
}

- (void) anOperationDidFinish:(id) operation
                       object:(id) object
                   withResult:(id) result
                        error:(NSError*) error {

    FLDispatchAsync(self.fifoQueue, ^{
        [_activeQueue removeObject:operation];
        self.processedObjectCount++;
    
        if(!self.error) {
            
            if(error) {
                self.error = error;
            }
            
            FLTrace(@"finished operation: %@ withResult: %@", operation, error ? result : @"OK");
            [self didFinishOperation:operation withQueuedObject:object withResult:result error:error];
        }

        [self processQueue];
    },
    nil);
}

- (void) processQueue {
    if(self.processing) {
        NSInteger max = self.maxConcurrentOperations;
        if(max == 0) {
            max = [FLAsyncOperationQueue defaultConnectionLimit];
        }
        FLTrace(@"max connections: %d", max);
        
        
        while(!self.error && _activeQueue.count < max && _objectQueue.count) {
            id object = [_objectQueue removeFirstObject];

            FLOperation* operation = [self createOperationForObject:object];
            operation.delegate = self;
            [_activeQueue addObject:operation];
            
            [self willStartOperation:operation withQueuedObject:object];
            
            FLTrace(@"starting operation: %@", operation);
            [self runChildAsynchronously:operation completion:^(id result, NSError* error) {
                [self anOperationDidFinish:operation object:object withResult:result error:error];
            }];
        }
        
        if(self.error) {
            [self processCancelRequest];
        }
        
        if(_activeQueue.count == 0 && _objectQueue.count == 0) {
            [self didFinish];
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
    self.error = nil;
    self.processing = YES;
    FLDispatchSelectorAsync(self.fifoQueue, self, @selector(processQueue), nil);
}

- (id) startAsyncOperation {
    [self startProcessing];
    return nil;
}

//- (void) startAsyncOperation:(FLFinisher*) finisher {
//    [super startAsyncOperation:finisher];
//    
//    FLTrace(@"starting async queue processing: %@", self);
//    [self setQueueNeedsProcessing];
//}

#if FL_MRC 
- (void) dealloc {
    [_error release];
    [_operationFactory release];
    [_activeQueue release];
    [_fifoQueue release];
    [_objectQueue release];
    [super dealloc];
}
#endif

@end
