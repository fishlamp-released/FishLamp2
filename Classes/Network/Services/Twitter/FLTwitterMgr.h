//
//  FLTwitter.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/18/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLOauthApp.h"
#import "FLOAuthSession.h"
#import "FLAppService.h"

#define FLTwitterDefaultUserID [NSString zeroGuidString]

@interface FLTwitterMgr : FLUserService {
@private
    FLOAuthApp* _oauth;
	NSMutableDictionary* _sessions;
}
@property (readonly, strong) FLOAuthApp* oauthInfo;

- (FLOAuthSession*) sessionForUserGuid:(NSString*) userGuid;

- (void) loadSessionForUserGuid:(NSString*) userGuid;
- (BOOL) needsAuthorizationForUserGuid:(NSString*) userGuid;
- (void) logoutUserWithUserGuid:(NSString*) userGuid;
- (void) didAuthenticateForUserGuid:(NSString*) userGuid 
	session:(FLOAuthSession*) session;

- (void) clearTwitterCookies;

FLSingletonProperty(FLTwitterMgr);

@end

