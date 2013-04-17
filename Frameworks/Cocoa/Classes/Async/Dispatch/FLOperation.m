//
//  FLOperation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/29/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLOperation.h"
#import "FLDispatchQueue.h"

@implementation FLOperation

@synthesize context = _context;
@synthesize contextID = _contextID;
@synthesize asyncQueue = _asyncQueue;

- (id) init {
    self = [super init];
    if(self) {
        self.asyncQueue = [FLDispatchQueue defaultQueue];
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
	[super dealloc];
#endif
}

- (void) performUntilFinished:(FLFinisher*) finisher {
    FLLog(@"operation did nothing.");
    [finisher setFinished];
}                      

- (void) requestCancel {

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
    [self operationDidFinish];
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

- (void) wasStartedByParent:(FLOperation*) parent {
    if(self.context == nil) {
        self.context = parent.context;
    }
    if(self.asyncQueue == nil) {
        self.asyncQueue = parent.asyncQueue;
    }
}

- (FLResult) runChildSynchronously:(FLOperation*) operation {
    [FLRetainWithAutorelease(operation) wasStartedByParent:self];
    
    FLResult result = nil;
    @try {
        result = [operation runSynchronously];
    }
    @finally {
        [operation operationDidFinish];
    }
    
    FLAssertNotNilWithComment(result, @"result should not be nil");
    
    return result;
}

- (FLFinisher*) runChildAsynchronously:(FLOperation*) operation 
                completion:(fl_completion_block_t) completionOrNil {

    [operation wasStartedByParent:self];
    
    return [operation runAsynchronously:completionOrNil];
}

- (void) operationDidFinish {
    self.context = nil;
}



@end