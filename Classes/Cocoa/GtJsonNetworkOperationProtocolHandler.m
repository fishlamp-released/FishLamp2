//
//  GtJsonNetworkOperationBehavior.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/13/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtJsonNetworkOperationProtocolHandler.h"
#import "GtJsonRequest.h"
#import "GtJsonParser.h"

@implementation GtJsonNetworkOperationProtocolHandler

GtSynthesizeSingleton(GtJsonNetworkOperationProtocolHandler);

+ (GtJsonNetworkOperationProtocolHandler*) jsonNetworkOperationProtocolHandler
{
	return GtReturnAutoreleased([[GtJsonNetworkOperationProtocolHandler alloc] init]);
}

- (NSError*) networkOperation:(GtHttpOperation*) operation networkConnectionDidClose:(GtJsonRequest*) request
{
	NSError* error = request.error;
	
	if(!error)
	{
        GtJsonParser* parser = [GtJsonParser jsonParser];
		operation.operationOutput = [parser parseJsonData:request.httpResponse.responseData rootObject:operation.operationOutput];
        error = parser.error;
	}
	
	if(!error)
	{
		error = [request.httpResponse simpleHttpResponseErrorCheck];
	}

	return error;
}

@end

