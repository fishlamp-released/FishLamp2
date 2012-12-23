//
//	FLNetworkOperation.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/9/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLCore.h"
#import "FLOperation.h"
#import "FLHttpRequest.h"
#import "FLHttpResponse.h"
#import "FLHttpRequest.h"

@interface FLHttpOperation : FLOperation<FLHttpRequestRedirector, FLHttpRequestSender> {
@private
    NSURL* _httpRequestURL;

    id<FLHttpRequestSender> _requestSender;

// only valid while sending request
    FLHttpRequest* _httpRequest;
}

@property (readwrite, strong) id<FLHttpRequestSender> requestSender;

@property (readwrite, strong) NSURL* httpRequestURL;

- (id) initWithHTTPRequestURL:(NSURL*) url;

+ (id) httpOperation;

+ (id) httpOperationWithHTTPRequestURL:(NSURL*) httpRequestURL;

@end


