//
//  GtNetworkStatusMonitor.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/9/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

extern NSString* const GtNetworkStatusNetworkBecameAvailableNotification;
extern NSString* const GtNetworkStatusNetworkBecameUnavailableNotification;

@interface GtNetworkStatusMonitor : NSObject {
@private
	SCNetworkReachabilityRef m_reachabilityRef;
	SCNetworkReachabilityContext	m_context;
	
    BOOL m_isReachable;
    BOOL m_isMonitoring;
}

@property (readonly, assign, readonly) BOOL networkIsReachable;

- (void) beginNetworkMonitoring;

GtSingletonProperty(GtNetworkStatusMonitor);

@end
