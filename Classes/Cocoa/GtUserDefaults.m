//
//	GtUserDefaults.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/13/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if 0

#import "GtUserDefaults.h"
#import "GtKeychain.h"
#import "NSFileManager+GtExtras.h"
#import "GtStringUtils.h"

NSString* GtUserLoginErrorDomain = @"GtUserLoginErrorDomain";

#define KEY(__key__, __login__) [NSString stringWithFormat:@"%@.%@", __key__, __login__.userName]

@implementation GtUserDefaults

+ (BOOL) userExists:(GtUserLogin*) login
{
	return GtStringIsNotEmpty([[NSUserDefaults standardUserDefaults] stringForKey:KEY([GtUserLogin userGuidKey], login)]);
}

#if DEBUG
+ (void) sanityCheckDefaults:(NSUserDefaults*) defaults
{
	NSDictionary* dictionary = [defaults dictionaryRepresentation];
	NSMutableArray* guids = [[NSMutableArray alloc] init];
	
	for(NSString* key in dictionary)
	{
		if([key rangeOfString:@"userName"].length > 0)
		{
//			  GtTrace(GtTraceKeychain, @"current user is: %@", [dictionary objectForKey:key]);
		}
		else if([key rangeOfString:@"userGuid"].length > 0)
		{	
			[guids addObject:key];
		}
	}
	
	for(NSUInteger i = 0; i < guids.count;i++)
	{
		NSString* outerGuid = [dictionary objectForKey:[guids objectAtIndex:i]];
		for(NSUInteger j = i + 1; j < guids.count; j++)
		{
			NSString* innerGuid = [dictionary objectForKey:[guids objectAtIndex:j]];
			
			if(!GtStringIsEmpty(innerGuid) && [innerGuid isEqualToString:outerGuid])
			{
				GtLog(@"Duplicate guids!!!!!\n %@ and %@ share:\n\t%@", [guids objectAtIndex:i], [guids objectAtIndex:j], [dictionary objectForKey:[guids objectAtIndex:j]]); 
			}
		}
	}

	GtReleaseWithNil(guids);

}
#endif

static NSString* LegacyKeys[] = {
	@"email",
	@"lastLogin",
	@"firstLogin",
	@"loginCount",
	@"authToken",
	@"userGuid",
	@"userData",
	@"userName",
	nil };

//[defaults removeObjectForKey:KEY([GtUserLogin emailKey], login)];
//[defaults removeObjectForKey:KEY([GtUserLogin lastLoginKey], login)];
//[defaults removeObjectForKey:KEY([GtUserLogin firstLoginKey], login)];
//[defaults removeObjectForKey:KEY([GtUserLogin loginCountKey], login)];
//[defaults removeObjectForKey:KEY([GtUserLogin authTokenKey], login)];
//[defaults removeObjectForKey:KEY([GtUserLogin userGuidKey], login)];
 

+ (void) loadAllData:(NSArray**) outKeys outData:(NSDictionary**) outData
{
	NSDictionary* userDefaultDictionary = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
	
	NSMutableDictionary* outDictionary = [[NSMutableDictionary alloc] init];
	NSMutableArray* outArray = [[NSMutableArray alloc] init]; 
	
	NSString* currentUserName = [userDefaultDictionary objectForKey:@"userName"];
	if(currentUserName)
	{
		[outDictionary setObject:currentUserName forKey:@"userName"];
	}
	
	*outData = outDictionary;
	*outKeys = outArray;
	
	for(NSString* key in userDefaultDictionary)
	{
		int i = -1;
		while(LegacyKeys[++i])
		{
			if([key rangeOfString:LegacyKeys[i]].length > 0)
			{
				NSArray* splitItems = [key componentsSeparatedByString:@"."];
				if(splitItems.count == 2)
				{
					[outArray addObject:key];
				
					NSString* item = [splitItems objectAtIndex:0];
					NSString* userName = [splitItems objectAtIndex:1];
			  
					if(GtStringIsNotEmpty(userName))
					{
						NSMutableDictionary* userItems = [[outDictionary objectForKey:userName] retain];
						if(!userItems)
						{
							userItems = [[NSMutableDictionary alloc] init];
							[outDictionary setObject:userItems forKey:userName];
							[userItems setObject:userName forKey:@"userName"];
						}
						
						id data = [userDefaultDictionary objectForKey:key];
						if(data)
						{
							[userItems setObject:data forKey:item];
						}
						GtReleaseWithNil(userItems);
					}
				}
			}
		}
	}
}

+ (void) removeKeysInArray:(NSArray*) keys
{
	NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
	
	for(NSString* key in keys)
	{
		[defaults removeObjectForKey:key];
	}

	[defaults synchronize];
}

+ (BOOL) removeDefaultData:(GtUserLogin*) login
		   outError:(NSError**) error
{
	NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
	[defaults removeObjectForKey:KEY([GtUserLogin emailKey], login)];
	[defaults removeObjectForKey:KEY([GtUserLogin lastLoginKey], login)];
	[defaults removeObjectForKey:KEY([GtUserLogin firstLoginKey], login)];
	[defaults removeObjectForKey:KEY([GtUserLogin loginCountKey], login)];
	[defaults removeObjectForKey:KEY([GtUserLogin authTokenKey], login)];
	[defaults removeObjectForKey:KEY([GtUserLogin userGuidKey], login)];
	[defaults removeObjectForKey:KEY([GtUserLogin userDataKey], login)];
	
	[defaults synchronize];
	
	return YES;
}


+ (BOOL) loadDefaultData:(GtUserLogin*) login
		   outError:(NSError**) error
{
	NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
	
#if DEBUG
	[GtUserDefaults sanityCheckDefaults:defaults];
#endif	  
	
	// this loads the last saved name

	if(GtStringIsEmpty([login userName]))
	{
		login.userName = [defaults stringForKey:[GtUserLogin userNameKey]];
		if(GtStringIsEmpty([login userName]))
		{
			if(error) 
			{
				*error = [[NSError alloc] initWithDomain:GtUserLoginErrorDomain code:GtUserLoginErrorUserNotFound userInfo:nil];
			}
			return NO;
		}
	}
	
	login.lastLogin = [defaults doubleForKey:KEY([GtUserLogin lastLoginKey], login)];
	login.firstLogin = [defaults doubleForKey:KEY([GtUserLogin firstLoginKey], login)];
	login.loginCount = [defaults integerForKey:KEY([GtUserLogin loginCountKey], login)];
	login.authToken = [defaults stringForKey:KEY([GtUserLogin authTokenKey], login)];
	login.email = [defaults	 stringForKey:KEY([GtUserLogin emailKey], login)];
	login.userGuid = [defaults stringForKey:KEY([GtUserLogin userGuidKey], login)];
	login.authTokenLastUpdateTime = [defaults doubleForKey:KEY([GtUserLogin authTokenLastUpdateTimeKey], login)];
	login.userData = GtReturnAutoreleased([[defaults dictionaryForKey:KEY([GtUserLogin userDataKey], login)] mutableCopy] );
	if(GtStringIsNotEmpty(login.userGuid))
	{
		if(error) 
		{
			*error = [[NSError alloc] initWithDomain:GtUserLoginErrorDomain code:GtUserLoginErrorGuidNotFound userInfo:nil];
		}
		return NO;
	}

	return YES;
}

+ (BOOL) loadUserLogin:(GtUserLogin*) login
				outError:(NSError**) error
{
	NSError* internalError = nil;
	NSString* password = nil;
	
	GtAssertNotNil(login);
	
	BOOL ok = [GtUserDefaults loadDefaultData:login outError:&internalError];
	if(!ok)
	{
		if(internalError.code == GtUserLoginErrorGuidNotFound)
		{
			GtReleaseWithNil(internalError);
			ok = YES;
		}
		
		goto Exit;
	}
	
	GtAssertIsValidString(login.userName);

	GtGotoExitOnFail
		([GtKeychain getPasswordForUsername:login.userName
									andServiceName:[NSFileManager appName]
									outPassword:&password
									error:&internalError]);
	login.password = password;
	
	ok = YES;

Exit:	   
	GtReleaseWithNil(password);
	
	if(internalError)
	{
#if DEBUG
		GtLog(@"Warning: Loading user login failed: %@", [internalError description]);
#endif
	
		if(internalError.code == GtKeychainErrorItemPasswordNotFound)
		{
			if(error)
			{
				*error = [[NSError alloc] initWithDomain:GtUserLoginErrorDomain code:GtUserLoginErrorPasswordNotFound userInfo:nil];
			}
		}
		else
		{
			if(error)
			{
				*error = GtRetain(internalError);
			}
		}
	
		GtReleaseWithNil(internalError);
	}
	   
																																																													   
	return ok;
}

+ (BOOL) saveToUserDefaults:(GtUserLogin*) login
			  outError:(NSError**) error
{
	GtAssertNotNil(login);
	GtAssertIsValidString(login.userName);

	NSError* internalError = nil;
	
	NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:login.userName forKey:[GtUserLogin userNameKey]];
	if(login.lastLogin > 0)
	{
		[defaults setObject:login.lastLoginObject	forKey:KEY([GtUserLogin lastLoginKey], login)];
	}
	if(login.firstLogin > 0)
	{
		[defaults setObject:login.firstLoginObject	forKey:KEY([GtUserLogin firstLoginKey], login)];
	}
	if(login.loginCount > 0)
	{
		[defaults setObject:login.loginCountObject	forKey:KEY([GtUserLogin loginCountKey], login)];
	}
	
	if(GtStringIsNotEmpty(login.email))
	{
		[defaults setObject:login.email	 forKey:KEY([GtUserLogin emailKey], login)];
	}
	else
	{
		[defaults removeObjectForKey:KEY([GtUserLogin emailKey], login)];
	}
	
	if(GtStringIsNotEmpty(login.authToken))
	{
		[defaults setObject:login.authToken	 forKey:KEY([GtUserLogin authTokenKey], login)];
	}
	else
	{
		[defaults removeObjectForKey:KEY([GtUserLogin authTokenKey], login)];
	}
	
	if(login.authTokenLastUpdateTimeValue > 0)
	{
		[defaults setObject:login.authTokenLastUpdateTimeObject	 forKey:KEY([GtUserLogin authTokenLastUpdateTimeKey], login)];
	}
	
	if(GtStringIsNotEmpty(login.userGuid))
	{
		[defaults setObject:login.userGuid	forKey:KEY([GtUserLogin userGuidKey], login)];
	}
	else
	{
		[defaults removeObjectForKey:KEY([GtUserLogin userGuidKey], login)];
	}
	
	if(login.userData && login.userData.count > 0)
	{
		[defaults setObject:login.userData	forKey:KEY([GtUserLogin userDataKey], login)];
	}
	else
	{
		[defaults removeObjectForKey:KEY([GtUserLogin userDataKey], login)];
	}
	
#if DEBUG
	[GtUserDefaults sanityCheckDefaults:defaults];
#endif	  

	[defaults synchronize];
	
	if([GtKeychain storeUsername: login.userName
		andPassword:login.password
		forServiceName:[NSFileManager appName]
		updateExisting:YES
		error:&internalError])
	{
		return YES;
	}

#if DEBUG
	GtLog(@"Warning: Saving user login failed: %@",	 [internalError description]);
#endif
	
	if(error)
	{
		*error = GtRetain(internalError);
	}
	
	GtReleaseWithNil(internalError);
							
	return NO;
}

@end

#if UNIT_TEST

@implementation GtUserDefaults (UnitTests)

+ (void) unitTestLoadAllData:(GtUnitTest*) test
{
	NSDictionary* userDefaultData = nil;
	NSArray* keys = nil;

	[GtUserDefaults loadAllData:&keys outData:&userDefaultData];
   
	

	GtReleaseWithNil(keys);
	GtReleaseWithNil(userDefaultData);
}

@end
#endif

#endif
