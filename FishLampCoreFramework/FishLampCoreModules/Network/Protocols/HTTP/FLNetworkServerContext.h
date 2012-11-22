//
//	FLNetworkEndpointHelper.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/22/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

#define FLNetworkServerPropertyKeyUrl @"url"
#define FLNetworkServerPropertyKeyTargetNamespace @"namespace"

@interface FLNetworkServerContext : NSObject<NSCoding> {
@private
	NSMutableDictionary* _properties;
}

@property (readonly, retain, nonatomic) NSMutableDictionary* properties;

@end
