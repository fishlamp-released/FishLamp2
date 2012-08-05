//
//	FLSoapNetworkRequestBehavior.m
//	FishLampCoreLib
//
//	Created by Mike Fullerton on 11/7/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLSoapNetworkOperationResponseHandler.h"
#import "FLSoapNetworkConnection.h"
#import "FLWebServiceManager.h"
#import "FLSoapParser.h"
#import "FLSoapError.h"
#import "FLSoapFault11.h"

@implementation FLSoapNetworkRequestFactory 

FLSynthesizeSingleton(FLSoapNetworkRequestFactory);

- (FLHttpConnection*) networkOperationCreateNetworkRequest:(FLHttpOperation*) operation
{
	NSDictionary* info = operation.serverContext.properties;

	operation.URL = [NSURL URLWithString:[info objectForKey:FLNetworkServerPropertyKeyUrl]]; 

	NSString* functionName = operation.operationName;
	FLAssertStringIsNotEmpty(functionName);
	
	NSString* namespace = [info objectForKey:FLNetworkServerPropertyKeyTargetNamespace];
	
	FLSoapNetworkConnection* soapRequest = [FLSoapNetworkConnection soapRequest: operation.URL
								soapActionHeader: [info objectForKey:functionName]
								soapApiNamespace: namespace];
	
	[soapRequest.soapBuilder addObjectAsFunction:functionName object:operation.input xmlNamespace:namespace];
	
	return soapRequest;
}

@end

@implementation FLSoapNetworkOperationResponseHandler

FLSynthesizeSingleton(FLSoapNetworkOperationResponseHandler);

#define MAX_ERR_LEN 500

- (NSError*) checkForSoapFault:(NSData*) data
{
	NSError* error = nil;
	if(data && data.length >0 )
	{
		char* first = strnstr((const char*) [data bytes], "Fault", MIN([data length], (unsigned int) MAX_ERR_LEN));
		if(first)
		{
			FLSoapFault11* soapFault = [[FLSoapFault11 alloc] init]; // TODO maybe cache this until it's used?
			FLSoapParser* soapParser = [[FLSoapParser alloc] initWithXmlData:data];
			@try
			{
				[soapParser buildObjects:soapFault];
			
	//			  [soapFault inflateWithFaucet:soapParser];
			
				error = FLReturnAutoreleased([[NSError alloc] initWithSoapFault:soapFault]);
				
				FLDebugLog(@"Got Soap Fault:\n%@", [soapFault description]);
			}
			@finally
			{
				FLRelease(soapParser);
				FLRelease(soapFault);
			}
		}
	}

	return error;
}

- (void) parseXmlResponse:(NSData*) data object:(id) object
{
	FLSoapParser* soapParser = [[FLSoapParser alloc] initWithXmlData:data];
	@try
	{
		[soapParser buildObjects:object];
	}
	@finally
	{
		FLRelease(soapParser);
	}
}

- (NSError*) networkOperation:(FLHttpOperation*) operation networkConnectionDidFinish:(FLSoapNetworkConnection*) soapRequest
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

- (void) networkOperation:(FLHttpOperation*) operation 
      shouldRedirectToURL:(NSURL*) url
             willRedirect:(BOOL*) willRedirect {
             
             
}


@end
