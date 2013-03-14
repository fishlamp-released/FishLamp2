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
    id<FLAsyncQueue> _asyncQueue;
}
@property (readonly, strong, nonatomic) FLHttpRequest* httpRequest;
@property (readwrite, strong, nonatomic) id<FLAsyncQueue> asyncQueue;

- (id) initWithHttpRequest:(FLHttpRequest*) request;
+ (id) httpRequestWorker:(FLHttpRequest*) request;

@end


@interface FLHttpStreamWorker : FLHttpRequestWorker {
@private
    FLHttpStream* _httpStream;
    FLHttpResponse* _httpResponse;
    FLFinisher* _finisher;
}

@property (readonly, strong, nonatomic) FLHttpResponse* httpResponse;
@end

@interface FLHttpRequestAuthenticatorWorker : FLHttpRequestWorker
@end
