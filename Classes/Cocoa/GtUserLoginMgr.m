//
//  GtUserLoginMgr.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/22/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtUserLoginMgr.h"
#import "GtApplicationDataMgr.h"
#import "GtApplicationSession.h"
#import "GtKeychain.h"
#import "NSFileManager+GtExtras.h"
#import "NSString+GUID.h"

@implementation GtUserLoginMgr

NS_INLINE
BOOL GtIsValidUser(GtUserLogin* userLogin)
{
	if(!userLogin || GtStringIsEmpty(userLogin.userGuid))
	{
		GtThrowError([NSError errorWithDomain:GtUserLoginErrorDomain code:GtUserLoginErrorCodeInvalidUserGuid userInfo:nil]);
	}

	return userLogin && GtStringIsNotEmpty(userLogin.userGuid);
}

GtSynthesizeSingleton(GtUserLoginMgr);

- (NSString*) _currentUserGuid
{
	GtApplicationSession* input = [GtApplicationSession applicationSession];
	input.sessionIdValue = 1;
	
	GtApplicationSession* output = [[GtApplicationDataMgr instance].database loadObject:input];
	return output ? output.userGuid : nil;
}

- (void) loadPasswordForUserLogin:(GtUserLogin*) userLogin
{
	if(GtIsValidUser(userLogin))
	{
		userLogin.password = nil;

		if(GtStringIsNotEmpty(userLogin.userName))
		{
			NSString* password = nil;
			if([GtKeychain getPasswordForUsername:userLogin.userGuid
								   andServiceName:[NSFileManager appName]
									  outPassword:&password
											error:nil])
			{
				userLogin.password = password;
				// ok if pw not loaded.
			}
			GtReleaseWithNil(password);
		}
	}
}

- (void) savePasswordForUserLogin:(GtUserLogin*) userLogin
{
	if(GtIsValidUser(userLogin))
	{
		if(GtStringIsNotEmpty(userLogin.password))
		{
			if([GtKeychain storeUsername: userLogin.userGuid
								andPassword:userLogin.password
								forServiceName:[NSFileManager appName]
								updateExisting:YES
								error:nil])
			{
			}
		}
		else
		{
			if([GtKeychain deleteItemForUsername:userLogin.userGuid
				andServiceName:[NSFileManager appName]
				error:nil])
			{
			}
		}
	}
}

- (void) saveUserLogin:(GtUserLogin*) userLogin
{
	GtAssertNotNil(userLogin);
	if(userLogin)
	{
		if(GtStringIsEmpty(userLogin.userGuid))
		{
			// the database will error if userName or emailAlready in use.
			userLogin.userGuid = [NSString guidString];
		}
//			if(GtStringIsEmpty(userLogin.userName))
//			{
//				userLogin.userName = userLogin.userGuid;
//			}
//			if(GtStringIsEmpty(userLogin.email))
//			{
//				userLogin.email = userLogin.userGuid;
//			}

		if(GtStringIsEmpty(userLogin.userName))
		{
			userLogin.userName = nil;
		}
		if(GtStringIsEmpty(userLogin.email))
		{
			userLogin.email = nil;
		}
	
		[[GtApplicationDataMgr instance].database saveObject:userLogin];
	}
}

- (void) didLoadUserLogin:(GtUserLogin*) login 
{
}

- (GtUserLogin*) loadUserLoginWithGuid:(NSString*) guid
{
	GtAssertIsValidString(guid);

	if(GtStringIsNotEmpty(guid))
	{
		GtUserLogin* login = [GtUserLogin userLogin];
		login.userGuid = guid;
		return [[GtApplicationDataMgr instance].database loadObject:login];
	}
	
	return nil;
}

- (GtUserLogin*) loadLastUserLogin
{
	NSString* currentGuid = [self _currentUserGuid];
	if(GtStringIsNotEmpty(currentGuid))
	{
		GtUserLogin* login = [GtUserLogin userLogin];
		login.userGuid = currentGuid;
		return [[GtApplicationDataMgr instance].database loadObject:login];
	}

	return nil;
}

- (GtUserLogin*) loadUserLoginWithUserName:(NSString*) name
{
	GtAssertIsValidString(name);
	
    NSArray* users = nil;
    [[GtApplicationDataMgr instance].database loadAllObjectsForTypeWithTable:[GtUserLogin sharedSqliteTable] outObjects:&users];
    GtAutorelease(users);
    
    if(users)
    {   
        for(GtUserLogin* login in users)
        {
            if(GtStringsAreEqualCaseInsensitive(name, login.userName))
            {
                return login;
            }
        
        }
    }
    
	return nil;
}

- (void) deleteUserLogin:(GtUserLogin*) userLogin
{
	if(GtIsValidUser(userLogin))
	{
		[GtKeychain deleteItemForUsername:userLogin.userGuid
			andServiceName:[NSFileManager appName]
			error:nil];
		
		[[GtApplicationDataMgr instance].database deleteObject:userLogin];
	}
}

- (void) setCurrentUser:(GtUserLogin*) userLogin
{
	if(GtIsValidUser(userLogin))
	{
		GtApplicationSession* session = [GtApplicationSession applicationSession];
		session.sessionIdValue = 1;
		session.userGuid = userLogin.userGuid;
		[[GtApplicationDataMgr instance].database saveObject:session];
	}
}

@end
