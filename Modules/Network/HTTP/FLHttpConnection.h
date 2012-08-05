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

#import "CFHTTPMessageWrapper.h"
#import "CFHTTPStreamWrapper.h"
#import "FLHttpRequest.h"
#import "FLHttpResponse.h"

@protocol FLHttpConnectionDelegate;

@interface FLHttpConnection : FLNetworkConnection<CFReadStreamWrapperDelegate> {
@private
    CFHTTPStreamWrapper* _inputStream;
    FLHttpResponse* _response;
    NSMutableArray* _requestQueue;
    BOOL _isOpen;
}

- (id) initWithHttpRequest:(FLHttpRequest*) request;

+ (id) httpConnection:(FLHttpRequest*) request;

/** implementation objects */
@property (readonly, retain, nonatomic) FLHttpRequest* httpRequest;
@property (readonly, retain, nonatomic) FLHttpResponse* httpResponse;

@end



