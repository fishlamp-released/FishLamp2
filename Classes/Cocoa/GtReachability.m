/*
 
	Base on GtReachability.m
*/

#if 0

#if DEBUG
#define FAKE_OFFLINE 0
#if FAKE_OFFLINE 
#warning FAKE_OFFLINE is enabled
#endif
#endif

NSString* const GtReachabilityDidChangeNotification = @"GtReachabilityDidChangeNotification";
NSString* const GtReachabilityNotificationObjectKey = @"GtReachabilityNotificationObjectKey";

#import <sys/socket.h>
#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>

#import <CoreFoundation/CoreFoundation.h>

#import "GtReachability.h"

#if DEBUG
#define kShouldPrintReachabilityFlags 1
static void PrintReachabilityFlags(SCNetworkReachabilityFlags	 flags, const char* comment)
{
#if kShouldPrintReachabilityFlags
	
	NSLog(@"GtReachability Flag Status: %c%c %c%c%c%c%c%c%c %s\n",
			(flags & kSCNetworkReachabilityFlagsIsWWAN)				  ? 'W' : '-',
			(flags & kSCNetworkReachabilityFlagsReachable)			  ? 'R' : '-',
			
			(flags & kSCNetworkReachabilityFlagsTransientConnection) ? 't' : '-',
			(flags & kSCNetworkReachabilityFlagsConnectionRequired)	  ? 'c' : '-',
			(flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) ? 'C' : '-',
			(flags & kSCNetworkReachabilityFlagsInterventionRequired) ? 'i' : '-',
			(flags & kSCNetworkReachabilityFlagsConnectionOnDemand)	  ? 'D' : '-',
			(flags & kSCNetworkReachabilityFlagsIsLocalAddress)		  ? 'l' : '-',
			(flags & kSCNetworkReachabilityFlagsIsDirect)			  ? 'd' : '-',
			comment
			);
#endif
}
#endif


//NSString* const GtNetworkReachabilityChangedNotification = @"GtNetworkReachabilityChangedNotification";

@interface GtReachability ()
@property (readwrite, retain, nonatomic) NSString* hostName;
@end

@implementation GtReachability

static GtReachability* s_default = nil;

@synthesize hostName = m_hostName;
@synthesize broadcastMask = m_broadcastMask;
@synthesize reachabilityRef = m_reachabilityRef;
@synthesize reachabilityType = m_type;

- (void) setDefaults
{
	m_broadcastMask = GtReachabilityDefaultBroadcastMask;
	m_lastFlags = self.currentReachabilityFlags;
}

- (id) initWithHostName:(NSString*) hostName
{
	if((self = [super init]))
	{
		NSRange range = [hostName rangeOfString:@"//"];
		if(range.length)
		{
			hostName = [hostName substringFromIndex:range.location + 2];
		}

//#if DEBUG		   
//		  GtTrace(GtTraceReachability, @"Set reachability for host: %@", hostName);
//#endif		
//		  
		m_reachabilityRef = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, [hostName UTF8String]);
		if(m_reachabilityRef)
		{
			
		}
		
		self.hostName = hostName;
		m_type = GtHostReachability;
		
		[self setDefaults];
	}

	return self;
}

- (id) initWithAddress:(const struct sockaddr_in*) hostAddress
{
	if((self = [super init]))
	{
		m_reachabilityRef = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)hostAddress);
		m_type = GtAddressReachability;
		[self setDefaults];
		// TODO save address?
	}
	
	return self;
}

- (id) initWithInternetConnection
{
	if((self = [super init]))
	{
		struct sockaddr_in zeroAddress;
		bzero(&zeroAddress, sizeof(zeroAddress));
		zeroAddress.sin_len = sizeof(zeroAddress);
		zeroAddress.sin_family = AF_INET;
		m_reachabilityRef = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&zeroAddress);
		m_type = GtInternetReachability;
		self.hostName = @"0.0.0.0";
		[self setDefaults];
	}
	
	return self;
}

- (id) initWithWiFi
{
	if((self = [super init]))
	{
		struct sockaddr_in localWifiAddress;
		bzero(&localWifiAddress, sizeof(localWifiAddress));
		localWifiAddress.sin_len = sizeof(localWifiAddress);
		localWifiAddress.sin_family = AF_INET;
	// IN_LINKLOCALNETNUM is defined in <netinet/in.h> as 169.254.0.0
		localWifiAddress.sin_addr.s_addr = htonl(IN_LINKLOCALNETNUM);
		m_reachabilityRef = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&localWifiAddress);
		m_type = GtWifiReachability;
		[self setDefaults];
	}
	
	return self;
}

- (void) dealloc
{
	[self stopNotifer];

	GtReleaseWithNil(m_hostName);
	if(m_reachabilityRef!= NULL)
	{
		CFRelease(m_reachabilityRef);
		m_reachabilityRef = nil;
	}
	GtSuperDealloc();
}

+ (void) initialize
{
	s_default = [[GtReachability alloc] initWithInternetConnection];
}

+ (GtReachability*) defaultReachability
{
	return s_default;
}

+ (BOOL) isConnectedToNetwork 
{ 
#if FAKE_OFFLINE	
	return NO;
#endif
	
	return [GtReachability defaultReachability].isReachable;
}

- (void) broadcastDidChangeMessage
{
	[[NSNotificationCenter defaultCenter] postNotification:
		[NSNotification notificationWithName:GtReachabilityDidChangeNotification object:nil userInfo:
			[NSDictionary dictionaryWithObject:self forKey:GtReachabilityNotificationObjectKey]]];
}

- (void) onReachabilityCallback
{
	SCNetworkReachabilityFlags newFlags = self.currentReachabilityFlags;

#if DEBUG
	PrintReachabilityFlags(newFlags, "new flags");
	PrintReachabilityFlags(m_lastFlags, "previous flags");
#endif

	if(newFlags != m_lastFlags)
	{
		if( GtBitMaskTest(newFlags, m_broadcastMask) !=
			GtBitMaskTest(m_lastFlags, m_broadcastMask))
		{
			[self broadcastDidChangeMessage];
		}
	
		m_lastFlags = newFlags;
	}
}

static void ReachabilityCallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void* info)
{
	GtAssert(info != NULL, @"info was NULL in ReachabilityCallback");
	GtAssert([(NSObject*) info isKindOfClass: [GtReachability class]], @"info was wrong class in ReachabilityCallback");

	GtReachability* noteObject = (GtReachability*) info;
	[noteObject onReachabilityCallback];
}

- (BOOL) startNotifer
{


	BOOL retVal = NO;
	SCNetworkReachabilityContext	context = {0, self, NULL, NULL, NULL};
	if(SCNetworkReachabilitySetCallback(m_reachabilityRef, ReachabilityCallback, &context))
	{
		if(SCNetworkReachabilityScheduleWithRunLoop(m_reachabilityRef, CFRunLoopGetMain(), kCFRunLoopDefaultMode))
		{
			retVal = YES;
		}
	}
	return retVal;
}

- (void) stopNotifer
{
	if(m_reachabilityRef!= NULL)
	{
		SCNetworkReachabilityUnscheduleFromRunLoop(m_reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
	}
}

- (BOOL) isReachable
{

	return	GtBitMaskTest(self.currentReachabilityFlags, kSCNetworkReachabilityFlagsReachable);
}

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

@end

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
		//	then we'll assume (for now) that your on Wi-Fi
		retVal = gtNetworkReachableViaWiFi;
	}
	
	
	if ((((flags & mySCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
		(flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
	{
			// ... and the connection is on-demand (or on-traffic) if the
			//	   calling application is using the CFSocketStream or higher APIs

			if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
			{
				// ... and no [user] intervention is needed
				retVal = gtNetworkReachableViaWiFi;
			}
		}
	
	if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
	{
		// ... but WWAN connections are OK if the calling application
		//	   is using the CFNetwork (CFSocketStream?) APIs.
		retVal = gtNetworkReachableViaWWAN;
	}
	return retVal;
}
*/
/*

+ (GtReachability*) reachabilityWithHostName: (NSString*) hostName
{
	GtReachability* retVal = GtReturnAutoreleased([[GtReachability alloc] init]);
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

#endif
