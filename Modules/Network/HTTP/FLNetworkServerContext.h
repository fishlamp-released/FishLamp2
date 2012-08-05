//
//	FLNetworkEndpointHelper.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/22/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

@protocol FLHttpConnectionFactory;
@protocol FLHttpOperationResponseHandler;
@protocol FLOperationAuthenticator;

#define FLNetworkServerPropertyKeyUrl @"url"
#define FLNetworkServerPropertyKeyTargetNamespace @"namespace"

@interface FLNetworkServerContext : NSObject<NSCoding> {
@private
	id<FLHttpOperationResponseHandler> _defaultResponseHandler;
	id<FLHttpConnectionFactory> _defaultNetworkRequestFactory;
	id<FLOperationAuthenticator> _authenticator;
	NSMutableDictionary* _properties;
}
@property (readwrite, retain, nonatomic) id<FLHttpConnectionFactory> defaultNetworkRequestFactory;
@property (readwrite, retain, nonatomic) id<FLHttpOperationResponseHandler> defaultNetworkOperationResponseHandler;
@property (readwrite, retain, nonatomic) id<FLOperationAuthenticator> authenticator;

@property (readonly, retain, nonatomic) NSMutableDictionary* properties;

@end
