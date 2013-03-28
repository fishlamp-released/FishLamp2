//
//  FLTwitter.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/18/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLTwitterService.h"
#import "NSString+GUID.h"
#import "FLService.h"
#import "FLDatabase.h"
#import "FLServiceKeys.h"

@interface FLTwitterService ()
@property (readwrite, strong) FLOAuthSession* oauthSession;
@property (readwrite, strong) FLOAuthApp* oauthInfo;

- (void) didAuthenticateForUserGuid:(NSString*) userGuid 
                       oauthSession:(FLOAuthSession*) oauthSession;

- (void) loadSessionForUserGuid:(NSString*) userGuid;


- (BOOL) needsAuthorizationForUserGuid:(NSString*) userGuid;

- (void) logoutUserWithUserGuid:(NSString*) userGuid;

@end

@implementation FLTwitterService

@synthesize oauthInfo = _oauthInfo; 
@synthesize oauthSession = _oauthSession; 

- (id) init {
	if((self = [super init])) {
         _oauthInfo = [[FLOAuthApp alloc] init];
	}
	
	return self;
}

+ (id) twitterService {
    return FLAutorelease([[[self class] alloc] init]);
}

- (BOOL) needsAuthorizationForUserGuid:(NSString*) userGuid {
	if(!self.oauthSession){
		[self loadSessionForUserGuid:userGuid];
	}
	return self.oauthSession == nil;
}

#if FL_MRC
- (void) dealloc {
    [_oauthInfo release];
    [_oauthSession release];
    [super dealloc];
}
#endif

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
	[self.objectStorage deleteObject:input];
    [FLTwitterService clearTwitterCookies];
	self.oauthSession = nil;
}

- (void) loadSessionForUserGuid:(NSString*) userGuid {
	FLOAuthSession* input = [FLOAuthSession oAuthSession];
	input.userGuid = userGuid;
	input.appName = @"twitter.com";
	self.oauthSession = [self.objectStorage readObject:input];
}

- (void) didAuthenticateForUserGuid:(NSString*) userGuid oauthSession:(FLOAuthSession*) oauthSession {
	oauthSession.userGuid = userGuid;
	oauthSession.appName = @"twitter.com";
	
	[self.objectStorage writeObject:oauthSession];
	self.oauthSession = oauthSession;
}

- (void) openService {
    FLPerformSelector1(opener, @selector(openTwitterService:), self);
    [super openService];
}

- (void) closeService {
    FLPerformSelector1(closer, @selector(closeTwitterService:), self);
    [super closeService];
    self.oauthSession = nil;
    self.oauthInfo = nil;
}


@end

