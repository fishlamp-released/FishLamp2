//
//  FLApplicationDataModel.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/22/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLApplicationDataModel.h"
#import "FLUpgradeDatabaseLengthyTask.h"
#import "FLPerformSelectorOperation.h"

#import "FLUserDefaults.h"

#import "FLApplicationSession.h"
#import "FLKeychain.h"
#import "NSFileManager+FLExtras.h"
#import "NSString+GUID.h"
#import "FLObjectDatabase.h"

@interface FLApplicationDataModel ()
@property (readwrite, strong) FLDatabase* database;
@end


@implementation FLApplicationDataModel

FLSynthesizeSingleton(FLApplicationDataModel);

@synthesize database = _database;

- (id) init {
	if((self = [super init])) {
    }
	return self;
}


+ (FLApplicationDataModel*) applicationDataModel {
    return autorelease_([[[self class] alloc] init]);
}

- (void) dealloc {
	[_database closeDatabase];
	release_(_database);
	super_dealloc_();
}

- (void) closeDatabase {
	[_database closeDatabase];
	FLReleaseWithNil_(_database);
}

- (BOOL) isOpen {
    FLDatabase* database = self.database;
    return database != nil && database.isOpen;
}

- (void) openDatabaseWithOperation:(FLOperation*) operation {

    if(self.isOpen) {
        [self closeDatabase];
    }

#if IOS
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* directory = [paths lastObject];
#else
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString* directory = [paths lastObject];

    FLAssertFailed_v(@"set app support/app name folder");

// TODO(not implemented)

#pragma unused (directory)     
    
#endif
    
    FLObjectDatabase* database = autorelease_([[FLObjectDatabase alloc] initWithName:@"session.sqlite" directory:directory]);

	if([database openDatabase:FLDatabaseOpenFlagsDefault]) {
        [database upgradeDatabase:nil tableUpgraded:nil];
	}
    
    self.database = database;
}

- (FLOperation*) createOpenOperation {
    return [FLPerformSelectorOperation performSelectorOperation:self action:@selector(openDatabaseWithOperation:)];
}

NS_INLINE
BOOL FLIsValidUser(FLUserLogin* userLogin) {
//	if(!userLogin || FLStringIsEmpty(userLogin.userGuid)) {
//		FLCThrowError_([NSError errorWithDomain:FLUserLoginErrorDomain code:FLUserLoginErrorCodeInvalidUserGuid userInfo:nil]);
//	}

	return userLogin && FLStringIsNotEmpty(userLogin.userGuid);
}

- (NSString*) _currentUserGuid
{
	FLApplicationSession* input = [FLApplicationSession applicationSession];
	input.sessionIdValue = 1;
	
	FLApplicationSession* output = [self.database loadObject:input];
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
			FLReleaseWithNil_(password);
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
	FLAssertIsNotNil_(userLogin);
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
	
		[self.database saveObject:userLogin];
	}
}

- (void) didLoadUserLogin:(FLUserLogin*) login 
{
}

- (FLUserLogin*) loadUserLoginWithGuid:(NSString*) guid
{
	FLAssertStringIsNotEmpty_v(guid, nil);

	if(FLStringIsNotEmpty(guid))
	{
		FLUserLogin* login = [FLUserLogin userLogin];
		login.userGuid = guid;
		return [self.database loadObject:login];
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
		return [self.database loadObject:login];
	}

	return nil;
}

- (FLUserLogin*) loadUserLoginWithUserName:(NSString*) name
{
	FLAssertStringIsNotEmpty_v(name, nil);
	
    NSArray* users = nil;
    [self.database loadAllObjectsForTypeWithTable:[FLUserLogin sharedDatabaseTable] outObjects:&users];
    mrc_autorelease_(users);
    
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
		
		[self.database deleteObject:userLogin];
	}
}

- (void) setCurrentUser:(FLUserLogin*) userLogin
{
	if(FLIsValidUser(userLogin))
	{
		FLApplicationSession* session = [FLApplicationSession applicationSession];
		session.sessionIdValue = 1;
		session.userGuid = userLogin.userGuid;
		[self.database saveObject:session];
	}
}


@end




