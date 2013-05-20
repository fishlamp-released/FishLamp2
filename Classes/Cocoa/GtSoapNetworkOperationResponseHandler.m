//
//	GtSoapNetworkRequestBehavior.m
//	FishLampCoreLib
//
//	Created by Mike Fullerton on 11/7/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSoapNetworkOperationResponseHandler.h"
#import "GtSoapNetworkConnection.h"
#import "GtWebServiceManager.h"
#import "GtSoapParser.h"
#import "NSObject+GtStreamableObject.h"
#import "GtSoapError.h"
#import "GtSoapFault11.h"

@implementation GtSoapNetworkRequestFactory 

GtSynthesizeSingleton(GtSoapNetworkRequestFactory);

- (GtHttpConnection*) networkOperationCreateNetworkRequest:(GtHttpOperation*) operation
{
	NSDictionary* info = operation.serverContext.properties;

	operation.URL = [NSURL URLWithString:[info objectForKey:GtNetworkServerPropertyKeyUrl]]; 

	NSString* functionName = operation.operationName;
	GtAssertIsValidString(functionName);
	
	NSString* namespace = [info objectForKey:GtNetworkServerPropertyKeyTargetNamespace];
	
	GtSoapNetworkConnection* soapRequest = [GtSoapNetworkConnection soapRequest: operation.URL
								soapActionHeader: [info objectForKey:functionName]
								soapApiNamespace: namespace];
	
	[soapRequest.soapBuilder addObjectAsFunction:functionName object:operation.input namespace:namespace];
	
	return soapRequest;
}

@end

@implementation GtSoapNetworkOperationResponseHandler

GtSynthesizeSingleton(GtSoapNetworkOperationResponseHandler);

#define MAX_ERR_LEN 500

- (NSError*) checkForSoapFault:(NSData*) data
{
	NSError* error = nil;
	if(data && data.length >0 )
	{
		char* first = strnstr((const char*) [data bytes], "Fault", MIN([data length], (unsigned int) MAX_ERR_LEN));
		if(first)
		{
			GtSoapFault11* soapFault = [[GtSoapFault11 alloc] init]; // TODO maybe cache this until it's used?
			GtSoapParser* soapParser = [[GtSoapParser alloc] initWithXmlData:data];
			@try
			{
				[soapParser buildObjects:soapFault];
			
	//			  [soapFault inflateWithFaucet:soapParser];
			
				error = GtReturnAutoreleased([[NSError alloc] initWithSoapFault:soapFault]);
				
				GtLog(@"Got Soap Fault:\n%@", [soapFault description]);
			}
			@finally
			{
				GtRelease(soapParser);
				GtRelease(soapFault);
			}
		}
	}

	return error;
}

- (void) parseXmlResponse:(NSData*) data object:(id) object
{
	GtSoapParser* soapParser = [[GtSoapParser alloc] initWithXmlData:data];
	@try
	{
		[soapParser buildObjects:object];
	}
	@finally
	{
		GtRelease(soapParser);
	}
}



- (NSError*) networkOperation:(GtHttpOperation*) operation networkConnectionDidClose:(GtSoapNetworkConnection*) soapRequest
{	 
	NSData* data = soapRequest.httpResponse.responseData;
	NSError* error = [self checkForSoapFault:data];
	
	if(!error)
	{
		error = soapRequest.error; 
	}
	if(!error)
	{
		error = [soapRequest.httpResponse simpleHttpResponseErrorCheck];
	}
	if(!error)
	{
		// output object already created.
		[self parseXmlResponse:data object:[operation output]];
	}
	
	return error;
}

@end
