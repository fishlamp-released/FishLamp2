//
//	GtHttpOperationBehavior.m
//	FishLampMobileLib
//
//	Created by Mike Fullerton on 11/13/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtHttpOperationResponseHandler.h"
#import "GtHttpOperation.h"

@implementation GtHttpOperationResponseHandler

- (void) setOperationOutput:(GtHttpOperation*) operation data:(NSData*) data
{
	operation.output = data;
}

- (NSError*) networkOperation:(GtHttpOperation*) operation networkConnectionDidClose:(GtHttpConnection*) webRequest;
{	 
	NSError* error = webRequest.error;
	
	if(!error)
	{
		[self setOperationOutput:operation data:webRequest.httpResponse.responseData];
		error = [webRequest.httpResponse simpleHttpResponseErrorCheck];
	}
	
	return error;
}

@end

