//
//  FLAsyncOperationQueueOperation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/20/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAsyncOperationQueueOperation.h"
#import "FLAsyncQueue.h"
#import "FLFinisher.h"
#import "FLSelectorPerforming.h"
#import "FLDispatchQueue.h"

#define TRACE 1

@interface FLAsyncOperationQueueOperation ()
@property (readwrite, strong) FLFifoAsyncQueue* fifoQueue; 
- (void) processQueue;
@end

@implementation FLAsyncOperationQueueOperation
@synthesize maxConcurrentOperations = _maxConcurrentOperations;
@synthesize fifoQueue = _fifoQueue;
@synthesize operationFactory = _operationFactory;

@synthesize willStartOperationSelectorForDelegate = _willStartOperationSelectorForDelegate;
@synthesize didFinishOperationSelectorForDelegate = _didFinishOperationSelectorForDelegate;

//@synthesize operationQueue = _queue;
//@synthesize delegateActions = _delegateActions;
//@synthesize observerActions = _observerActions;

- (id) initWithQueuedObjects:(NSArray*) items {	
	self = [super init];
	if(self) {
        _queue = [items mutableCopy];
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

- (void) processFinishedOperation:(FLOperation*) operation result:(FLResult) result {

#if TRACE
    FLLog(@"finished operation: %@ withResult: %@", operation, result);
#endif

    if([result isErrorResult]) {
        
    }
    
    [_activeQueue removeObject:operation];
    
    FLPerformSelector3(self.delegate, self.didFinishOperationSelectorForDelegate, self, operation, result);
    
    [self processQueue];
}

- (void) operationDidFinish:(id) operation withResult:(id)result {

    FLDispatchSelectorAsync2(self.fifoQueue, 
                             self, 
                             @selector(processFinishedOperation:result:), 
                             operation, 
                             result, 
                             nil);
}

- (void) processQueue {
    while(_activeQueue.count < _maxConcurrentOperations && _queue.count) {
        id object = [_queue removeFirstObject];

        FLOperation* operation = _operationFactory ? _operationFactory(object) : (FLOperation*) object;
        operation.delegate = self;
        
        [_activeQueue addObject:operation];

        FLPerformSelector2(self.delegate, self.willStartOperationSelectorForDelegate, self, operation);
        
#if TRACE
        FLLog(@"starting operation: %@", operation);
#endif
        [self runChildAsynchronously:operation];
    }
    
    if(_activeQueue.count == 0 && _queue.count == 0) {
    
#if TRACE
        FLLog(@"async queue processing is done: %@", self);
#endif
    
        [self setFinished];
    }
}

- (void) performUntilFinished:(FLFinisher*) finisher {
    [super performUntilFinished:finisher];
    
#if TRACE
    FLLog(@"starting async queue processing: %@", self);
#endif

    FLDispatchSelectorAsync(self.fifoQueue, self, @selector(processQueue), nil);
}


#if FL_MRC 
- (void) dealloc {
    [_operationFactory release];
    [_activeQueue release];
    [_fifoQueue release];
    [_queue release];
    [super dealloc];
}
#endif

@end
