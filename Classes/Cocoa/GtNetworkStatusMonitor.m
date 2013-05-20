//
//  GtNetworkStatusMonitor.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/9/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtNetworkStatusMonitor.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>

#if DEBUG
#define FAKE_AIRPLANE_MODE 0
#endif

@interface GtNetworkStatusMonitor ()
- (SCNetworkReachabilityFlags) currentReachabilityFlags;
@end

@implementation GtNetworkStatusMonitor

GtSynthesizeSingleton(GtNetworkStatusMonitor);

NSString* const GtNetworkStatusNetworkBecameAvailableNotification = @"GtNetworkStatusNetworkBecameAvailableNotification";
NSString* const GtNetworkStatusNetworkBecameUnavailableNotification = @"GtNetworkStatusNetworkBecameUnavailableNotification";

- (id) init
{
	if((self = [super init]))
	{
		struct sockaddr_in zeroAddress;
		bzero(&zeroAddress, sizeof(zeroAddress));
		zeroAddress.sin_len = sizeof(zeroAddress);
		zeroAddress.sin_family = AF_INET;
		m_reachabilityRef = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&zeroAddress);
		memset(&m_context, 0, sizeof(SCNetworkReachabilityContext));
	}
	
	return self;
}

- (void) dealloc
{
	if(m_isMonitoring)
	{
		SCNetworkReachabilityUnscheduleFromRunLoop(m_reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
	}

	if(m_reachabilityRef != NULL)
	{
		CFRelease(m_reachabilityRef);
		m_reachabilityRef = nil;
	}
	
	GtSuperDealloc();
}

- (SCNetworkReachabilityFlags) currentReachabilityFlags
{
	GtAssert(m_reachabilityRef != NULL, @"currentReachabilityFlags called with NULL m_reachabilityRef");
	SCNetworkReachabilityFlags flags = 0;
	if (SCNetworkReachabilityGetFlags(m_reachabilityRef, &flags))
	{
#if DEBUG
	/*
		if(!flags)
		{
			GtLog(@"Warning SCNetworkReachabilityGetFlags returned 0 for host: %@ (check url for illegal prefix like http://)", self.hostName ? self.hostName : @"unknown");
		}
	 */
	 
#endif
	/*
		if(m_isLocalWiFiRef)
		{
			retVal = [self localWiFiStatusForFlags: flags];
		}
		else
		{
			retVal = [self networkStatusForFlags: flags];
		}
	*/
	}
	else
	{
		GtLog(@"Warning SCNetworkReachabilityGetFlags returned false!");
	}
	
	
	return flags;
}

- (BOOL) networkIsReachable
{
#if FAKE_AIRPLANE_MODE
    return NO;
#endif
	return	GtBitMaskTest(self.currentReachabilityFlags, kSCNetworkReachabilityFlagsReachable);
}

- (void) onReachabilityCallback
{
    BOOL isNowReachable = self.networkIsReachable;
    if(isNowReachable != m_isReachable)
	{
        m_isReachable = isNowReachable;
        if(m_isReachable)
        {
            GtLog(@"Network became available");
        
            [[NSNotificationCenter defaultCenter] postNotification:
                [NSNotification notificationWithName:GtNetworkStatusNetworkBecameAvailableNotification object:nil userInfo:nil]];
        }
        else
        {
            GtLog(@"Network became unavailable");

            [[NSNotificationCenter defaultCenter] postNotification:
                [NSNotification notificationWithName:GtNetworkStatusNetworkBecameUnavailableNotification object:nil userInfo:nil]];
        }
    
    }
}

static void ReachabilityCallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void* info)
{
	[[GtNetworkStatusMonitor instance] onReachabilityCallback];
}

- (void) beginNetworkMonitoring
{
#if FAKE_AIRPLANE_MODE
    return;
#endif

	if(	!m_isMonitoring &&
		SCNetworkReachabilitySetCallback(m_reachabilityRef, ReachabilityCallback, &m_context) && 
		SCNetworkReachabilityScheduleWithRunLoop(m_reachabilityRef, CFRunLoopGetMain(), kCFRunLoopDefaultMode))
	{
        m_isReachable = self.networkIsReachable;
		m_isMonitoring = YES;
	}
}

@end
