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
#import "FLFacebookAll.h"
#import "FLFacebookNetworkSession.h"
#import "FLFacebookOperation.h"
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

@interface FLFacebookService : FLService {
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

+ (void) clearHTTPCookies;

@end

service_declare_(facebookService, FLFacebookService);