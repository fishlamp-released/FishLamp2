//
//  FLRequestContext.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLRequestContext.h"
#import "FLServiceKeys.h"

//@implementation FLSession (FLRequestContext) 
//FLSynthesizeSessionService(httpService, sethttpService, FLRequestContext*)
//@end

@interface FLRequestContext ()
@property (readwrite, strong) id<FLDispatcher> dispatcher;
@end

@implementation FLRequestContext

@synthesize dispatcher = _dispatcher;

- (id) init {
    self = [super init];
    if(self) {
        _requests = [[NSMutableArray alloc] init];
    }
    
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_dispatcher release];
    [_requests release];
    [super dealloc];
}
#endif

+ (id) requestContext {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) didMoveToSession:(FLSession *)session {
    [super didMoveToSession:session];
    self.dispatcher = session.dispatcher;
}

- (void) willStartRequest:(FLHttpRequest*) request  {
                
}

- (void) sendRequest:(FLHttpRequest*) request
            finisher:(FLFinisher*) finisher  {
    
    [_dispatcher dispatchBlock: ^{
        [_requests addObject:request];
        [self willStartRequest:request];
        [ ((id)request) performWithFinisher:finisher];
    }
    completion:^(FLResult result) {
        
        // this is the completion for the finisher created by dispatchFinishableBlock
        // we needed to intercept this to remove request from our queue.
        
        [_dispatcher dispatchBlock:^{
            // queue up our remove.
            [_requests removeObject:request];
        }];
        
    }];
}

- (FLFinisher*) sendRequest:(FLHttpRequest*) request {
    FLFinisher* finisher = [FLFinisher finisher];
    [self sendRequest:request finisher:finisher];
    return finisher;
}

- (FLFinisher*) sendRequest:(FLHttpRequest*) request 
                 completion:(FLCompletionBlock) completion {

    FLFinisher* finisher = [FLFinisher finisher:completion];
    [self sendRequest:request finisher:finisher];
    return finisher;
}                 

- (void) requestCancel {
    [_dispatcher dispatchBlock:^{
        for(FLHttpRequest* request in _requests) {
            [request requestCancel];
        }
    }];
}

@end
