//
//	GtNetworkEndpointHelper.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/22/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtNetworkServerContext.h"
#import "GtHttpOperation.h"
#import "GtOperationAuthenticator.h"
#import "GtUserSession.h"

@implementation GtNetworkServerContext

@synthesize defaultNetworkRequestFactory = m_defaultNetworkRequestFactory;
@synthesize authenticator = m_authenticator;
@synthesize defaultNetworkOperationResponseHandler = m_defaultResponseHandler;
@synthesize properties = m_properties;
@synthesize userSession = m_userSession;

- (id) init
{
	if((self = [super init]))
	{
		m_properties = [[NSMutableDictionary alloc] init];
	}
	
	return self;
}
- (void) dealloc
{
	GtRelease(m_properties);
	GtRelease(m_defaultNetworkRequestFactory);
	GtRelease(m_defaultResponseHandler);
	GtRelease(m_authenticator);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
}

- (id) initWithCoder:(NSCoder*) aDecoder
{
	return [self init];
}


@end

