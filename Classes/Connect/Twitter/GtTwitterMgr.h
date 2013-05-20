//
//  GtTwitter.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/18/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtOauthApp.h"
#import "GtOAuthSession.h"

#define GtTwitterDefaultUserID [NSString zeroGuidString]

@interface GtTwitterMgr : GtOAuthApp {
@private
	NSMutableDictionary* m_sessions;
}

- (GtOAuthSession*) sessionForUserGuid:(NSString*) userGuid;

- (void) loadSessionForUserGuid:(NSString*) userGuid;
- (BOOL) needsAuthorizationForUserGuid:(NSString*) userGuid;
- (void) logoutUserWithUserGuid:(NSString*) userGuid;
- (void) didAuthenticateForUserGuid:(NSString*) userGuid 
	session:(GtOAuthSession*) session;

- (void) clearTwitterCookies;

GtSingletonProperty(GtTwitterMgr);

@end

