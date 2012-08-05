//
//  FLTwitter.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/18/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLTwitterMgr.h"
#import "NSString+GUID.h"
#import "FLUserSession.h"

@implementation FLTwitterMgr

FLSynthesizeSingleton(FLTwitterMgr);

- (id) init
{
	if((self = [super init]))
	{
		m_sessions = [[NSMutableDictionary alloc] init];
	}
	
	return self;
}

- (FLOAuthSession*) sessionForUserGuid:(NSString*) userGuid
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
	FLRelease(m_sessions);
	FLSuperDealloc();
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
	FLOAuthSession* input = [FLOAuthSession oAuthSession];
	input.userGuid = userGuid;
	input.appName = @"twitter.com";
	[[FLUserSession instance].documentsDatabase deleteObject:input];
	[m_sessions removeObjectForKey:userGuid];
    [self clearTwitterCookies];
}

- (void) loadSessionForUserGuid:(NSString*) userGuid;
{
	FLOAuthSession* input = [FLOAuthSession oAuthSession];
	input.userGuid = userGuid;
	input.appName = @"twitter.com";
	
	FLOAuthSession* output = [[FLUserSession instance].documentsDatabase loadObject:input];
	if(output)
	{
		[m_sessions setObject:output forKey:userGuid];
	}
	else
	{
		[m_sessions removeObjectForKey:userGuid];
	}
}

- (void) didAuthenticateForUserGuid:(NSString*) userGuid session:(FLOAuthSession*) session
{
	session.userGuid = userGuid;
	session.appName = @"twitter.com";
	
	[[FLUserSession instance].documentsDatabase saveObject:session];
	[m_sessions setObject:session forKey:userGuid];
}

@end
