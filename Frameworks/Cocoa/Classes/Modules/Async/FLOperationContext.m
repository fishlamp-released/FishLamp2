//
//  FLOperationContext.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLOperationContext.h"
#import "FLAsyncQueue.h"
#import "FishLampAsync.h"
#import "FLDispatchQueue.h"
#import "FLAsyncQueue.h"
#import "FLOperation.h"
#import "FLOperationQueue.h"

//#define TRACE 1

NSString* const FLWorkerContextStarting = @"FLWorkerContextStarting";
NSString* const FLWorkerContextFinished = @"FLWorkerContextFinished";

NSString* const FLWorkerContextClosed = @"FLWorkerContextClosed";
NSString* const FLWorkerContextOpened = @"FLWorkerContextOpened"; 

@interface FLOperationContext ()
@property (readwrite, assign, getter=isContextOpen) BOOL contextOpen; 
@property (readwrite, assign) NSUInteger contextID;
@property (readonly, strong) FLOperationQueue* operationQueue;
@end

//@implementation FLAsyncEvent (FLOperationContext)
//- (void) wasAddedToOperationContext:(FLOperationContext*) context {
//}
//@end
//
//@implementation FLOperationEvent (FLOperationContext)
//- (void) wasAddedToOperationContext:(FLOperationContext*) context {
//    [context addOperation:self.operation];
//}
//@end

@implementation FLOperationContext
@synthesize contextOpen = _contextOpen;
@synthesize contextID = _contextID;
@synthesize operationQueue = _operationQueue;

FLSynthesizeNotifierProperties(_broadcaster);

- (id) init {
    self = [super init];
    if(self) {
        static NSInteger s_last = 0;
        _contextID = ++s_last;
        _operationQueue = [[FLOperationQueue alloc] initWithName:[NSString stringWithFormat:@"Operation Context: %ld", _contextID]];
        [self openContext];
    }
    
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_operationQueue release];
    [_broadcaster release];
    [_operationQueue release];
    [super dealloc];
}
#endif

+ (id) operationContext {
    return FLAutorelease([[[self class] alloc] init]);
}

//- (void) visitOperations:(FLOperationVisitor) visitor {
//
//    @synchronized(self) {
//        BOOL stop = NO;
//        for(id operation in _operations) {
//            visitor([operation nonretainedObjectValue], &stop);
//            
//            if(stop) {
//                break;
//            }
//        }
//    }
//}

- (void) requestCancel {
    [self.operationQueue requestCancel];

//    @synchronized(self) {
//    
//        NSSet* copy = FLCopyWithAutorelease(_operations);
//        for(id operation in copy) {
//#if TRACE
//            FLLog(@"cancelled %@", [operation description]);
//#endif
//        
//            FLPerformSelector0([operation nonretainedObjectValue], @selector(requestCancel));
//        }
//    }
}

- (void) openContext {
    [self.operationQueue startProcessing];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:FLWorkerContextOpened object:self];
    });
}


- (void) closeContext {

    [self.operationQueue requestCancel];
    
//    [self visitOperations:^(id operation, BOOL *stop) {
//        [operation contextDidClose];
//    }];

    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:FLWorkerContextClosed object:self];
    });
}

- (void) didAddOperation:(FLOperation*) operation {
    [self.notifier.notify operationContext:self didAddOperation:operation];
}

- (void) didRemoveOperation:(FLOperation*) operation {
    [self.notifier.notify operationContext:self didRemoveOperation:operation];
}

- (void) didStartWorking {

#if TRACE
    FLLog(@"Context started working %@", [self description]);
#endif

    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:FLWorkerContextStarting object:self];
    });
}

- (void) didStopWorking {

    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:FLWorkerContextFinished object:self];
    });

#if TRACE
    FLLog(@"Context stopped working %@", [self description]);
#endif

}

//- (FLPromise*) queueAsyncEvent:(FLAsyncEvent*) event
//                    completion:(fl_completion_block_t) completion {
//    [self.fifoQueue queueAsyncEvent:[FLBlock]]
//    [self.fifoQueue queueAsyncEvent:event];
//}
//
//- (FLPromisedResult) queueSynchronousEvent:(FLAsyncEvent*) event [
//    [self.fifoQueue queueSynchronousEvent:event];
//}

- (void) queueOperation:(FLOperation*) operation  {

    [self.operationQueue queueOperation:operation];

//    BOOL wasIdle = YES;
//    
//    @synchronized(self) {
//    
//#if TRACE
//        FLLog(@"Operation added to context: %@", [operation description]);
//#endif
//
//       
//        wasIdle = _operations.count == 0;
//       
//        [_operations addObject:[NSValue valueWithNonretainedObject:operation]];
//         
//        FLOperationContext* oldContext = operation.context;
//        if(oldContext && oldContext != self) {
//            [operation.context removeOperation:operation];
//        }
//        [operation wasAddedToContext:self];
//        [operation.notifier addListener:self.nonretained_fl];
//    }
//
//    [self didAddOperation:operation];
//
//    if(wasIdle) {
//        [self didStartWorking];
//    }
//
//    if(!self.isContextOpen) {
//        [operation requestCancel];
//    }
}

//- (void) removeOperation:(FLOperation*) operation {
//
//    BOOL didStop = NO;
//    
//    @synchronized(self) {
//    
//#if TRACE
//        FLLog(@"Operation removed from context: %@", [operation description]);
//#endif
//
//        [_operations removeObject:[NSValue valueWithNonretainedObject:operation]];
//        if(operation.context == self) {
//            [operation wasRemovedFromContext:self];
//            [operation.notifier removeListener:self];
//        }
//
//        didStop = _operations.count == 0;
//    }
//    
//    [self didRemoveOperation:operation];
//    
//    if(didStop) {
//        [self didStopWorking];
//    }
//}

@end



