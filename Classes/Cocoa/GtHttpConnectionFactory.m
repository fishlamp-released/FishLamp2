//
//  GtHttpNetworkRequestFactory.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/20/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtHttpConnectionFactory.h"
#import "GtHttpConnection.h"

@implementation GtHttpConnectionFactory 

GtSynthesizeSingleton(GtHttpConnectionFactory);

- (GtHttpConnection*) networkOperationCreateNetworkRequest:(GtHttpOperation*) operation
{
	GtHttpConnection* request = GtReturnAutoreleased([[GtHttpConnection alloc] initWithHttpRequest:
        [GtHttpRequest httpRequestWithURL:operation.URL requestMethod:operation.requestType]] );
	return request;
}

@end