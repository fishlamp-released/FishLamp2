//
//  FLApplicationDataModel.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/22/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//
#if REFACTOR

#import "FLApplicationDataModel.h"
#import "FLUpgradeDatabaseLengthyTask.h"
#import "FLPerformSelectorOperation.h"

#import "FLUserDefaults.h"

#import "FLApplicationSession.h"
#import "FLKeychain.h"
#import "NSFileManager+FLExtras.h"
#import "NSString+GUID.h"
#import "FLObjectDatabase.h"
#import "FLAppInfo.h"

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
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) dealloc {
	[_database closeDatabase];
	FLRelease(_database);
	FLSuperDealloc();
}

- (void) closeDatabase {
	[_database closeDatabase];
	FLReleaseWithNil(_database);
}

- (BOOL) isOpen {
    FLDatabase* database = self.database;
    return database != nil && database.isOpen;
}

- (void) openDatabaseWithOperation:(FLSynchronousOperation*) operation {

    if(self.isOpen) {
        [self closeDatabase];
    }

#if IOS
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* directory = [paths lastObject];
#else
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString* directory = [paths lastObject];

    FLAssertFailedWithComment(@"set app support/app name folder");

// TODO(not implemented)

#pragma unused (directory)     
    
#endif
    
    FLObjectDatabase* database = FLAutorelease([[FLObjectDatabase alloc] initWithName:@"session.sqlite" directory:directory]);

	if([database openDatabase:FLDatabaseOpenFlagsDefault]) {
        [database upgradeDatabase:nil tableUpgraded:nil];
    }
    
    self.database = database;
}

- (FLSynchronousOperation*) createOpenOperation {
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
	
	FLApplicationSession* output = [self.database readObject:input];
	return output ? output.userGuid : nil;
}

- (void) loadPasswordForUserLogin:(FLUserLogin*) userLogin
{
	if(FLIsValidUser(userLogin))
	{
		userLogin.password = nil;

		if(FLStringIsNotEmpty(userLogin.userName)) {
			userLogin.password = [FLKeychain httpPasswordForUserName:userLogin.userName withDomain:[FLAppInfo appName]];
		}
	}
}

- (void) savePasswordForUserLogin:(FLUserLogin*) userLogin {
	if(FLStringIsNotEmpty(userLogin.userName)) {
        [FLKeychain setHttpPassword:userLogin.password forUserName:userLogin.userName withDomain:[FLAppInfo appName]];
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
	
		[self.database writeObject:userLogin];
	}
}

- (void) didLoadUserLogin:(FLUserLogin*) login 
{
}

- (FLUserLogin*) loadUserLoginWithGuid:(NSString*) guid
{
	FLAssertStringIsNotEmptyWithComment(guid, nil);

	if(FLStringIsNotEmpty(guid))
	{
		FLUserLogin* login = [FLUserLogin userLogin];
		login.userGuid = guid;
		return [self.database readObject:login];
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
		return [self.database readObject:login];
	}

	return nil;
}

- (FLUserLogin*) loadUserLoginWithUserName:(NSString*) name
{
	FLAssertStringIsNotEmptyWithComment(name, nil);
	
    NSArray* users = nil;
    [self.database loadAllObjectsForTypeWithTable:[FLUserLogin sharedDatabaseTable] outObjects:&users];
    FLAutoreleaseObject(users);
    
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

- (void) deleteUserLogin:(FLUserLogin*) userLogin {
	if(FLIsValidUser(userLogin)){
		[FLKeychain removeHttpPasswordForUserName:userLogin.userName withDomain:[FLAppInfo appName]];
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
		[self.database writeObject:session];
	}
}


@end

#endif