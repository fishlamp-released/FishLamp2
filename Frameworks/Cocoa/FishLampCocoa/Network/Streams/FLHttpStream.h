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
#import "FLAbstractNetworkStream.h"
#import "FLReadStream.h"

@protocol FLHttpStreamDelegate;

@interface FLHttpStream : FLAbstractNetworkStream<FLConcreteNetworkStream> {
@private
    __unsafe_unretained id<FLHttpStreamDelegate> _delegate;
    FLMutableHttpResponse* _response;
    FLHttpRequest* _request;
    FLReadStream* _responseStream;
}
@property (readwrite, assign) id<FLHttpStreamDelegate> delegate;

@property (readonly, strong) FLHttpRequest* httpRequest;
@property (readonly, strong) FLHttpResponse* httpResponse;

- (id) initWithHttpRequest:(FLHttpRequest*) request;
+ (id) httpStream:(FLHttpRequest*) request;

@end

@protocol FLHttpStreamDelegate <NSObject>
- (void) httpStream:(FLHttpStream*) httpStream shouldRedirect:(BOOL*) redirect toURL:(NSURL*) url;
@end


