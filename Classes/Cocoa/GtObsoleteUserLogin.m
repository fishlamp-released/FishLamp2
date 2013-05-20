//
//	GtUserLogin.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/9/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#if IOS

#import "GtObsoleteUserLogin.h"
#import "GtUserDefaults.h"
#import "NSFileManager+GtExtras.h"
#import "GtKeychain.h"
#import "GtUserLoginMgr.h"
#import "GtKeychain.h"

@implementation GtObsoleteUserLogin

static NSString* FileName = @"users.plist";

+ (NSString*) filePath
{
#if IOS
	NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* filePath = [ [paths objectAtIndex: 0] stringByAppendingPathComponent:FileName];
	return filePath;
#endif

	return nil;
}

+ (BOOL) needsUpgrading
{
	return [[NSFileManager defaultManager] fileExistsAtPath:[GtObsoleteUserLogin filePath]];
}

+ (GtUserLogin*) _loadUserLoginWithUserName:(NSString*) userName 
	userFile:(NSDictionary*) users
{
	if(GtStringIsNotEmpty(userName))
	{
		NSDictionary* userInfo = [users objectForKey:userName];
		
		if(userInfo)
		{
			GtUserLogin* login = [GtUserLogin userLogin];
			login.userName = [userInfo objectForKey:[GtUserLogin userNameKey]];
			login.authToken = [userInfo objectForKey:[GtUserLogin authTokenKey]];
			login.authTokenLastUpdateTime = [userInfo objectForKey:[GtUserLogin authTokenLastUpdateTimeKey]];
			login.email = [userInfo objectForKey:[GtUserLogin emailKey]];
			login.isAuthenticated = [userInfo objectForKey:[GtUserLogin isAuthenticatedKey]];
			login.userGuid = [userInfo objectForKey:[GtUserLogin userGuidKey]];
			NSDictionary* userData = [userInfo objectForKey:@"userData"];
			if(userData)
			{
				login.userValue = [userData objectForKey:@"ROOTGROUPID"];
			}
			
			NSString* pw = nil;
			[GtKeychain getPasswordForUsername:login.userName
				andServiceName:[NSFileManager appName]
				outPassword:&pw
				error:nil];
				
			if(pw)
			{
				login.password = pw;
				GtRelease(pw);
			}
			
			return login;
		}
	}
	
	return nil;
}

+ (void) convertIfNeeded
{
	NSString* filePath = [GtObsoleteUserLogin filePath];
	if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
	{
		@try
		{
			NSDictionary* userList = [[NSDictionary alloc] initWithContentsOfFile:[GtObsoleteUserLogin filePath]];
			
			NSString* currentUser = [userList objectForKey:[GtUserLogin userNameKey]];

			for(NSString* userName in userList)
			{
				if(!GtStringsAreEqual(userName, [GtUserLogin userNameKey]))
				{
					GtUserLogin* login = [GtObsoleteUserLogin _loadUserLoginWithUserName:userName userFile:userList];
					
					[[GtUserLoginMgr instance] saveUserLogin:login];
					[[GtUserLoginMgr instance] savePasswordForUserLogin:login];

					if(GtStringsAreEqual(userName, currentUser))
					{
						[[GtUserLoginMgr instance] setCurrentUser:login];
					}
									
					[GtKeychain deleteItemForUsername:login.userName
						andServiceName:[NSFileManager appName]
						error:nil];
				
				}
			}
		
			[[NSFileManager defaultManager] moveItemAtPath:filePath toPath:[NSString stringWithFormat:@"%@_old", filePath] error:nil];
			
		}
		@catch(NSException* ex)
		{
		
			// what to do here???
		}
	}
}

@end

#endif

/*

@protocol GtUserLoginStorage <NSObject>
- (NSDictionary*) loadUserList;
- (void) saveUserList:(NSDictionary*) dictionary; 
@end

@interface GtOldUserLogin : GtUserLoginBaseClass {
}

+ (void) setUserLoginStorage:(id<GtUserLoginStorage>) storage;

@property (readonly, assign, nonatomic) BOOL canAuthenticate;

+ (GtUserLogin*) userLogin;

//- (BOOL) isSaved;

//- (void) updateStats;

- (void) updateAuthToken:(NSString*) token;

+ (NSString*) lastUserLoginUserName;

@end

@interface GtFileBasedUserLoginMgr : NSObject {

}
GtSingletonProperty(GtFileBasedUserLoginMgr);

- (GtUserLogin*) loadLastUserLogin;

- (GtUserLogin*) loadUserLoginWithUserName:(NSString*) name;

- (void) saveUserLogin:(GtUserLogin*) login;

- (void) deleteUserLogin:(GtUserLogin*) login;

@end


*/


//#define FileName @"users.plist"


/*

@implementation GtUserLogin

static NSLock* s_lock = nil;
static id<GtUserLoginStorage> s_storage = nil;

+ (void) setUserLoginStorage:(id<GtUserLoginStorage>) storage
{
	GtAssignObject(s_storage, nil);
}

+ (void) initialize 
{
	s_lock = [[NSLock alloc] init];
}

+ (GtUserLogin*) userLogin
{
	return GtReturnAutoreleased([[GtUserLogin alloc] init]);
}

- (void) setUserName:(NSString*) login
{
	[super setUserName:[login stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
}

- (void) setPassword:(NSString*) password
{
	[super setPassword:[password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
}


//+ (BOOL) convertToFiles
//{
//	NSDictionary* userDefaultData = nil;
//	NSArray* keys = nil;
//
//	[GtUserDefaults loadAllData:&keys outData:&userDefaultData];
//   
//	BOOL savedItOk = [userDefaultData writeToFile:[GtUserLogin filePath] atomically:YES];
//   
//	if(savedItOk)
//	{
////		  [GtUserDefaults removeKeysInArray:keys];
//	}
//
//	GtReleaseWithNil(keys);
//	GtReleaseWithNil(userDefaultData);
//
//	return savedItOk;		 
//}


//+ (void) loadUsers:(NSDictionary**) outUsers
//{
//	BOOL isFirstTime = ![[NSFileManager defaultManager] fileExistsAtPath:[GtUserLogin filePath]];
//	if(isFirstTime)
//	{
//		[GtUserLogin convertToFiles];
//	}
//	
//	*outUsers = [[NSDictionary alloc] initWithContentsOfFile:[GtUserLogin filePath]];
//}

+ (GtUserLogin*) _loadUserLoginWithUserName:(NSString*) userName 
	userFile:(NSDictionary*) users
{
	GtUserLogin* login = nil;

	if(GtStringIsNotEmpty(userName))
	{
		NSDictionary* userInfo = [users objectForKey:userName];
		
		if(userInfo)
		{
			login = [GtUserLogin userLogin];
			[login setValuesForKeysWithDictionary:userInfo];
			
			if(GtStringIsNotEmpty(login.userName))
			{
				NSString* password = nil;
				if([GtKeychain getPasswordForUsername: login.userName
									   andServiceName:[NSFileManager appName]
										  outPassword:&password
												error:nil])
				{
					login.password = password;
					// ok if pw not loaded.
				}
				else
				{
					login.isAuthenticated = NO;
				}
				GtReleaseWithNil(password);
			}
			
			GtAssert(GtStringsAreEqual(userName, login.userName), @"wrong user name");
		}
	}
	
	return login;
}

+ (GtUserLogin*) loadUserLoginWithUserName:(NSString*) name
{
	NSDictionary* users = nil;
	GtUserLogin* login = nil;

	[s_lock lock];
	@try
	{
		[GtUserLogin loadUsers:&users];
		if(users)
		{
			GtAutorelease(users);
			login = [GtUserLogin _loadUserLoginWithUserName:name userFile:users];
		}
	}
	@finally
	{
		[s_lock unlock];
	}
	
	return login;
}


+ (GtUserLogin*) loadLastUserLogin
{
	GtUserLogin* login = nil;
	NSDictionary* users = nil;

	[s_lock lock];
	@try
	{

		[GtUserLogin loadUsers:&users];
		if(users)
		{
			GtAutorelease(users);
		
			NSString* currentUser = [users objectForKey:[GtUserLogin userNameKey]];
			if(GtStringIsNotEmpty(currentUser))
			{
				login = [GtUserLogin _loadUserLoginWithUserName:currentUser 
					userFile:users];
			}
		}
	}
	@finally
	{
		[s_lock unlock];
	}
	 
	return login;
}

+ (NSString*) lastUserLoginUserName
{
	GtUserLogin* login = [GtUserLogin loadLastUserLogin];
	if(login)
	{
		return GtReturnAutoreleased(GtRetain([login userName]));
	}
	return nil;
}

- (void) deleteUserLogin
{
	[s_lock lock];
	@try
	{
		NSDictionary* file = nil;
		[GtUserLogin loadUsers:&file];
		if(file)
		{
			NSMutableDictionary* usersFile = [file mutableCopy];
			[usersFile removeObjectForKey:self.userName];
			[usersFile writeToFile:[GtUserLogin filePath] atomically:YES];
			GtReleaseWithNil(usersFile);
			GtReleaseWithNil(file); 
		}
	
	}
	@finally
	{
		[s_lock unlock];
	}
}

- (void) saveUserLogin
{
	[s_lock lock];
	@try
	{
		if(GtStringIsNotEmpty(self.userName))
		{
			NSDictionary* usersFile = nil;
			[GtUserLogin loadUsers:&usersFile];
			
			NSMutableDictionary* mutableUsersFile = nil;
			
			if(usersFile)
			{
				NSDictionary* prevUserInfo = [usersFile objectForKey:self.userName];
				if(prevUserInfo)
				{
					NSString* prevGUID = [prevUserInfo objectForKey:[GtUserLogin userGuidKey]];
					GtLogAssert(prevGUID, @"Previous GUID is nil. This shouldn't happend.");
					
					if(prevGUID)
					{
						GtLogAssert(	
							GtStringIsEmpty(self.userGuid) ||
							[self.userGuid isEqualToString:prevGUID],
								 @"Two different UID's for same user name!");

						self.userGuid = prevGUID; 
					}
					
				}
			
				mutableUsersFile = [usersFile mutableCopy];
			}
			
			if(!mutableUsersFile)
			{
				mutableUsersFile = [[NSMutableDictionary alloc] init];
			}
			
			if(GtStringIsEmpty(self.userGuid))
			{
				self.userGuid = [NSString guidString];
			}
			
			[mutableUsersFile setObject:self.userName forKey:[GtUserLogin userNameKey]]; // set current user.
			[mutableUsersFile setObject:[self dictionaryWithValuesForKeys:[[self class] propertyKeys]] forKey:self.userName];
		   
			NSString* password = GtRetain(self.password);
			
			// don't save pw to plist file.
			self.password = nil;
			
			BOOL savedItOk = [mutableUsersFile writeToFile:[GtUserLogin filePath] atomically:YES];
			
			self.password = password;
			
			if(savedItOk && [GtKeychain storeUsername: self.userName
								andPassword:self.password
								forServiceName:[NSFileManager appName]
								updateExisting:YES
								error:nil])
			{
			}
			
			GtReleaseWithNil(password);
			GtReleaseWithNil(mutableUsersFile);
			GtReleaseWithNil(usersFile);	
		} 
	}
	@finally
	{
		[s_lock unlock];
	}
}

- (BOOL) canAuthenticate
{
	return GtStringIsNotEmpty(self.userName) && GtStringIsNotEmpty(self.password);
}

- (BOOL) isSaved
{
   BOOL inFile = NO;

	[s_lock lock];
	@try
	{

		NSDictionary* usersFile = nil;
		[GtUserLogin loadUsers:&usersFile];
		if(usersFile)
		{
			inFile = [usersFile objectForKey:self.userName] != nil;
			GtReleaseWithNil(usersFile);
		}
	}
	@finally
	{
		[s_lock unlock];
	}


	return inFile;
}

//- (void) updateStats
//{
//	NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
//	
//	if(self.firstLogin == 0)
//	{
//		self.firstLogin = now;
//	}
//	self.lastLogin = now;
//	self.loginCount = self.loginCount + 1;
//}

- (void) updateAuthToken:(NSString*) token
{
	self.authToken = token;
	if(GtStringIsNotEmpty(token))
	{
		self.authTokenLastUpdateTime = [NSDate timeIntervalSinceReferenceDate];
	}
	else
	{
		self.authTokenLastUpdateTime = 0;
	}
}

@end

@implementation GtFileUserStorage

static NSString* FileName = @"users.plist";

+ (NSString*) filePath
{
#if IOS
	NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
#else
	NSArray* paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
	
	GtAssertFailed(@"set app support/app name folder");
#endif

	NSString* filePath = [ [paths objectAtIndex: 0] stringByAppendingPathComponent:FileName];
	
	return filePath;
}

- (NSDictionary*) loadUserList
{
	return [[NSDictionary alloc] initWithContentsOfFile:[GtUserLogin filePath]]
}

- (void) saveUserList:(NSDictionary*) dictionary
{
}

@end

*/

