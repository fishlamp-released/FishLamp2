//
//	FLNetworkActivityMonitor.h
//	Snaplets
//
//	Created by Mike Fullerton on 11/4/10.
//	Copyright 2010 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLGlobalNetworkActivityIndicator.h"

@interface FLNetworkActivityIndicator : NSObject<FLGlobalNetworkActivityIndicator> {
@private
	NSMutableSet* _objects;
}

FLSingletonProperty(FLNetworkActivityIndicator);

@end
