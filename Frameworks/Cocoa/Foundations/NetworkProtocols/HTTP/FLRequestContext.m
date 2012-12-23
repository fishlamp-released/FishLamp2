//
//  FLRequestContext.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLRequestContext.h"

@implementation FLRequestContext

- (id) init {
    self = [super init];
    if(self) {
        _requests = [[NSMutableArray alloc] init];
        _schedulingQueue = [[FLFifoDispatchQueue alloc] init];
    }
    
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_schedulingQueue release];
    [_requests release];
    [super dealloc];
}
#endif

- (FLFinisher*) sendRequest:(FLHttpRequest*) request 
                 completion:(FLCompletionBlock) completion {
    
    FLFinisher* finisher = [FLFinisher finisher:completion];

    [_schedulingQueue dispatchFinishableBlock:^(FLFinisher* finisherForRequest) {
        [_requests addObject:request];
        [ ((id)request) startAsync:finisherForRequest];
    }
    completion:^(FLResult result) {
        
        // this is the completion for the finisher created by dispatchFinishableBlock
        // we needed to intercept this to remove request from our queue.
        
        [_schedulingQueue dispatchBlock:^{
            // queue up our remove.
            [_requests removeObject:request];
        }];
        
        // our finisher the wraps up the request 
        [finisher setFinishedWithResult:result];
    }];
    
    return finisher;
}

- (FLFinisher*) sendRequest:(FLHttpRequest*) request {
    return [self sendRequest:request completion:nil];
}

- (FLResult) sendRequestSynchronously:(FLHttpRequest*) request {
    return [[self sendRequest:request] waitUntilFinished];
}

- (void) requestCancel {
    [_schedulingQueue dispatchBlock:^{
        for(FLHttpRequest* request in _requests) {
            [request requestCancel];
        }
    }];
}


@end
