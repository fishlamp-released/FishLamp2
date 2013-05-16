/*
 
// based on Apple's Reachability.h
// TODO: refactor this piece of poo

*/

#if IPHONE

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

typedef enum {
	GtInternetReachability,
    GtHostReachability,
    GtAddressReachability,
    GtWifiReachability
} GtReachabilityType;

extern NSString* const GtNetworkReachabilityChangedNotification;

@interface GtReachability: NSObject
{
	SCNetworkReachabilityRef m_reachabilityRef;
    NSString* m_hostName;
    GtReachabilityType m_type;
}

@property (readonly, assign, nonatomic) GtReachabilityType reachabilityType;

@property (readonly, assign, nonatomic) NSString* hostName;
@property (readonly, assign, nonatomic) SCNetworkReachabilityRef reachabilityRef;

@property (readonly, assign, nonatomic) BOOL isReachable;

@property (readonly, assign, nonatomic) BOOL connectionRequired;

@property (readonly, assign, nonatomic) SCNetworkReachabilityFlags currentReachabilityFlags;

- (id) initWithHostName:(NSString*) hostName;
- (id) initWithAddress:(const struct sockaddr_in*) address;
- (id) initWithInternetConnection;
- (id) initWithWiFi;

+ (BOOL) isConnectedToNetwork;

//Start listening for reachability notifications on the current run loop
- (BOOL) startNotifer;
- (void) stopNotifer;


@end

#endif