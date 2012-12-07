//
//  FLFacebookService.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/13/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLFacebookService.h"
#import "NSString+URL.h"
#import "FLUserDataStorageService.h"
#import "FLContext.h"

@implementation FLFacebookService

@synthesize facebookNetworkSession = _facebookNetworkSession;
@synthesize appId = _appId;
@synthesize encodedToken = _encodedToken;
@synthesize permissions = _permissions;

#if FL_MRC
- (void) dealloc {
    [_permissions release];
	[_encodedToken release];
	[_appId release];
	[_facebookNetworkSession release];
    [super dealloc];
}
#endif

+ (id) facebookService {
    return FLAutorelease([[[self class] alloc] init]);
}

- (FLDatabase*) database {
    return [[self.context storageService] documentsDatabase];
}

- (void) logout
{
	FLFacebookNetworkSession* input = [FLFacebookNetworkSession facebookNetworkSession];
	input.appId = self.appId;

	[self.database deleteObject:input];
	FLReleaseWithNil_(_facebookNetworkSession);
    FLReleaseWithNil_(_encodedToken);
    
    [FLFacebookService clearHTTPCookies];
}

+ (void) clearHTTPCookies
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

- (BOOL) appNeedsAuthorizationForPermissions:(NSArray*) permissions
{
	if(!_facebookNetworkSession) 
	{
		FLFacebookNetworkSession* input = [FLFacebookNetworkSession facebookNetworkSession];
		input.appId = self.appId;
		
		FLAssignObjectWithRetain(_facebookNetworkSession, [self.database loadObject:input]);
		
		if(_facebookNetworkSession && FLStringIsEmpty(_facebookNetworkSession.userId))
		{
			[self.database deleteObject:_facebookNetworkSession];
			FLReleaseWithNil_(_facebookNetworkSession);
		}
	}
	
	if(!_facebookNetworkSession)
	{
    	return YES;
	}
    
    if(!FLStringsAreEqual(_facebookNetworkSession.appId, self.appId))
    {
        return YES;
    }
    
    if(_facebookNetworkSession.expiration_date != nil && 
        (_facebookNetworkSession.expiration_date.timeIntervalSinceReferenceDate < [NSDate timeIntervalSinceReferenceDate]))
    {
        return YES;
    }
    
//	for(NSString* perm in permissions)
//	{
//		BOOL foundIt = NO;
//		for(NSString* authorizedPerm in _facebookNetworkSession.permissions)
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
	
	
//	return !_facebookNetworkSession || ([NSDate timeIntervalSinceReferenceDate] > _facebookNetworkSession.expiration_date.timeIntervalSinceReferenceDate);
}

- (BOOL) appSessionHasExpired
{
	return ([NSDate timeIntervalSinceReferenceDate] > _facebookNetworkSession.expiration_date.timeIntervalSinceReferenceDate);
}

- (void) setFacebookNetworkSession:(FLFacebookNetworkSession*) session
{
	FLAssignObjectWithRetain(_facebookNetworkSession, session);

	self.encodedToken = nil;
	
	if(_facebookNetworkSession)
	{
		if(FLStringIsEmpty(_facebookNetworkSession.appId))
		{
			_facebookNetworkSession.appId = self.appId;
		}

		self.encodedToken = [_facebookNetworkSession.access_token urlEncodeString:NSUTF8StringEncoding];
		[self.database saveObject:_facebookNetworkSession];
	}
}



- (NSString*) encodedToken
{
	if(!_encodedToken)
	{
		_encodedToken =  FLRetain([self.facebookNetworkSession.access_token urlEncodeString:NSUTF8StringEncoding]);
	}
	return _encodedToken;
}






@end

