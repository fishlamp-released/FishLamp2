//
//  FLTwitter.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/18/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLTwitterMgr.h"
#import "NSString+GUID.h"
#import "FLUserDataStorageService.h"

@interface FLTwitterMgr ()
@property (readwrite, strong) FLOAuthSession* oauthSession;
@property (readwrite, strong) FLOAuthApp* oauthInfo;

- (void) didAuthenticateForUserGuid:(NSString*) userGuid 
                       oauthSession:(FLOAuthSession*) oauthSession;

- (void) loadSessionForUserGuid:(NSString*) userGuid;


- (BOOL) needsAuthorizationForUserGuid:(NSString*) userGuid;

- (void) logoutUserWithUserGuid:(NSString*) userGuid;

@end

@implementation FLTwitterMgr

synthesize_(oauthInfo)
synthesize_(oauthSession)

- (id) init {
	if((self = [super init])) {
         _oauthInfo = [[FLOAuthApp alloc] init];
	}
	
	return self;
}

- (BOOL) needsAuthorizationForUserGuid:(NSString*) userGuid {
	if(!self.oauthSession){
		[self loadSessionForUserGuid:userGuid];
	}
	return self.oauthSession == nil;
}

dealloc_ (
    [_oauthInfo release];
    [_oauthSession release];
)

- (FLObjectDatabase*) database {
    return [self.parentService storageService].documentsDatabase;
}

+ (void) clearTwitterCookies {
  	NSMutableArray* deleteThese = [NSMutableArray array];
    NSArray* cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
	for (NSHTTPCookie * cookie in cookies)  {
		if([cookie.domain rangeOfString:@"twitter"].length > 0) {
			[deleteThese addObject:cookie];
		}
	}
	for (NSHTTPCookie * cookie in deleteThese)  {
		[[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
	}
}

- (void) logoutUserWithUserGuid:(NSString*) userGuid {
	FLOAuthSession* input = [FLOAuthSession oAuthSession];
	input.userGuid = userGuid;
	input.appName = @"twitter.com";
	[self.database deleteObject:input];
    [FLTwitterMgr clearTwitterCookies];
	self.oauthSession = nil;
}

- (void) loadSessionForUserGuid:(NSString*) userGuid {
	FLOAuthSession* input = [FLOAuthSession oAuthSession];
	input.userGuid = userGuid;
	input.appName = @"twitter.com";
	self.oauthSession = [self.database loadObject:input];
}

- (void) didAuthenticateForUserGuid:(NSString*) userGuid oauthSession:(FLOAuthSession*) oauthSession {
	oauthSession.userGuid = userGuid;
	oauthSession.appName = @"twitter.com";
	
	[self.database saveObject:oauthSession];
	self.oauthSession = oauthSession;
}

@end

