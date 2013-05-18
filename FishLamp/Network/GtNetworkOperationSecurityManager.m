//
//  GtNetworkOperationSecurityManager.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/24/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtNetworkOperationSecurityManager.h"


@implementation GtNetworkOperationSecurityManager

GtSynthesizeSingleton(GtNetworkOperationSecurityManager)

- (id) init
{
	if(self = [super init])
	{
	}
	return self;
}

@synthesize operationsAreSecureByDefault = m_operationsAreSecureByDefault;

- (void) addSecurityBehaviorForClass:(Class) class isSecure:(BOOL) isSecure
{
	if(!m_exceptions)
	{
		m_exceptions = [GtAlloc(NSMutableDictionary) init];
	}
	
	[m_exceptions setObject:[NSNumber numberWithBool:isSecure] forKey:class];
}

- (BOOL) operationIsSecure:(id<GtNetworkOperationProtocol>) operation
{
	NSNumber* exception = [m_exceptions objectForKey:[operation class]];
	
	if([operation transportSecurityOverride] != GtTransportSecurityDefaultValue)
	{
		return [operation transportSecurityOverride] == GtTransportSecuritySecure;
	}
	
	return exception ? [exception boolValue] : m_operationsAreSecureByDefault;
}


@end
