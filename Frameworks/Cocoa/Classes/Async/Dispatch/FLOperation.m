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
    return FLRunOperation(self.asyncQueue, self);
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

//- (FLFinisher*) startAsync {
//    return [self start:nil];
//}

- (void) wasStartedByParent:(FLOperation*) parent {
    if(self.context == nil) {
        self.context = parent.context;
    }
    if(self.asyncQueue == nil) {
        self.asyncQueue = parent.asyncQueue;
    }
}

- (FLResult) runChildSynchronously:(FLOperation*) operation {
    
    [operation wasStartedByParent:self];
    
    FLResult result = [operation runSynchronously];
    FLThrowIfError(result);
    
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