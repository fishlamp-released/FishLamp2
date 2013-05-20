//
//  GtTwitter.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/18/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTwitterMgr.h"
#import "NSString+GUID.h"

@implementation GtTwitterMgr

GtSynthesizeSingleton(GtTwitterMgr);

- (id) init
{
	if((self = [super init]))
	{
		m_sessions = [[NSMutableDictionary alloc] init];
	}
	
	return self;
}

- (GtOAuthSession*) sessionForUserGuid:(NSString*) userGuid
{
	return [m_sessions objectForKey:userGuid];
}

- (BOOL) needsAuthorizationForUserGuid:(NSString*) userGuid;
{
	if(![self sessionForUserGuid:userGuid])
	{
		[self loadSessionForUserGuid:userGuid];
	}
	return [self sessionForUserGuid:userGuid] == nil;
}

- (void) dealloc
{
	GtRelease(m_sessions);
	GtSuperDealloc();
}

- (void) clearTwitterCookies
{
  	NSMutableArray* deleteThese = [NSMutableArray array];
    NSArray* cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
	for (NSHTTPCookie * cookie in cookies) 
	{
		if([cookie.domain rangeOfString:@"twitter"].length > 0)
		{
			[deleteThese addObject:cookie];
		}
	}
	for (NSHTTPCookie * cookie in deleteThese) 
	{
		[[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
	}
}

- (void) logoutUserWithUserGuid:(NSString*) userGuid
{
	GtOAuthSession* input = [GtOAuthSession oAuthSession];
	input.userGuid = userGuid;
	input.appName = @"twitter.com";
	[self.userSession.documentsDatabase deleteObject:input];
	[m_sessions removeObjectForKey:userGuid];
    [self clearTwitterCookies];
}

- (void) loadSessionForUserGuid:(NSString*) userGuid;
{
	GtOAuthSession* input = [GtOAuthSession oAuthSession];
	input.userGuid = userGuid;
	input.appName = @"twitter.com";
	
	GtOAuthSession* output = [self.userSession.documentsDatabase loadObject:input];
	if(output)
	{
		[m_sessions setObject:output forKey:userGuid];
	}
	else
	{
		[m_sessions removeObjectForKey:userGuid];
	}
}

- (void) didAuthenticateForUserGuid:(NSString*) userGuid session:(GtOAuthSession*) session
{
	session.userGuid = userGuid;
	session.appName = @"twitter.com";
	
	[self.userSession.documentsDatabase saveObject:session];
	[m_sessions setObject:session forKey:userGuid];
}

@end
