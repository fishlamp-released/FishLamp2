//
//  FLHttpStream.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLNetworkStream.h"
#import "FLHttpRequest.h"
#import "FLHttpResponse.h"
#import "FLNetworkStream.h"

@class FLReadStream;

@protocol FLHttpStream <NSObject>
@property (readonly, strong) FLHttpRequest* httpRequest;
@property (readonly, strong) FLHttpResponse* httpResponse;
@end

@interface FLHttpStream : FLNetworkStream<FLHttpStream> {
@private
    FLMutableHttpResponse* _response;
    FLHttpRequest* _request;
    FLReadStream* _readStream;
}

- (id) initWithHttpRequest:(FLHttpRequest*) request;
+ (id) httpStream:(FLHttpRequest*) request;

@end

@protocol FLHttpStreamDelegate <FLNetworkStream, FLNetworkStreamDelegate>
@optional
- (void) httpStream:(FLHttpStream*) httpStream shouldRedirect:(BOOL*) redirect toURL:(NSURL*) url;
@end


