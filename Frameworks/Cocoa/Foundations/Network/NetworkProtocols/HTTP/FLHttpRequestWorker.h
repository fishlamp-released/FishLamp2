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

@interface FLHttpRequestWorker : FLAsyncWorker<FLNetworkStreamDelegate> {
@private
    FLHttpRequest* _httpRequest;
    id<FLDispatcher> _dispatcher;
}
@property (readonly, strong, nonatomic) FLHttpRequest* httpRequest;
@property (readwrite, strong, nonatomic) id<FLDispatcher> dispatcher;

- (id) initWithHttpRequest:(FLHttpRequest*) request;
+ (id) httpRequestWorker:(FLHttpRequest*) request;

@end


@interface FLHttpStreamWorker : FLHttpRequestWorker {
@private
    FLHttpStream* _httpStream;
    FLHttpResponse* _response;
    FLFinisher* _finisher;
}

@property (readonly, strong, nonatomic) FLHttpResponse* httpResponse;
@end

@interface FLHttpRequestAuthenticatorWorker : FLHttpRequestWorker
@end
