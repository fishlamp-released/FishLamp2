//
//  GtFacebookManager.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/13/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FacebookEnums.h"

#define GtFacebookErrorKey @"fb_error"
#define GtFacebookErrorDomain @"GtFacebookErrorDomain"

typedef enum { 
	GtFacebookErrorCodeNone,
	GtFacebookErrorCodeAuthenticationFailed
} GtFacebookErrorCode;

//#define GtFacebookWriteStatusPermissions [NSArray arrayWithObjects:kGtFacebookUserWritePermissionPublishStream, kGtFacebookUserWritePermissionOfflineAccess, kGtFacebookUserReadPermissionStatus, nil]
//
//#define GtFacebookReadStreamStatus [NSArray arrayWithObjects:kGtFacebookUserWritePermissionPublishStream, kGtFacebookUserWritePermissionOfflineAccess, kGtFacebookUserReadPermissionStatus, @"read_stream", nil]

#define GtFacebookPostStatusOnlyPermissions [NSArray arrayWithObjects:kGtFacebookUserWritePermissionPublishStream, kGtFacebookUserWritePermissionOfflineAccess, nil ]

#import "GtNetworkServerContext.h"
#import "GtFacebookNetworkSession.h"
#import "GtFacebookAll.h"
#import "GtFacebookOperation.h"
#import "GtAction.h"
#import "GtFacebookAuthenticationResponse.h"

@protocol GtFacebookManagerDelegate;

@interface GtFacebookMgr : GtNetworkServerContext {
@private
	GtFacebookNetworkSession* m_session; // 
	NSString* m_appId;
	NSString* m_encodedToken;
    NSArray* m_permissions;
}

GtSingletonProperty(GtFacebookMgr);

@property (readwrite, retain, nonatomic) NSArray* permissions;
@property (readwrite, retain, nonatomic) NSString* appId;
@property (readwrite, retain, nonatomic) GtFacebookNetworkSession* session;
@property (readwrite, retain, nonatomic) NSString* encodedToken;

- (void) logout;

- (BOOL) appNeedsAuthorizationForPermissions:(NSArray*) permissions;
- (BOOL) appSessionHasExpired;

- (void) clearFacebookCookies;

+ (NSMutableString*) buildURL:(NSString*) authenticationToken
	user:(NSString*) user
	object:(NSString*) object
	params:(NSString*) firstParameter, ...;

// utils not requring state
+ (NSURL*) buildOAuthUrl:(NSArray *)permissions forAppId:(NSString*) appId;

// from facebook demo app
+ (NSString*)serializeURL:(NSString *)baseUrl
                   params:(NSDictionary *)params;

// from facebook demo app
+ (NSString*)serializeURL:(NSString *)baseUrl
                   params:(NSDictionary *)params
               httpMethod:(NSString *)httpMethod;

+ (NSDictionary*)parseURLParams:(NSString *)query;
+ (GtFacebookError*) errorFromURLParams:(NSDictionary*) params;
+ (GtFacebookNetworkSession*) sessionFromURLParams:(NSDictionary*) params;


+ (GtFacebookAuthenticationResponse*) authenticationResponseFromURL:(NSURL*) url outError:(NSError**) error;



@end


