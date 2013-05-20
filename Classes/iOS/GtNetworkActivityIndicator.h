//
//	GtNetworkActivityMonitor.h
//	Snaplets
//
//	Created by Mike Fullerton on 11/4/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtGlobalNetworkActivityIndicator.h"

@interface GtNetworkActivityIndicator : NSObject<GtGlobalNetworkActivityIndicator> {
@private
	int m_networkActivityCounter;
	NSTimeInterval m_lastUpdate;
	NSTimer* m_updateTimer;
}

GtSingletonProperty(GtNetworkActivityIndicator);

@end
