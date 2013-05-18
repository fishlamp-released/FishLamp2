/*
 
	Base on GtReachability.m

	// TODO: refactor this crappy design
 
*/

#import <sys/socket.h>
#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>

#import <CoreFoundation/CoreFoundation.h>

#import "GtReachability.h"

#define kShouldPrintReachabilityFlags 0

static void PrintReachabilityFlags(SCNetworkReachabilityFlags    flags, const char* comment)
{
#if kShouldPrintReachabilityFlags
	
    NSLog(@"GtReachability Flag Status: %c%c %c%c%c%c%c%c%c %s\n",
			(flags & kSCNetworkReachabilityFlagsIsWWAN)				  ? 'W' : '-',
			(flags & kSCNetworkReachabilityFlagsReachable)            ? 'R' : '-',
			
			(flags & kSCNetworkReachabilityFlagsTransientConnection)  ? 't' : '-',
			(flags & kSCNetworkReachabilityFlagsConnectionRequired)   ? 'c' : '-',
			(flags & kSCNetworkReachabilityFlagsConnectionOnTraffic)  ? 'C' : '-',
			(flags & kSCNetworkReachabilityFlagsInterventionRequired) ? 'i' : '-',
			(flags & kSCNetworkReachabilityFlagsConnectionOnDemand)   ? 'D' : '-',
			(flags & kSCNetworkReachabilityFlagsIsLocalAddress)       ? 'l' : '-',
			(flags & kSCNetworkReachabilityFlagsIsDirect)             ? 'd' : '-',
			comment
			);
#endif
}

NSString* const GtNetworkReachabilityChangedNotification = @"GtNetworkReachabilityChangedNotification";

@implementation GtReachability

@synthesize hostName = m_hostName;

GtSynthesizeString(hostName, setHostName);
@synthesize reachabilityRef = m_reachabilityRef;
@synthesize reachabilityType = m_type;

- (id) initWithHostName:(NSString*) hostName
{
    if(self = [super init])
    {
        NSRange range = [hostName rangeOfString:@"//"];
        if(range.length)
        {
            hostName = [hostName substringFromIndex:range.location + 2];
        }

#if DEBUG        
        GtTrace(GtTraceReachability, @"Set reachability for host: %@", hostName);
#endif        
        
        m_reachabilityRef = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, [hostName UTF8String]);
        self.hostName = hostName;
        m_type = GtHostReachability;
    }

    return self;
}

- (id) initWithAddress:(const struct sockaddr_in*) hostAddress
{
    if(self = [super init])
    {
        m_reachabilityRef = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)hostAddress);
        m_type = GtAddressReachability;
	
        // TODO save address?
    }
    
    return self;
}

- (id) initWithInternetConnection
{
    if(self = [super init])
    {
        struct sockaddr_in zeroAddress;
        bzero(&zeroAddress, sizeof(zeroAddress));
        zeroAddress.sin_len = sizeof(zeroAddress);
        zeroAddress.sin_family = AF_INET;
        m_reachabilityRef = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&zeroAddress);
        m_type = GtInternetReachability;
    }
    
    return self;
}

- (id) initWithWiFi
{
    if(self = [super init])
    {
        struct sockaddr_in localWifiAddress;
        bzero(&localWifiAddress, sizeof(localWifiAddress));
        localWifiAddress.sin_len = sizeof(localWifiAddress);
        localWifiAddress.sin_family = AF_INET;
	// IN_LINKLOCALNETNUM is defined in <netinet/in.h> as 169.254.0.0
        localWifiAddress.sin_addr.s_addr = htonl(IN_LINKLOCALNETNUM);
        m_reachabilityRef = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&localWifiAddress);
	    m_type = GtWifiReachability;
    }
    
    return self;
}

- (void) dealloc
{
    GtRelease(m_hostName);

	[self stopNotifer];
	if(m_reachabilityRef!= NULL)
	{
		CFRelease(m_reachabilityRef);
        m_reachabilityRef = nil;
	}
	[super dealloc];
}

- (void) onReachabilityCallback
{
   // GtAssert(self.currentReachabilityFlags != 0, @"reachability flags are zero, check your reachability input for bad data");

    [[NSNotificationCenter defaultCenter] postNotificationName: GtNetworkReachabilityChangedNotification    
        object:[UIApplication sharedApplication]
        userInfo:[NSDictionary dictionaryWithObject:self forKey:[GtReachability class]]
        ];
}


static void ReachabilityCallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void* info)
{
	GtAssert(info != NULL, @"info was NULL in ReachabilityCallback");
	GtAssert([(NSObject*) info isKindOfClass: [GtReachability class]], @"info was wrong class in ReachabilityCallback");

	GtReachability* noteObject = (GtReachability*) info;
    [noteObject onReachabilityCallback];
}

#if DEBUG
- (void) fakeNotify
{
	[[NSNotificationCenter defaultCenter] postNotificationName: GtNetworkReachabilityChangedNotification    
        object:[UIApplication sharedApplication]
        userInfo:[NSDictionary dictionaryWithObject:self forKey:[GtReachability class]]
        ];
}
#endif

- (BOOL) startNotifer
{
#if DEBUG
	if(GtTestBoolEnvironmentVariable(GtNetworkNotReachable))
	{
		[self performSelectorOnMainThread:@selector(fakeNotify) withObject:nil waitUntilDone:NO];
	
		return YES;
	}

	if(GtTestBoolEnvironmentVariable(GtNetworkReachable)) 
	{
		return YES;
	}
#endif

	BOOL retVal = NO;
	SCNetworkReachabilityContext	context = {0, self, NULL, NULL, NULL};
	if(SCNetworkReachabilitySetCallback(m_reachabilityRef, ReachabilityCallback, &context))
	{
		if(SCNetworkReachabilityScheduleWithRunLoop(m_reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode))
		{
			retVal = YES;
		}
	}
	return retVal;
}

- (void) stopNotifer
{
#if DEBUG
	if(GtTestBoolEnvironmentVariable(GtNetworkReachable)) 
	{
		return;
	}
#endif 

	if(m_reachabilityRef!= NULL)
	{
		SCNetworkReachabilityUnscheduleFromRunLoop(m_reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
	}
}

- (BOOL) isReachable
{
#if DEBUG
	if(GtTestBoolEnvironmentVariable(GtNetworkNotReachable)) {
		return NO;
	}
	if(GtTestBoolEnvironmentVariable(GtNetworkReachable)) {
		return YES;
	}
#endif

	return  GtTestAllBits(self.currentReachabilityFlags, kSCNetworkReachabilityFlagsReachable);
}

/*
// exceedingly lame
#define mySCNetworkReachabilityFlagsConnectionOnDemand 1<<5

- (GtNetworkStatus) localWiFiStatusForFlags: (SCNetworkReachabilityFlags) flags
{
	PrintReachabilityFlags(flags, "localWiFiStatusForFlags");

	BOOL retVal = gtNetworkNotReachable;
	if((flags & kSCNetworkReachabilityFlagsReachable) && (flags & kSCNetworkReachabilityFlagsIsDirect))
	{
		retVal = gtNetworkReachableViaWiFi;	
	}
	return retVal;
}

- (GtNetworkStatus) networkStatusForFlags: (SCNetworkReachabilityFlags) flags
{
#if DEBUG
	if(GtTestBoolEnvironmentVariable(GtNetworkNotReachable))
	{
		GtLog(@"Warning fake not reachable is enabled");
		return gtNetworkNotReachable;
	}
#endif

	PrintReachabilityFlags(flags, "networkStatusForFlags");
	if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
	{
		// if target host is not reachable
		return gtNetworkNotReachable;
	}

	GtNetworkStatus retVal = gtNetworkNotReachable;
	
	if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
	{
		// if target host is reachable and no connection is required
		//  then we'll assume (for now) that your on Wi-Fi
		retVal = gtNetworkReachableViaWiFi;
	}
	
	
	if ((((flags & mySCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
		(flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
	{
			// ... and the connection is on-demand (or on-traffic) if the
			//     calling application is using the CFSocketStream or higher APIs

			if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
			{
				// ... and no [user] intervention is needed
				retVal = gtNetworkReachableViaWiFi;
			}
		}
	
	if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
	{
		// ... but WWAN connections are OK if the calling application
		//     is using the CFNetwork (CFSocketStream?) APIs.
		retVal = gtNetworkReachableViaWWAN;
	}
	return retVal;
}
*/

- (BOOL) connectionRequired;
{
	return (self.currentReachabilityFlags & kSCNetworkReachabilityFlagsConnectionRequired);
}

- (SCNetworkReachabilityFlags) currentReachabilityFlags
{
    GtAssert(m_reachabilityRef != NULL, @"currentReachabilityFlags called with NULL m_reachabilityRef");
	SCNetworkReachabilityFlags flags = 0;
	if (SCNetworkReachabilityGetFlags(m_reachabilityRef, &flags))
	{
#if DEBUG
		if(!flags)
		{
			GtLog(@"Warning SCNetworkReachabilityGetFlags returned 0 for host: %@ (check url for illegal prefix like http://)", self.hostName ? self.hostName : @"unknown");
		}
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

+ (BOOL) isConnectedToNetwork 
{ 
	GtReachability* reachable = [GtAlloc(GtReachability) initWithInternetConnection];
	BOOL isReachable = reachable.isReachable;
	GtRelease(reachable);
	
	if(GtTestBoolEnvironmentVariable(GtNetworkNotReachable))
	{
		[self performSelectorOnMainThread:@selector(fakeNotify) withObject:nil waitUntilDone:NO];
	
		return NO;
	}

	if(GtTestBoolEnvironmentVariable(GtNetworkReachable)) 
	{
		return YES;
	}
	
	return isReachable;
/*
// Create zero addy  
	struct sockaddr_in zeroAddress; 
	bzero(&zeroAddress, sizeof(zeroAddress)); 
	zeroAddress.sin_len = sizeof(zeroAddress); 
	zeroAddress.sin_family = AF_INET;

// Recover reachability flags
	SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
	SCNetworkReachabilityFlags flags; 
	BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	CFRelease(defaultRouteReachability);
	if (!didRetrieveFlags) 
	{ 
		NSLog(@"Error. Could not recover network reachability flags."); 
		return NO;
	}
 
	BOOL isReachable = flags & kSCNetworkFlagsReachable;
	BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired; 
	
	return (isReachable && !needsConnection) ? YES : NO;
*/
}

@end

/*

+ (GtReachability*) reachabilityWithHostName: (NSString*) hostName
{
	GtReachability* retVal = [[[GtReachability alloc] init] autorelease];
	retVal.reachabilityRef = ;
	retVal.hostName = hostName;
    retVal.isWifiRef = NO;
	return retVal; 
}



+ (void) reachabilityWithAddress: (const struct sockaddr_in*) hostAddress   
    outReachability:(GtReachability**) outValue
{
	SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)hostAddress);
	GtReachability* retVal = NULL;
	if(reachability!= NULL)
	{
		retVal= [[self alloc] init];
		if(retVal!= NULL)
		{
			retVal->m_reachabilityRef = reachability;
			retVal->m_isLocalWiFiRef = NO;
		}
	}
	*outValue = retVal; 
}

+ (void) reachabilityForInternetConnection: (GtReachability**) outValue
{
	struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;
	[self reachabilityWithAddress: &zeroAddress outReachability:outValue];
}


+ (void) reachabilityForLocalWiFi: (GtReachability**) outValue
{
	[super init];
	struct sockaddr_in localWifiAddress;
	bzero(&localWifiAddress, sizeof(localWifiAddress));
	localWifiAddress.sin_len = sizeof(localWifiAddress);
	localWifiAddress.sin_family = AF_INET;
	// IN_LINKLOCALNETNUM is defined in <netinet/in.h> as 169.254.0.0
	localWifiAddress.sin_addr.s_addr = htonl(IN_LINKLOCALNETNUM);
	GtReachability* retVal = nil;
	[self reachabilityWithAddress: &localWifiAddress outReachability:&retVal];
	if(retVal!= NULL)
	{
		retVal->m_isLocalWiFiRef = YES;
	}
	*outValue = retVal; 
}
*/


