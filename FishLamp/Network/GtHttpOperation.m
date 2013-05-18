//
//  GtHttpOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 8/30/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtHttpOperation.h"
#import "GtNetworkUtilities.h"
#import "GtErrors.h"
#import "GtWebRequest.h"
#import "GtNetworkOperationSecurityManager.h"
#import "GtReachability.h"

@implementation GtHttpOperation

static GtWebRequestSecurityHandler* s_securityHandler = nil;

- (id<GtWebRequestProtocol>) webRequest
{
	return (GtWebRequest*) self.networkRequest;
}

- (void) onSetOutput:(NSData*) data
{
	self.output = data;
}

- (void) onPerformOperation
{
	id<GtWebRequestProtocol> request = nil;
	[self createHttpRequest:&request];
    GtAssertNotNil(request);

    self.networkRequest = request;
	GtRelease(request);

    GtReachability* reachability = [GtAlloc(GtReachability) initWithHostName:request.host ];
    self.reachability = reachability;
    GtRelease(reachability);

	if([[GtNetworkOperationSecurityManager instance] operationIsSecure:self])
	{
		if(s_securityHandler)
		{
			[s_securityHandler onAddSecurityToRequest:self.webRequest operation:self];
		}
		else
		{
			GtThrowFishLampException(@"Request requires security handler");
		}
	}

	[request send];
	
	if(!self.wasCancelled)
	{
		self.error = request.error;
		
		[self onSetOutput:[self.networkRequest receivedData]];
		[self.webRequest simpleHttpResponseErrorCheck];
	}
}

- (void) createHttpRequest:(id<GtWebRequestProtocol>*) outRequest
{
}

+ (void) setSecurityHandler:(GtWebRequestSecurityHandler*) handler
{
	[s_securityHandler release];
	s_securityHandler = [handler retain];
}


@end


