//
//	GtNetworkEndpointHelper.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/22/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@protocol GtHttpConnectionFactory;
@protocol GtHttpOperationResponseHandler;
@protocol GtOperationAuthenticator;

#import "GtUserSession.h"

#define GtNetworkServerPropertyKeyUrl @"url"
#define GtNetworkServerPropertyKeyTargetNamespace @"namespace"

@interface GtNetworkServerContext : NSObject<NSCoding> {
@private
	id<GtHttpOperationResponseHandler> m_defaultResponseHandler;
	id<GtHttpConnectionFactory> m_defaultNetworkRequestFactory;
	id<GtOperationAuthenticator> m_authenticator;
	NSMutableDictionary* m_properties;
	GtUserSession* m_userSession;
}
@property (readwrite, retain, nonatomic) id<GtHttpConnectionFactory> defaultNetworkRequestFactory;
@property (readwrite, retain, nonatomic) id<GtHttpOperationResponseHandler> defaultNetworkOperationResponseHandler;
@property (readwrite, retain, nonatomic) id<GtOperationAuthenticator> authenticator;
@property (readwrite, retain, nonatomic) GtUserSession* userSession;

@property (readonly, retain, nonatomic) NSMutableDictionary* properties;

@end
