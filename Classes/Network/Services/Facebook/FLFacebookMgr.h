//
//  FLFacebookManager.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/13/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FacebookEnums.h"
#import "FLService.h"
#import "FLNetworkServerContext.h"
#import "FLFacebookNetworkSession.h"
#import "FLFacebookAll.h"
#import "FLFacebookOperation.h"
#import "FLAction.h"
#import "FLFacebookAuthenticationResponse.h"

#define FLFacebookErrorKey @"fb_error"
#define FLFacebookErrorDomain @"FLFacebookErrorDomain"

typedef enum { 
	FLFacebookErrorCodeNone,
	FLFacebookErrorCodeAuthenticationFailed
} FLFacebookErrorCode;

//#define FLFacebookWriteStatusPermissions [NSArray arrayWithObjects:kFLFacebookUserWritePermissionPublishStream, kFLFacebookUserWritePermissionOfflineAccess, kFLFacebookUserReadPermissionStatus, nil]
//
//#define FLFacebookReadStreamStatus [NSArray arrayWithObjects:kFLFacebookUserWritePermissionPublishStream, kFLFacebookUserWritePermissionOfflineAccess, kFLFacebookUserReadPermissionStatus, @"read_stream", nil]

#define FLFacebookPostStatusOnlyPermissions [NSArray arrayWithObjects:kFLFacebookUserWritePermissionPublishStream, kFLFacebookUserWritePermissionOfflineAccess, nil ]



@protocol FLFacebookManagerDelegate;

@interface FLFacebookMgr : FLService {
@private
	FLFacebookNetworkSession* _facebookNetworkSession; // 
	NSString* _appId;
	NSString* _encodedToken;
    NSArray* _permissions;
}

@property (readwrite, retain, nonatomic) NSArray* permissions;
@property (readwrite, retain, nonatomic) NSString* appId;
@property (readwrite, retain, nonatomic) FLFacebookNetworkSession* facebookNetworkSession;
@property (readwrite, retain, nonatomic) NSString* encodedToken;

- (void) logout;

- (BOOL) appNeedsAuthorizationForPermissions:(NSArray*) permissions;
- (BOOL) appSessionHasExpired;

+ (void) clearFacebookCookies;

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
+ (FLFacebookError*) errorFromURLParams:(NSDictionary*) params;
+ (FLFacebookNetworkSession*) sessionFromURLParams:(NSDictionary*) params;


+ (FLFacebookAuthenticationResponse*) authenticationResponseFromURL:(NSURL*) url outError:(NSError**) error;

@end

declare_service_(facebookService, FLFacebookMgr);