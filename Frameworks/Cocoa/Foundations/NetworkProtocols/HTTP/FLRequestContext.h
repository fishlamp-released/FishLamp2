//
//  FLRequestContext.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLDispatchQueue.h"
#import "FLHttpRequest.h"

@interface FLRequestContext : NSObject {
@private
    FLFifoDispatchQueue* _dispatcher;
    NSMutableArray* _requests;
}

@property (readonly, strong) id<FLDispatcher> dispatcher;

- (FLFinisher*) sendRequest:(FLHttpRequest*) request;

- (FLFinisher*) sendRequest:(FLHttpRequest*) request 
                 completion:(FLCompletionBlock) completion;

- (void) sendRequest:(FLHttpRequest*) request
            finisher:(FLFinisher*) finisher;

- (void) requestCancel;

// optional overrides
- (void) willStartRequest:(FLHttpRequest*) request;

@end

