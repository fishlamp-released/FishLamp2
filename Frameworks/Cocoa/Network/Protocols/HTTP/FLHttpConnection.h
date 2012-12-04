//
//  FLHttpRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/22/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

#import "FLNetworkConnection.h"

#import "FLHttpRequest.h"
#import "FLHttpResponse.h"

@protocol FLHttpConnectionDelegate;

@interface FLHttpConnection : FLNetworkConnection {
@private
    FLHttpRequest* _httpRequest;
    FLHttpResponse* _httpResponse;
}
@property (readonly, strong) FLHttpRequest* httpRequest;
@property (readonly, strong) FLHttpResponse* httpResponse;

- (id) initWithHttpRequest:(FLHttpRequest*) request;
+ (id) httpConnection:(FLHttpRequest*) request;

@end


