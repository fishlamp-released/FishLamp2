//
//  FLHttpNetworkRequestFactory.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/20/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLHttpConnectionFactory.h"
#import "FLHttpConnection.h"

@implementation FLHttpConnectionFactory 

FLSynthesizeSingleton(FLHttpConnectionFactory);

- (FLHttpConnection*) networkOperationCreateNetworkRequest:(FLHttpOperation*) operation
{
	FLHttpConnection* request = FLReturnAutoreleased([[FLHttpConnection alloc] initWithHttpRequest:
        [FLHttpRequest httpRequestWithURL:operation.URL requestMethod:operation.requestType]] );
	return request;
}

@end