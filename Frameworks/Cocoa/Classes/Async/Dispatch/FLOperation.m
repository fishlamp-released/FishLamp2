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
@end

@implementation FLOperation

@synthesize context = _context;
@synthesize contextID = _contextID;
@synthesize asyncQueue = _asyncQueue;
@synthesize identifier = _identifier;
@synthesize objectStorage = _objectStorage;
@synthesize cancelled = _cancelled;
@synthesize delegate = _delegate;
@synthesize finishedSelector = _finishedSelector;
@synthesize retryCount = _retryCount;

#if DEBUG
- (void) setDelegate:(id) delegate {
    if(delegate != _delegate) {
        FLAssertIsNil(_delegate);
        _delegate = delegate;
    }
}
#endif

- (id) init {
    self = [super init];
    if(self) {
        self.asyncQueue = [FLDispatchQueue defaultQueue];
  		static int32_t s_counter = 0;
        self.identifier = [NSNumber numberWithInt:FLAtomicIncrement32(s_counter)];
        _finishedSelector = @selector(operationDidFinish:withResult:);
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
    
#if FL_MRC
    [_objectStorage release];
    [_identifier release];
	[super dealloc];
#endif
}

- (void) performUntilFinished:(FLFinisher*) finisher {
    FLLog(@"operation did nothing.");
    [finisher setFinished];
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

- (FLResult) runSynchronously {
    FLResult result = [FLStartOperation(self.asyncQueue, self, nil) waitUntilFinished];
    [self operationDidFinishWithResult:result];
    return result;
}

- (FLResult) runSynchronouslyInContext:(FLOperationContext*) context {
    self.context = context;
    return [self runSynchronously];
}

- (FLFinisher*) runAsynchronously:(fl_completion_block_t) completion {
    return FLStartOperation(self.asyncQueue, self, completion);
}

- (FLFinisher*) runAsynchronously {
    return [self runAsynchronously:nil];
}

- (FLFinisher*) runAsynchronouslyInContext:(FLOperationContext*) context 
                         completion:(fl_completion_block_t) completionOrNil {
    self.context = context;
    return [self runAsynchronously:completionOrNil];
}

- (void) willRunInParent:(FLOperation*) parent {
    if(self.context == nil) {
        self.context = parent.context;
    }
    if(self.asyncQueue == nil) {
        self.asyncQueue = parent.asyncQueue;
    }
}

- (void) didFinishInParent:(FLOperation*) parent withResult:(FLResult) result {
    [self operationDidFinishWithResult:result];
}

- (void) willStartChildOperation:(id) childOperation {
    [childOperation willRunInParent:self];
}

- (void) didFinishChildOperation:(id) operation withResult:(FLResult) result {
    [operation didFinishInParent:self withResult:result];
}

- (FLResult) runChildSynchronously:(FLOperation*) operation {

    [self willStartChildOperation:FLRetainWithAutorelease(operation)];
    
    FLResult result = nil;
    @try {
        result = [operation runSynchronously];
    }
    @catch(NSException* ex) {
        result = FLRetainWithAutorelease(ex.error);
    }
    FLAssertNotNilWithComment(result, @"result should not be nil");
    
    [self didFinishChildOperation:operation withResult:result];
    
    return result;
}

- (FLFinisher*) runChildAsynchronously:(FLOperation*) operation 
                completion:(fl_completion_block_t) completionOrNil {

    [self willStartChildOperation:operation];
    if(completionOrNil) {
        completionOrNil = FLCopyWithAutorelease(completionOrNil);
    }
    
    return [operation runAsynchronously:^(FLResult result) {
        [self didFinishChildOperation:operation withResult:result];
        if(completionOrNil) {
            completionOrNil(result);
        }
    }];
}

- (FLFinisher*) runChildAsynchronously:(FLOperation*) operation {
    return [self runChildAsynchronously:operation completion:nil];
}

- (void) operationDidFinishWithResult:(FLResult) result {
    self.context = nil;
    FLPerformSelector2(_delegate, _finishedSelector, self, result);
    self.cancelled = NO;
}





@end