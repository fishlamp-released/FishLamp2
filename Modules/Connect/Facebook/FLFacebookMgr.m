//
//  FLFacebookMgr.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/13/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLFacebookMgr.h"
#import "NSString+URL.h"
#import "FLUserSession.h"

static NSString* kRedirectURL = @"http://www.facebook.com/connect/login_success.html";

@implementation FLFacebookMgr

@synthesize session = m_session;
@synthesize appId = m_appId;
@synthesize encodedToken = m_encodedToken;
@synthesize permissions = m_permissions;

FLSynthesizeSingleton(FLFacebookMgr);

- (id) init
{
	if((self = [super init]))
	{
	}
	
	return self;
}

- (void) dealloc
{
    FLRelease(m_permissions);
	FLRelease(m_encodedToken);
	FLRelease(m_appId);
	FLRelease(m_session);
	FLSuperDealloc();
}

// from facebook demo app
+ (NSString *)serializeURL:(NSString *)baseUrl
				   params:(NSDictionary *)params 
{
  return [FLFacebookMgr serializeURL:baseUrl params:params httpMethod:@"GET"];
}

/**
 * Generate get URL
 */
// from facebook demo app
+ (NSString*)serializeURL:(NSString *)baseUrl
				   params:(NSDictionary *)params
			   httpMethod:(NSString *)httpMethod 
{
	NSURL* parsedURL = [NSURL URLWithString:baseUrl];

	NSString* queryPrefix = parsedURL.query ? @"&" : @"?";

	NSMutableArray* pairs = [NSMutableArray array];
	
	for (NSString* key in [params keyEnumerator]) 
	{
#if IOS    
		if (	([[params valueForKey:key] isKindOfClass:[CocoaImage class]])
				||([[params valueForKey:key] isKindOfClass:[NSData class]])) 
		{
			if ([httpMethod isEqualToString:@"GET"]) 
			{
				FLDebugLog(@"can not use GET to upload a file");
			}
		
			continue;
		}
#endif

// TODO: will this leak???
		NSString* escaped_value = (__fl_bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
									NULL, /* allocator */
									(__fl_bridge CFStringRef)[params objectForKey:key],
									NULL, /* charactersToLeaveUnescaped */
									(__fl_bridge CFStringRef)@"!*'();:@&=+$,/?%#[]",
									kCFStringEncodingUTF8);

		[pairs addObject:[NSString stringWithFormat:@"%@=%@", key, escaped_value]];
		FLRelease(escaped_value);
	}
  
	NSString* query = [pairs componentsJoinedByString:@"&"];

	return [NSString stringWithFormat:@"%@%@%@", baseUrl, queryPrefix, query];
}

#define URL @"https://www.facebook.com/dialog/oauth?"

//     client_id=%@&redirect_uri=%@&scope=email,read_stream&
//     response_type=token

+ (NSURL*) buildOAuthUrl:(NSArray *)permissions forAppId:(NSString*) appId
{
	NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								appId, @"client_id",
									@"user_agent", @"type",
                                 kRedirectURL, @"redirect_uri",
                                @"touch", @"display",
								 @"token", @"response_type",
                           //      kSDKVersion, @"sdk",
                                 nil];
	if (permissions != nil) 
	{
		NSString* scope = [permissions componentsJoinedByString:@","];
		[params setValue:scope forKey:@"scope"];
	}
	
	return [NSURL URLWithString:[FLFacebookMgr serializeURL:URL params:params]];
}

- (void) clearFacebookCookies
{
  	NSMutableArray* deleteThese = [NSMutableArray array];
    NSArray* cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
	for (NSHTTPCookie * cookie in cookies) 
	{
		if([cookie.domain rangeOfString:@"facebook"].length > 0)
		{
			[deleteThese addObject:cookie];
		}
	}
	for (NSHTTPCookie * cookie in deleteThese) 
	{
		[[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
	}
}

- (void) logout
{
	FLFacebookNetworkSession* input = [FLFacebookNetworkSession facebookNetworkSession];
	input.appId = self.appId;
	[[FLUserSession instance].documentsDatabase deleteObject:input];
	FLReleaseWithNil(m_session);
    FLReleaseWithNil(m_encodedToken);
    
    [self clearFacebookCookies];

}

- (BOOL) appNeedsAuthorizationForPermissions:(NSArray*) permissions
{
	if(!m_session) 
	{
		FLFacebookNetworkSession* input = [FLFacebookNetworkSession facebookNetworkSession];
		input.appId = self.appId;
		
		FLAssignObject(m_session, [[FLUserSession instance].documentsDatabase loadObject:input]);
		
		if(m_session && FLStringIsEmpty(m_session.userId))
		{
			[[FLUserSession instance].documentsDatabase deleteObject:m_session];
			FLReleaseWithNil(m_session);
		}
	}
	
	if(!m_session)
	{
    	return YES;
	}
    
    if(!FLStringsAreEqual(m_session.appId, self.appId))
    {
        return YES;
    }
    
    if(m_session.expiration_date != nil && 
        (m_session.expiration_date.timeIntervalSinceReferenceDate < [NSDate timeIntervalSinceReferenceDate]))
    {
        return YES;
    }
    
//	for(NSString* perm in permissions)
//	{
//		BOOL foundIt = NO;
//		for(NSString* authorizedPerm in m_session.permissions)
//		{
//			if(FLStringsAreEqual(perm, authorizedPerm))
//			{
//				foundIt = YES;
//				break;
//			}	
//		}
//		
//		if(!foundIt)
//		{
//			return YES;
//		}
//	}
    
	return NO;
	
	
//	return !m_session || ([NSDate timeIntervalSinceReferenceDate] > m_session.expiration_date.timeIntervalSinceReferenceDate);
}

- (BOOL) appSessionHasExpired
{
	return ([NSDate timeIntervalSinceReferenceDate] > m_session.expiration_date.timeIntervalSinceReferenceDate);
}

- (void) setSession:(FLFacebookNetworkSession*) session
{
	FLAssignObject(m_session, session);

	self.encodedToken = nil;
	
	if(m_session)
	{
		if(FLStringIsEmpty(m_session.appId))
		{
			m_session.appId = self.appId;
		}

		self.encodedToken = [m_session.access_token urlEncodeString:NSUTF8StringEncoding];
		[[FLUserSession instance].documentsDatabase saveObject:m_session];
	}
}

+ (NSDictionary*)parseURLParams:(NSString *)query
{
	NSArray *pairs = [query componentsSeparatedByString:@"&"];
	NSMutableDictionary *params = FLReturnAutoreleased([[NSMutableDictionary alloc] init]);
	
	for (NSString *pair in pairs) 
	{
		NSArray *kv = [pair componentsSeparatedByString:@"="];
		if(kv.count == 2)
		{
			NSString *val = [[kv objectAtIndex:1] urlDecodeString:NSUTF8StringEncoding];
			[params setObject:val forKey:[kv objectAtIndex:0]];
		}
	}
	return params;
}

- (NSString*) encodedToken
{
	if(!m_encodedToken)
	{
		m_encodedToken =  FLReturnRetained([self.session.access_token urlEncodeString:NSUTF8StringEncoding]);
	}
	return m_encodedToken;
}

+ (FLFacebookNetworkSession*) sessionFromURLParams:(NSDictionary*) params
{
	NSString *accessToken = [params valueForKey:@"access_token"];
	if(FLStringIsNotEmpty(accessToken))
	{
		FLFacebookNetworkSession* session = [FLFacebookNetworkSession facebookNetworkSession];
		session.access_token = accessToken;
		session.expiration_date = [NSDate distantFuture];
		
	// We have an access token, so parse the expiration date.
		NSString *expTime = [params valueForKey:@"expires_in"];
		if(FLStringIsNotEmpty(expTime))
		{
			int expVal = [expTime intValue];
			if (expVal != 0) 
			{
				session.expiration_date = [NSDate dateWithTimeIntervalSinceNow:expVal];
			}
		}
	
		return session;
	}
	
	return nil;
}

+ (FLFacebookError*) errorFromURLParams:(NSDictionary*) params
{
	if([params valueForKey:@"error"])
	{
		FLFacebookError* error = [FLFacebookError facebookError];
		error.error = [params valueForKey:@"error"];
		error.error_reason = [params valueForKey:@"error_reason"];
		error.error_description = [params valueForKey:@"error_description"];
		return error;
	}

	return nil;
}

+ (FLFacebookAuthenticationResponse*) authenticationResponseFromURL:(NSURL*) url outError:(NSError**) error
{
	FLFacebookAuthenticationResponse* response = 
		[FLFacebookAuthenticationResponse facebookAuthenticationResponse];

// this code from the demo app.	
	NSString *query = [[url fragment] urlDecodeString:NSUTF8StringEncoding];

	// Version 3.2.3 of the Facebook app encodes the parameters in the query but
	// version 3.3 and above encode the parameters in the fragment. To support
	// both versions of the Facebook app, we try to parse the query if
	// the fragment is missing.
	if (!query) 
	{
		query = [[url query] urlDecodeString:NSUTF8StringEncoding];
	}
	
	NSDictionary *params = [FLFacebookMgr parseURLParams:query];
	FLFacebookNetworkSession* session = [FLFacebookMgr sessionFromURLParams:params];
	if(session)
	{
		response.session = session;
	}
	else
	{
		FLFacebookError* fberror = [FLFacebookMgr errorFromURLParams:params];
		if(fberror)
		{
			if(error)
			{
				*error = [[NSError alloc] initWithDomain:FLFacebookErrorDomain 
					code:FLFacebookErrorCodeAuthenticationFailed 
					userInfo:[NSDictionary dictionaryWithObject:fberror forKey:FLFacebookErrorKey]];
			}
		}
		else
		{
			response.redirectURL = url;
		}
	}
	
	return response;
}

+ (NSMutableString*) buildURL:(NSString*) authenticationToken
	user:(NSString*) user
	object:(NSString*) object
	params:(NSString*) firstParameter, ...
{
	NSMutableString* url = FLStringIsEmpty(object) ? 
		[NSMutableString stringWithFormat: @"https://graph.facebook.com/%@?access_token=%@", user, authenticationToken] :
		[NSMutableString stringWithFormat: @"https://graph.facebook.com/%@/%@?access_token=%@", user, object, authenticationToken];

	if(FLStringIsNotEmpty(firstParameter))
	{
		va_list valist;
		va_start(valist, firstParameter);   
		NSString* key = firstParameter;
		id obj = nil;
		while ((obj = va_arg(valist, id)))
		{ 
			if(key)
			{
				NSString* value = (NSString*) obj;
				[url appendFormat:@"&%@=%@", key, [value urlEncodeString:NSUTF8StringEncoding]];
				key = nil;
			}
			else
			{
				key = (NSString*) obj;
			}
		}
		va_end(valist);
	}
	return url;
}

@end


