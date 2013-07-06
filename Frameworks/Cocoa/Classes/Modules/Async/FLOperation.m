//
//  FLOperation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/29/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLOperation.h"
#import "FishLampAsync.h"
#import "FLBroadcaster.h"

@interface FLOperation ()
@property (readwrite, assign, getter=wasCancelled) BOOL cancelled;
@property (readwrite, strong) FLFinisher* finisher; 
@end

@implementation FLOperation

@synthesize context = _context;
@synthesize contextID = _contextID;
@synthesize asyncQueue = _asyncQueue;
@synthesize identifier = _identifier;
@synthesize storageService = _storageService;
@synthesize cancelled = _cancelled;
@synthesize finisher = _finisher;

- (id) init {
    self = [super init];
    if(self) {
        self.asyncQueue = [FLDispatchQueue defaultQueue];
  		static int32_t s_counter = 0;
        self.identifier = [NSNumber numberWithInt:FLAtomicIncrement32(s_counter)];
        self.finisher = [FLFinisher finisher];
        self.finisher.delegate = self;
    }
    return self;
}

- (void) dealloc {
    if(_context) {
        FLOperationContext* context = _context;
        _context = nil;
        [context removeOperation:self];
        
        FLLog(@"Operation last ditch removal from context: %@", [self description]);
    }
    _finisher.delegate = nil;
    
#if FL_MRC
    [_identifier release];
    [_asyncQueue release];
    [_storageService release];
	[_finisher release];
	[super dealloc];
#endif
}

- (FLFinisher*) asyncQueueWillBeginAsync:(id<FLAsyncQueue>) asyncQueue {
    return self.finisher;
}

- (void) asyncQueue:(id<FLAsyncQueue>) asyncQueue beginAsyncWithFinisher:(FLFinisher*) finisher {
    [self startOperation];
    [self.observers notify:@selector(operationWillBegin:) withObject:self];
}

- (id<FLPromisedResult>) asyncQueueRunSynchronously:(id<FLAsyncQueue>) asyncQueue {
    return [self runSynchronously];
}

- (void) startOperation {
    FLLog(@"operation did nothing.");
    [self.finisher setFinished];
}

- (void) requestCancel {
    self.cancelled = YES;
}

- (void) setContext:(FLOperationContext*) context {
    if(context) {
        [context queueOperation:self];
    }
    else {
        [self.context removeOperation:self];
    }
}

- (void) wasAddedToContext:(FLOperationContext*) context {
    if(_context != context) {
        _context = context;
        _contextID = [context contextID];
    }
}

- (void) contextDidClose {
    [self requestCancel];
    self.context = nil;
}

- (void) contextDidOpen {

}

- (void) contextDidCancel {
    [self requestCancel];
    self.context = nil;
}

- (void) wasRemovedFromContext:(FLOperationContext*) context {
    if(_context == context) {
        _context = nil;
        _contextID = 0;
    }
}

- (FLPromisedResult) runSynchronously {
    return [[self.asyncQueue queueOperation:self] waitUntilFinished];
}

- (FLPromisedResult) runSynchronouslyInContext:(FLOperationContext*) context {
    self.context = context;
    return [self runSynchronously];
}

- (FLPromise*) runAsynchronously:(fl_completion_block_t) completion {
    return [self.asyncQueue queueOperation:self withCompletion:completion];
}

- (FLPromise*) runAsynchronously {
    return [self runAsynchronously:nil];
}

- (FLPromise*) runAsynchronouslyInContext:(FLOperationContext*) context 
                         completion:(fl_completion_block_t) completionOrNil {
    self.context = context;
    return [self runAsynchronously:completionOrNil];
}

- (void) willRunChildOperation:(FLOperation*) operation {

    [operation.observers addObserver:[FLRetainedObject retainedObject:self.observers]];

    if([operation context] == nil) {
        [operation setContext:self.context];
    }
    if([operation asyncQueue] == nil) {
        [operation setAsyncQueue:self.asyncQueue];
    }

//    if([operation observer] == nil) {
//        [operation setObserver:self.observer];
//    }
}

- (void) didRunChildOperation:(FLOperation*) operation {
    [operation.observers removeObserver:self.observers];
}

- (FLPromisedResult) runChildSynchronously:(FLOperation*) operation {

    FLAssertNotNilWithComment(operation, @"child operation is nil");

    [self willRunChildOperation:operation];
    
    FLPromisedResult result = nil;
    @try {
        result = [operation runSynchronously];
    }
    @catch(NSException* ex) {
        result = ex.error;
    }

    FLAssertNotNilWithComment(result, @"result should not be nil");
    
    [self didRunChildOperation:operation];
        
    return result;
}

- (FLPromise*) runChildAsynchronously:(FLOperation*) operation 
                           completion:(fl_completion_block_t) completionOrNil {

    [self willRunChildOperation:operation];
    
    if(completionOrNil) {
        completionOrNil = FLCopyWithAutorelease(completionOrNil);
    }
    
    return [operation runAsynchronously:^(FLPromisedResult result) {
        [self didRunChildOperation:operation];
        
        if(completionOrNil) {
            completionOrNil(result);
        }
    }];
}

- (FLPromise*) runChildAsynchronously:(FLOperation*) operation {
    return [self runChildAsynchronously:operation completion:nil];
}

- (void) abortIfCancelled {
    if(self.wasCancelled) {
        FLThrowError([NSError cancelError]);
    }
}


- (void) finisherDidFinish:(FLFinisher*) finisher
                withResult:(FLPromisedResult) result {
            
    [self didFinishWithResult:result];
    [self.observers notify:@selector(operationDidFinish:withResult:) withObject:self withObject:result];
    self.context = nil;
    self.cancelled = NO;
}

- (void) didFinishWithResult:(FLPromisedResult) result {
}

- (void) setFinished {
    [self setFinishedWithResult:[FLSuccessfulResult successfulResult]];
}

- (void) setFinishedWithResult:(id) result {
    [self.finisher setFinishedWithResult:result];
}




@end