//
//	FLUserDefaults.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/13/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//
#if 0

// TODO: get rid of this.
//	  // define an Exit: label at the end of your function to use this
#if DEBUG
	#define FLGotoExitOnFail(__OK__) if(!(__OK__)) { \
		FLDebugLog(@"Condition Failed, jumped to Exit label: %s", #__OK__); \
		FLLogStackTrace(); \
		goto Exit; } 
#else
	
//	  // define an Exit: label at the end of your function to use this
	#define FLGotoExitOnFail(__OK__) if(!(__OK__)) goto Exit 
#endif

#import "FLUserDefaults.h"
#import "FLKeychain.h"
#import "NSFileManager+FLExtras.h"
#import "FLStringUtils.h"

NSString* FLUserLoginErrorDomain = @"FLUserLoginErrorDomain";

#define KEY(__key__, __login__) [NSString stringWithFormat:@"%@.%@", __key__, __login__.userName]

@implementation FLUserDefaults

+ (BOOL) userExists:(FLUserLogin*) login
{
	return FLStringIsNotEmpty([[NSUserDefaults standardUserDefaults] stringForKey:KEY([FLUserLogin userGuidKey], login)]);
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
//			  FLDebugLog(FLDebugKeychain, @"current user is: %@", [dictionary objectForKey:key]);
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
			
			if(!FLStringIsEmpty(innerGuid) && [innerGuid isEqualToString:outerGuid])
			{
				FLDebugLog(@"Duplicate guids!!!!!\n %@ and %@ share:\n\t%@", [guids objectAtIndex:i], [guids objectAtIndex:j], [dictionary objectForKey:[guids objectAtIndex:j]]); 
			}
		}
	}

	FLReleaseWithNil_(guids);

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

//[defaults removeObjectForKey:KEY([FLUserLogin emailKey], login)];
//[defaults removeObjectForKey:KEY([FLUserLogin lastLoginKey], login)];
//[defaults removeObjectForKey:KEY([FLUserLogin firstLoginKey], login)];
//[defaults removeObjectForKey:KEY([FLUserLogin loginCountKey], login)];
//[defaults removeObjectForKey:KEY([FLUserLogin authTokenKey], login)];
//[defaults removeObjectForKey:KEY([FLUserLogin userGuidKey], login)];
 

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
			  
					if(FLStringIsNotEmpty(userName))
					{
						NSMutableDictionary* userItems = retain_([outDictionary objectForKey:userName]);
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
						FLReleaseWithNil_(userItems);
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

+ (BOOL) removeDefaultData:(FLUserLogin*) login
		   outError:(NSError**) error
{
	NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
	[defaults removeObjectForKey:KEY([FLUserLogin emailKey], login)];
	[defaults removeObjectForKey:KEY([FLUserLogin lastLoginKey], login)];
	[defaults removeObjectForKey:KEY([FLUserLogin firstLoginKey], login)];
	[defaults removeObjectForKey:KEY([FLUserLogin loginCountKey], login)];
	[defaults removeObjectForKey:KEY([FLUserLogin authTokenKey], login)];
	[defaults removeObjectForKey:KEY([FLUserLogin userGuidKey], login)];
	[defaults removeObjectForKey:KEY([FLUserLogin userDataKey], login)];
	
	[defaults synchronize];
	
	return YES;
}


+ (BOOL) loadDefaultData:(FLUserLogin*) login
		   outError:(NSError**) error
{
	NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
	
#if DEBUG
	[FLUserDefaults sanityCheckDefaults:defaults];
#endif	  
	
	// this loads the last saved name

	if(FLStringIsEmpty([login userName]))
	{
		login.userName = [defaults stringForKey:[FLUserLogin userNameKey]];
		if(FLStringIsEmpty([login userName]))
		{
			if(error) 
			{
				*error = [[NSError alloc] initWithDomain:FLUserLoginErrorDomain code:FLUserLoginErrorUserNotFound userInfo:nil];
			}
			return NO;
		}
	}
	
	login.lastLogin = [defaults doubleForKey:KEY([FLUserLogin lastLoginKey], login)];
	login.firstLogin = [defaults doubleForKey:KEY([FLUserLogin firstLoginKey], login)];
	login.loginCount = [defaults integerForKey:KEY([FLUserLogin loginCountKey], login)];
	login.authToken = [defaults stringForKey:KEY([FLUserLogin authTokenKey], login)];
	login.email = [defaults	 stringForKey:KEY([FLUserLogin emailKey], login)];
	login.userGuid = [defaults stringForKey:KEY([FLUserLogin userGuidKey], login)];
	login.authTokenLastUpdateTime = [defaults doubleForKey:KEY([FLUserLogin authTokenLastUpdateTimeKey], login)];
	login.userData = autorelease_([[defaults dictionaryForKey:KEY([FLUserLogin userDataKey], login)] mutableCopy] );
	if(FLStringIsNotEmpty(login.userGuid))
	{
		if(error) 
		{
			*error = [[NSError alloc] initWithDomain:FLUserLoginErrorDomain code:FLUserLoginErrorGuidNotFound userInfo:nil];
		}
		return NO;
	}

	return YES;
}

+ (BOOL) loadUserLogin:(FLUserLogin*) login
				outError:(NSError**) error
{
	NSError* internalError = nil;
	NSString* password = nil;
	
	FLAssertIsNotNil_(login);
	
	BOOL ok = [FLUserDefaults loadDefaultData:login outError:&internalError];
	if(!ok)
	{
		if(internalError.code == FLUserLoginErrorGuidNotFound)
		{
			FLReleaseWithNil_(internalError);
			ok = YES;
		}
		
		goto Exit;
	}
	
	FLAssertStringIsNotEmpty_(login.userName);

	FLGotoExitOnFail
		([FLKeychain getPasswordForUsername:login.userName
									andServiceName:[NSFileManager appName]
									outPassword:&password
									error:&internalError]);
	login.password = password;
	
	ok = YES;

Exit:	   
	FLReleaseWithNil_(password);
	
	if(internalError)
	{
#if DEBUG
		FLDebugLog(@"Warning: Loading user login failed: %@", [internalError description]);
#endif
	
		if(internalError.code == FLKeychainErrorItemPasswordNotFound)
		{
			if(error)
			{
				*error = [[NSError alloc] initWithDomain:FLUserLoginErrorDomain code:FLUserLoginErrorPasswordNotFound userInfo:nil];
			}
		}
		else
		{
			if(error)
			{
				*error = retain_(internalError);
			}
		}
	
		FLReleaseWithNil_(internalError);
	}
	   
																																																													   
	return ok;
}

+ (BOOL) saveToUserDefaults:(FLUserLogin*) login
			  outError:(NSError**) error
{
	FLAssertIsNotNil_(login);
	FLAssertStringIsNotEmpty_(login.userName);

	NSError* internalError = nil;
	
	NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:login.userName forKey:[FLUserLogin userNameKey]];
	if(login.lastLogin > 0)
	{
		[defaults setObject:login.lastLoginObject	forKey:KEY([FLUserLogin lastLoginKey], login)];
	}
	if(login.firstLogin > 0)
	{
		[defaults setObject:login.firstLoginObject	forKey:KEY([FLUserLogin firstLoginKey], login)];
	}
	if(login.loginCount > 0)
	{
		[defaults setObject:login.loginCountObject	forKey:KEY([FLUserLogin loginCountKey], login)];
	}
	
	if(FLStringIsNotEmpty(login.email))
	{
		[defaults setObject:login.email	 forKey:KEY([FLUserLogin emailKey], login)];
	}
	else
	{
		[defaults removeObjectForKey:KEY([FLUserLogin emailKey], login)];
	}
	
	if(FLStringIsNotEmpty(login.authToken))
	{
		[defaults setObject:login.authToken	 forKey:KEY([FLUserLogin authTokenKey], login)];
	}
	else
	{
		[defaults removeObjectForKey:KEY([FLUserLogin authTokenKey], login)];
	}
	
	if(login.authTokenLastUpdateTimeValue > 0)
	{
		[defaults setObject:login.authTokenLastUpdateTimeObject	 forKey:KEY([FLUserLogin authTokenLastUpdateTimeKey], login)];
	}
	
	if(FLStringIsNotEmpty(login.userGuid))
	{
		[defaults setObject:login.userGuid	forKey:KEY([FLUserLogin userGuidKey], login)];
	}
	else
	{
		[defaults removeObjectForKey:KEY([FLUserLogin userGuidKey], login)];
	}
	
	if(login.userData && login.userData.count > 0)
	{
		[defaults setObject:login.userData	forKey:KEY([FLUserLogin userDataKey], login)];
	}
	else
	{
		[defaults removeObjectForKey:KEY([FLUserLogin userDataKey], login)];
	}
	
#if DEBUG
	[FLUserDefaults sanityCheckDefaults:defaults];
#endif	  

	[defaults synchronize];
	
	if([FLKeychain storeUsername: login.userName
		andPassword:login.password
		forServiceName:[NSFileManager appName]
		updateExisting:YES
		error:&internalError])
	{
		return YES;
	}

#if DEBUG
	FLDebugLog(@"Warning: Saving user login failed: %@",	 [internalError description]);
#endif
	
	if(error)
	{
		*error = retain_(internalError);
	}
	
	FLReleaseWithNil_(internalError);
							
	return NO;
}

@end

#if TEST

@interface FLTestUserDefault : FLFrameworkUnitTest
@end

@implementation FLTestUserDefault

- (void) testLoadAllData
{
	NSDictionary* userDefaultData = nil;
	NSArray* keys = nil;
    
    [FLUserDefaults loadAllData:&keys outData:&userDefaultData];
    FLAssertIsNotNil_(keys);
    FLAssertIsNotNil_(userDefaultData);
    
    FLReleaseWithNil_(keys);
	FLReleaseWithNil_(userDefaultData);
}

@end
#endif

#endif
