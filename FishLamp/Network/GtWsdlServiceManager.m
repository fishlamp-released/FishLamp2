//
//  GtWsdlServiceManager.m
//  FishLamp
//
//  Created by Mike Fullerton on 8/13/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import "GtWsdlServiceManager.h"
#import "GtStringUtilities.h"

GtWsdlServiceManager* s_primaryWsdlServiceManager = nil;

@implementation GtWsdlServiceManager

GtSynthesize(webRequestSecurityHandler, setWebRequestSecurityHandler, GtWebRequestSecurityHandler, m_soapSecurityHandler);
#if IPHONE
GtSynthesize(reachability, setReachability, GtReachability, m_reachability);
#endif

- (void) onInit
{
#if IPHONE
	self.reachabilityHost = [[self url] urlRootComponent];
#endif	
	[super onInit];
}

+ (GtWsdlServiceManager*) primaryServiceManager
{
	GtAssert(s_primaryWsdlServiceManager != nil, @"primary service manager not set");
	return s_primaryWsdlServiceManager;
}

- (void) dealloc
{
#if IPHONE
	[m_reachability stopNotifer];
	GtRelease(m_reachability);
#endif
	GtRelease(m_soapSecurityHandler);
	[super dealloc];
}

+ (void) setPrimaryServiceManager:(GtWsdlServiceManager*) primary
{
	s_primaryWsdlServiceManager = primary;
}

- (NSString*) url
{
	GtFail(@"must override this");
	return nil;
}

- (NSString*) targetNamespace
{
	GtFail(@"must override this");
	return nil;
}

#if IPHONE

- (void) setReachabilityHost:(NSString *) host
{
	[self setObject:host forKey:@"reachabilityHost"];

    GtReleaseWithNil(m_reachability);
    m_reachability = [GtAlloc(GtReachability) initWithHostName:host];
    [m_reachability startNotifer];
}

- (NSString*) reachabilityHost
{
	return [self objectForKey:@"reachabilityHost"];
}

#endif

@end
