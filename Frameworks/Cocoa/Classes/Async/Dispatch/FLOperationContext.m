//
//  FLOperationContext.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLOperationContext.h"
#import "FLAsyncQueue.h"
#import "FLDispatch.h"
#import "FLDispatchQueue.h"
#import "FLAsyncQueue.h"
#import "FLOperation.h"

//#define TRACE 1

NSString* const FLWorkerContextStarting = @"FLWorkerContextStarting";
NSString* const FLWorkerContextFinished = @"FLWorkerContextFinished";

NSString* const FLWorkerContextClosed = @"FLWorkerContextClosed";
NSString* const FLWorkerContextOpened = @"FLWorkerContextOpened"; 

@interface FLOperationContext ()
@property (readwrite, assign, getter=isContextOpen) BOOL contextOpen; 
@property (readwrite, assign) NSUInteger contextID;
@end

@implementation FLOperationContext
@synthesize contextOpen = _contextOpen;
@synthesize contextID = _contextID;

- (id) init {
    self = [super init];
    if(self) {
        _operations = [[NSMutableSet alloc] init];
///        _asyncQueue = [[FLFifoAsyncQueue alloc] init];
        _contextOpen = YES;
    }
    
    return self;
}

- (void) dealloc {
//    [_asyncQueue releaseToPool];
#if FL_MRC
//    [_asyncQueue release];
    [_operations release];
    [super dealloc];
#endif
}

+ (id) operationContext {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) visitOperations:(FLOperationVisitor) visitor {

    @synchronized(self) {
        BOOL stop = NO;
        for(id operation in _operations) {
            visitor([operation nonretainedObjectValue], &stop);
            
            if(stop) {
                break;
            }
        }
    }
    
}

- (void) requestCancel {

    @synchronized(self) {
    
        NSSet* copy = FLCopyWithAutorelease(_operations);
        for(id operation in copy) {
#if TRACE
            FLLog(@"cancelled %@", [operation description]);
#endif
        
            FLPerformSelector([operation nonretainedObjectValue], @selector(requestCancel));
        }
    }
}

- (void) openContext {

    self.contextID++;
    
    [self visitOperations:^(id operation, BOOL *stop) {
        [operation contextDidOpen];
    }];

    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:FLWorkerContextOpened object:self];
    });
}


- (void) closeContext {
    [self visitOperations:^(id operation, BOOL *stop) {
        [operation contextDidClose];
    }];

    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:FLWorkerContextClosed object:self];
    });
}

- (void) didAddOperation:(FLOperation*) object {
}

- (void) didRemoveOperation:(FLOperation*) object {
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

- (void) addOperation:(FLOperation*) operation  {
    
    BOOL wasIdle = YES;
    
    @synchronized(self) {
    
#if TRACE
        FLLog(@"Operation added to context: %@", [operation description]);
#endif

       
        wasIdle = _operations.count == 0;
       
        [_operations addObject:[NSValue valueWithNonretainedObject:operation]];
         
        FLOperationContext* oldContext = operation.context;
        if(oldContext && oldContext != self) {
            [operation.context removeOperation:operation];
        }
        [operation wasAddedToContext:self];
        
    }

    [self didAddOperation:operation];

    if(wasIdle) {
        [self didStartWorking];
    }

    if(!self.isContextOpen) {
        [operation requestCancel];
    }
}

- (void) removeOperation:(FLOperation*) operation {

    BOOL didStop = NO;
    
    @synchronized(self) {
    
#if TRACE
        FLLog(@"Operation removed from context: %@", [operation description]);
#endif

        [_operations removeObject:[NSValue valueWithNonretainedObject:operation]];
        if(operation.context == self) {
            [operation wasRemovedFromContext:self];
        }

        didStop = _operations.count == 0;
    }
    
    [self didRemoveOperation:operation];
    
    if(didStop) {
        [self didStopWorking];
    }
}
   
@end



