//
//	FLHttpOperationBehavior.m
//	FishLampMobileLib
//
//	Created by Mike Fullerton on 11/13/10.
//	Copyright 2010 Greentongue Software. All rights reserved.
//

#import "FLHttpOperationResponseHandler.h"
#import "FLHttpOperation.h"

@implementation FLHttpOperationResponseHandler

- (void) setOperationOutput:(FLHttpOperation*) operation data:(NSData*) data
{
	operation.output = data;
}

- (NSError*) networkOperation:(FLHttpOperation*) operation networkConnectionDidFinish:(FLHttpConnection*) webRequest;
{	 
	NSError* error = webRequest.error;
	
	if(!error)
	{
		[self setOperationOutput:operation data:webRequest.httpResponse.responseData];
		error = [webRequest.httpResponse simpleHttpResponseErrorCheck];
	}
	
	return error;
}

- (void) networkOperation:(FLHttpOperation*) operation 
      shouldRedirectToURL:(NSURL*) url
             willRedirect:(BOOL*) willRedirect {
             
             
}


@end

