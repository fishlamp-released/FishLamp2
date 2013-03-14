//
//  FLHttpRequestTask.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLAsyncWorker.h"
#import "FLHttpStream.h"
#import "FLHttpResponse.h"
#import "FLHttpRequest.h"

@interface FLHttpRequestWorker : FLContextWorker<FLNetworkStreamDelegate> {
@private
    FLHttpRequest* _httpRequest;
    FLFifoAsyncQueue* _asyncQueue;
}
@property (readonly, strong, nonatomic) FLHttpRequest* httpRequest;
@property (readonly, strong, nonatomic) FLFifoAsyncQueue* asyncQueue;

- (id) initWithHttpRequest:(FLHttpRequest*) request asyncQueue:(FLFifoAsyncQueue*) asyncQueue;
+ (id) httpRequestWorker:(FLHttpRequest*) request asyncQueue:(FLFifoAsyncQueue*) asyncQueue;

@end


@interface FLHttpStreamWorker : FLHttpRequestWorker {
@private
    FLHttpStream* _httpStream;
    FLHttpResponse* _httpResponse;
    FLFinisher* _finisher;
}

@property (readonly, strong, nonatomic) FLHttpResponse* httpResponse;
@end

@interface FLHttpRequestAuthenticationWorker : FLHttpRequestWorker

// this gets queue from httpRequet's authenticator
- (id) initWithHttpRequest:(FLHttpRequest*) request;
+ (id) httpRequestAuthenticationWorker:(FLHttpRequest*) request;
@end
