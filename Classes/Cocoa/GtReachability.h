/*
 
// based on Apple's Reachability.h
// this needs to be refactor - this is piece of poo

*/

#if 0

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>


// use with NSNotificationCenter
extern NSString* const GtReachabilityDidChangeNotification;
extern NSString* const GtReachabilityNotificationObjectKey;

typedef enum {
	GtInternetReachability,
	GtHostReachability,
	GtAddressReachability,
	GtWifiReachability
} GtReachabilityType;

#define GtReachabilityDefaultBroadcastMask kSCNetworkReachabilityFlagsReachable

#define GtReachabilityErrorDomain @"GtReachabilityErrorDomain"

typedef enum {
	GtReachabilityErrorDomainCodeNoConnection		= -2000,
	GtReachabilityErrorDomainCodeHostNotReachable	= -2001
} GtReachabilityErrorDomainCode;

@protocol GtReachablityListener;

@interface GtReachability: NSObject {
@private
	SCNetworkReachabilityRef m_reachabilityRef;
	NSString* m_hostName;
	GtReachabilityType m_type;
	SCNetworkReachabilityFlags m_lastFlags;
	SCNetworkReachabilityFlags m_broadcastMask;
}

- (id) initWithHostName:(NSString*) hostName;
- (id) initWithAddress:(const struct sockaddr_in*) address;
- (id) initWithInternetConnection;
- (id) initWithWiFi;

@property (readonly, assign, nonatomic) GtReachabilityType reachabilityType;

@property (readonly, retain, nonatomic) NSString* hostName;
@property (readonly, assign, nonatomic) SCNetworkReachabilityRef reachabilityRef;

@property (readonly, assign, nonatomic) BOOL isReachable;
@property (readonly, assign, nonatomic) BOOL connectionRequired;

@property (readonly, assign, nonatomic) SCNetworkReachabilityFlags currentReachabilityFlags;
@property (readonly, assign, nonatomic) SCNetworkReachabilityFlags broadcastMask; //defaults to GtReachabilityDefaultBroadcastMask

//Start listening for reachability notifications on the current run loop
- (BOOL) startNotifer;
- (void) stopNotifer;

+ (GtReachability*) defaultReachability;
+ (BOOL) isConnectedToNetwork; // checks default reachability

@end

#endif