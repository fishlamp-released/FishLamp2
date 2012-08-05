//
//  FLJsonNetworkOperationBehavior.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/13/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLJsonNetworkOperationProtocolHandler.h"
#import "FLJsonRequest.h"
#import "FLJsonParser.h"

@implementation FLJsonNetworkOperationProtocolHandler

FLSynthesizeSingleton(FLJsonNetworkOperationProtocolHandler);

+ (FLJsonNetworkOperationProtocolHandler*) jsonNetworkOperationProtocolHandler
{
	return FLReturnAutoreleased([[FLJsonNetworkOperationProtocolHandler alloc] init]);
}

- (NSError*) networkOperation:(FLHttpOperation*) operation 
   networkConnectionDidFinish:(FLJsonRequest*) request
{
	NSError* error = request.error;
	
	if(!error)
	{
        FLJsonParser* parser = [FLJsonParser jsonParser];
		operation.operationOutput = [parser parseJsonData:request.httpResponse.responseData rootObject:operation.operationOutput];
        error = parser.error;
	}
	
	if(!error)
	{
		error = [request.httpResponse simpleHttpResponseErrorCheck];
	}

	return error;
}

- (void) networkOperation:(FLHttpOperation*) operation 
      shouldRedirectToURL:(NSURL*) url
             willRedirect:(BOOL*) willRedirect {
             
             
}


@end

