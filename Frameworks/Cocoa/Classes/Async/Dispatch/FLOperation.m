//
//  FLOperation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/29/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLOperation.h"
#import "FLDispatchQueue.h"


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
@synthesize delegate = _delegate;
@synthesize finisher = _finisher;

//#if DEBUG
//- (void) setDelegate:(id) delegate {
//    if(delegate != _delegate) {
//        FLAssertIsNil(_delegate);
//        _delegate = delegate;
//    }
//}
//#endif

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
	[_finisher release];
    [_storageService release];
    [_identifier release];
	[super dealloc];
#endif
}

- (FLPromise*) promise {
    FLPromise* promise = [FLPromise promise];
    [self.finisher addPromise:promise];
    return promise;
}

- (void) finisher:(FLFinisher*) finisher didFinishWithResult:(id) result {
    self.context = nil;
    [self sendFinishMessagesWithResult:result];
    self.cancelled = NO;
}

- (void) startOperation {
    
    id initialData = [self startAsyncOperation];
    [self sendStartMessagesWithInitialData:initialData];
}

- (id) startAsyncOperation {
    FLLog(@"operation did nothing.");
    [self.finisher setFinished];

    return nil;
}

- (void) requestCancel {
    self.cancelled = YES;
}

- (void) setContext:(FLOperationContext*) context {
    if(context) {
        [context addOperation:self];
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
    FLPromisedResult result = [FLStartOperation(self.asyncQueue, self, nil) waitUntilFinished];
//    [self operationDidFinishWithResult:result];
    return result;}

- (FLPromisedResult) runSynchronouslyInContext:(FLOperationContext*) context {
    self.context = context;
    return [self runSynchronously];
}

- (FLPromise*) runAsynchronously:(fl_completion_block_t) completion {
    
    return FLStartOperation(self.asyncQueue, self, completion);
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
    if([operation delegate] == nil) {
        [operation setDelegate:self];
    }
    if([operation context] == nil) {
        [operation setContext:self.context];
    }
    if([operation asyncQueue] == nil) {
        [operation setAsyncQueue:self.asyncQueue];
    }
    if([operation observer] == nil) {
        [operation setObserver:self.observer];
    }
}

- (void) didRunChildOperation:(FLOperation*) operation {
    if([operation delegate] == self) {
        [operation setDelegate:nil];
    }
}

- (FLPromisedResult) runChildSynchronously:(FLOperation*) operation {

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

- (void) sendStartMessagesWithInitialData:(id) initialData {
}
- (void) sendFinishMessagesWithResult:(FLPromisedResult) result {
}

- (void) setFinished {
    [self setFinishedWithResult:FLSuccessfullResult];
}

- (void) setFinishedWithResult:(FLPromisedResult) result {
    [self.finisher setFinishedWithResult:result];
}


@end