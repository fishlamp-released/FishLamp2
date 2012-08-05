//
//  FLUserLoginMgr.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/22/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLUserLoginMgr.h"
#import "FLApplicationDataMgr.h"
#import "FLApplicationSession.h"
#import "FLKeychain.h"
#import "NSFileManager+FLExtras.h"
#import "NSString+GUID.h"

@implementation FLUserLoginMgr

NS_INLINE
BOOL FLIsValidUser(FLUserLogin* userLogin)
{
	if(!userLogin || FLStringIsEmpty(userLogin.userGuid))
	{
		FLThrowError([NSError errorWithDomain:FLUserLoginErrorDomain code:FLUserLoginErrorCodeInvalidUserGuid userInfo:nil]);
	}

	return userLogin && FLStringIsNotEmpty(userLogin.userGuid);
}

FLSynthesizeSingleton(FLUserLoginMgr);

- (NSString*) _currentUserGuid
{
	FLApplicationSession* input = [FLApplicationSession applicationSession];
	input.sessionIdValue = 1;
	
	FLApplicationSession* output = [[FLApplicationDataMgr instance].database loadObject:input];
	return output ? output.userGuid : nil;
}

- (void) loadPasswordForUserLogin:(FLUserLogin*) userLogin
{
	if(FLIsValidUser(userLogin))
	{
		userLogin.password = nil;

		if(FLStringIsNotEmpty(userLogin.userName))
		{
			NSString* password = nil;
			if([FLKeychain getPasswordForUsername:userLogin.userGuid
								   andServiceName:[NSFileManager appName]
									  outPassword:&password
											error:nil])
			{
				userLogin.password = password;
				// ok if pw not loaded.
			}
			FLReleaseWithNil(password);
		}
	}
}

- (void) savePasswordForUserLogin:(FLUserLogin*) userLogin
{
	if(FLIsValidUser(userLogin))
	{
		if(FLStringIsNotEmpty(userLogin.password))
		{
			if([FLKeychain storeUsername: userLogin.userGuid
								andPassword:userLogin.password
								forServiceName:[NSFileManager appName]
								updateExisting:YES
								error:nil])
			{
			}
		}
		else
		{
			if([FLKeychain deleteItemForUsername:userLogin.userGuid
				andServiceName:[NSFileManager appName]
				error:nil])
			{
			}
		}
	}
}

- (void) saveUserLogin:(FLUserLogin*) userLogin
{
	FLAssertIsNotNil(userLogin);
	if(userLogin)
	{
		if(FLStringIsEmpty(userLogin.userGuid))
		{
			// the database will error if userName or emailAlready in use.
			userLogin.userGuid = [NSString guidString];
		}
//			if(FLStringIsEmpty(userLogin.userName))
//			{
//				userLogin.userName = userLogin.userGuid;
//			}
//			if(FLStringIsEmpty(userLogin.email))
//			{
//				userLogin.email = userLogin.userGuid;
//			}

		if(FLStringIsEmpty(userLogin.userName))
		{
			userLogin.userName = nil;
		}
		if(FLStringIsEmpty(userLogin.email))
		{
			userLogin.email = nil;
		}
	
		[[FLApplicationDataMgr instance].database saveObject:userLogin];
	}
}

- (void) didLoadUserLogin:(FLUserLogin*) login 
{
}

- (FLUserLogin*) loadUserLoginWithGuid:(NSString*) guid
{
	FLAssertStringIsNotEmpty(guid);

	if(FLStringIsNotEmpty(guid))
	{
		FLUserLogin* login = [FLUserLogin userLogin];
		login.userGuid = guid;
		return [[FLApplicationDataMgr instance].database loadObject:login];
	}
	
	return nil;
}

- (FLUserLogin*) loadLastUserLogin
{
	NSString* currentGuid = [self _currentUserGuid];
	if(FLStringIsNotEmpty(currentGuid))
	{
		FLUserLogin* login = [FLUserLogin userLogin];
		login.userGuid = currentGuid;
		return [[FLApplicationDataMgr instance].database loadObject:login];
	}

	return nil;
}

- (FLUserLogin*) loadUserLoginWithUserName:(NSString*) name
{
	FLAssertStringIsNotEmpty(name);
	
    NSArray* users = nil;
    [[FLApplicationDataMgr instance].database loadAllObjectsForTypeWithTable:[FLUserLogin sharedSqliteTable] outObjects:&users];
    FLAutorelease(users);
    
    if(users)
    {   
        for(FLUserLogin* login in users)
        {
            if(FLStringsAreEqualCaseInsensitive(name, login.userName))
            {
                return login;
            }
        
        }
    }
    
	return nil;
}

- (void) deleteUserLogin:(FLUserLogin*) userLogin
{
	if(FLIsValidUser(userLogin))
	{
		[FLKeychain deleteItemForUsername:userLogin.userGuid
			andServiceName:[NSFileManager appName]
			error:nil];
		
		[[FLApplicationDataMgr instance].database deleteObject:userLogin];
	}
}

- (void) setCurrentUser:(FLUserLogin*) userLogin
{
	if(FLIsValidUser(userLogin))
	{
		FLApplicationSession* session = [FLApplicationSession applicationSession];
		session.sessionIdValue = 1;
		session.userGuid = userLogin.userGuid;
		[[FLApplicationDataMgr instance].database saveObject:session];
	}
}

@end
