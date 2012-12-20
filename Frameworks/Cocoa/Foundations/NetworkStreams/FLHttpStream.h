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
#import "FLReadStream.h"

@protocol FLHttpStreamDelegate;

@interface FLHttpStream : FLObservable<FLReadStream, FLNetworkStream> {
@private
    __unsafe_unretained id<FLHttpStreamDelegate> _delegate;
    __unsafe_unretained FLFinisher* _synchronousFinisher;

    FLMutableHttpResponse* _response;
    FLHttpRequest* _request;
    FLReadStream* _httpStream;
    FLDispatchQueue* _dispatchQueue;
}
@property (readwrite, assign) id<FLHttpStreamDelegate> delegate;

@property (readonly, strong) FLHttpRequest* httpRequest;
@property (readonly, strong) FLHttpResponse* httpResponse;

- (id) initWithHttpRequest:(FLHttpRequest*) request;
+ (id) httpStream:(FLHttpRequest*) request;

- (FLResult) connectSynchronously; 

@end

@protocol FLHttpStreamDelegate <NSObject>
- (void) httpStream:(FLHttpStream*) httpStream shouldRedirect:(BOOL*) redirect toURL:(NSURL*) url;
@end


