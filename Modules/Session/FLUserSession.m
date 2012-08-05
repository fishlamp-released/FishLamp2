//
//	FLUserSession.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/13/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLUserSession.h"
#import "FLFolder.h"
#import "FLLowMemoryHandler.h"
#import "FLSqliteDatabaseVersioner.h"
#import "FLSqliteDatabaseUpgrader.h"
#import "FLUserLoginMgr.h"
#import "FLApplicationDataVersion.h"
#import "FLApplicationDataMgr.h"
#import "FLCacheManager.h"
#import "NSFileManager+FLExtras.h"
#import "NSString+Guid.h"

NSString* const FLUserSessionOpenedNotification	 		= @"FLUserSessionOpenedNotification";
NSString* const FLUserSessionClosedNotification	 		= @"FLUserSessionClosedNotification";
NSString* const FLUserSessionUserLoggedOutNotification	= @"FLUserSessionUserLoggedOutNotification";
NSString* const FLUserSessionAppVersionChangedNotification			= @"FLUserSessionAppVersionChangedNotification";
//NSString* const FLUserSessionWillOpenSessionNotification			= @"FLUserSessionWillOpenSessionNotification";

NSString* const FLUserSessionDidBecomeActiveNotification = @"FLUserSessionDidBecomeActiveNotification";
NSString* const FLUserSessionWillResignActiveNotification = @"FLUserSessionWillResignActiveNotification";
NSString* const FLUserSessionDidEnterBackgroundNotification = @"FLUserSessionDidEnterBackgroundNotification";
NSString* const FLUserSessionWillEnterForegroundNotification = @"FLUserSessionWillEnterForegroundNotification";

NSString* const FLAuthenticationErrorDomain	 = @"FLAuthenticationErrorDomain";

@interface FLUserSession ()
- (BOOL) _beginOpeningSession;
@end

@implementation FLUserSession

FLSynthesizeSingleton(FLUserSession);

@synthesize userLogin = _login;
@synthesize cacheDatabase = _cacheDatabase;
@synthesize documentsDatabase = _documentsDatabase;
@synthesize delegate = _delegate;

@synthesize documentsFolder = _documentsFolder;
@synthesize cacheFolder = _cacheFolder;
@synthesize photoFolder = _photoFolder;
@synthesize photoCacheFolder = _photoCacheFolder;
@synthesize tempFolder = _tempFolder;
@synthesize logFolder = _logFolder;

@synthesize upgradeTaskList = _upgradeTaskList;
@synthesize lastActivateTime = _lastActivateTime;

- (void) _deactivate:(NSString*) eventToSend
{
	FLReleaseWithNil(_upgradeTaskList);
	FLReleaseWithNil(_resumeEventToSendAfterOpen);
	_state.isOpening = NO;
	_state.upgrading = NO;
	
	[[NSNotificationCenter defaultCenter] postNotification:
		[NSNotification notificationWithName:eventToSend object:[FLUserSession instance]]];
}

- (void) _activate:(NSString*) eventToSend
{
    FLAssignObject(_lastActivateTime, [NSDate date]);
		
	if(self.isSessionOpen)
	{
		[[NSNotificationCenter defaultCenter] postNotification:
			[NSNotification notificationWithName:eventToSend object:[FLUserSession instance]]];
	}
	else
	{
		FLAssignObject(_resumeEventToSendAfterOpen, eventToSend);
		[self _beginOpeningSession];
	}
}

- (void) _appWillTerminate:(id) sender
{
//	[self closeSession]
}

- (void) _appWillResignActive:(id) sender
{
	[self _deactivate:FLUserSessionWillResignActiveNotification];
}

- (void) _appWillBecomeActive:(id) sender
{
	[self _activate:FLUserSessionDidBecomeActiveNotification];
}

- (void) _appDidEnterBackground:(id) sender
{
	[self _deactivate:FLUserSessionDidEnterBackgroundNotification];
}

- (void) _appWillEnterForeground:(id) sender
{
	[self _activate:FLUserSessionWillEnterForegroundNotification];
}

- (void) _emptyCache:(id) sender
{
    @synchronized(_cacheDatabase) {
        
        [_cacheDatabase cancelCurrentOperation];
    
        [_cacheDatabase closeDatabase];
        [_cacheDatabase deleteOnDisk];
        [_cacheDatabase openDatabase:FLSqliteDatabaseOpenFlagsDefault];

#if IOS        
        [NSFileManager addSkipBackupAttributeToFile:_cacheDatabase.filePath];
#endif        
    }
}

- (void) _registerEvents
{
#if IOS	
    [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(_emptyCache:) 
            name: FLUserSessionEmptyCacheNotification // UIApplicationWillTerminateNotification
            object: [FLCacheManager instance]];

    [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(_appWillTerminate:) 
            name: UIApplicationWillTerminateNotification // UIApplicationWillTerminateNotification
            object: [UIApplication sharedApplication]];

    [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(_appWillBecomeActive:) 
            name: UIApplicationDidBecomeActiveNotification // UIApplicationDidBecomeActiveNotification
            object: [UIApplication sharedApplication]];

    [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(_appWillResignActive:) 
            name: UIApplicationWillResignActiveNotification // UIApplicationWillResignActiveNotification
            object: [UIApplication sharedApplication]];

    [[NSNotificationCenter defaultCenter] addObserver:self
        selector:@selector(_appDidEnterBackground:) 
        name: UIApplicationDidEnterBackgroundNotification // UIApplicationDidEnterBackgroundNotification
        object: [UIApplication sharedApplication]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
        selector:@selector(_appWillEnterForeground:) 
        name: UIApplicationWillEnterForegroundNotification // UIApplicationWillEnterForegroundNotification
        object: [UIApplication sharedApplication]];
#endif			

    [[FLBackgroundTaskMgr instance] addDelegate:self];
}

- (id) init
{
	if((self = [super init]))
	{
        [self performSelectorOnMainThread:@selector(_registerEvents) withObject:nil waitUntilDone:NO];
	}

	return self;
}



- (BOOL) isSessionOpen
{
	return _state.open;
}	 
 
- (void) deleteSessionData 
{
	FLReleaseWithNil(_login);
	FLReleaseWithNil(_documentsFolder);
	FLReleaseWithNil(_cacheFolder);
	FLReleaseWithNil(_photoFolder);
	FLReleaseWithNil(_photoCacheFolder);
	FLReleaseWithNil(_tempFolder);
	FLReleaseWithNil(_logFolder);

	FLReleaseWithNil(_cacheDatabase);
	FLReleaseWithNil(_documentsDatabase);
} 
 
- (void) closeSession
{
	FLReleaseWithNil(_upgradeTaskList);
	FLReleaseWithNil(_resumeEventToSendAfterOpen);

	if(self.isSessionOpen)
	{
		[[FLLowMemoryHandler defaultHandler] broadcastReleaseMessage];
	}
	 
	@try
	{
		[_cacheDatabase closeDatabase];
		[_documentsDatabase closeDatabase];

		// wtf to do if db close fails???? 
	}
	@finally
	{
		[self deleteSessionData];

		FLAssertIsNil(_cacheDatabase);
		FLAssertIsNil(_documentsDatabase);
		
		_state.open = NO;
		_state.willOpen = NO;
		_state.isOpening = NO;
		
		[[NSNotificationCenter defaultCenter] postNotification:
			[NSNotification notificationWithName:FLUserSessionClosedNotification object:[FLUserSession instance]]];

		[_delegate userSessionDidClose:self];
    }
}

- (void) setUserLoggedOut
{
	_login.isAuthenticatedValue = NO;
	[[FLUserLoginMgr instance] saveUserLogin:_login];

	[[NSNotificationCenter defaultCenter] postNotification:
		[NSNotification notificationWithName:FLUserSessionUserLoggedOutNotification object:[FLUserSession instance]]];
	
	[_delegate userSessionUserDidLogout:self];
	
	[self closeSession];
}

- (void) _initSessionObjectsIfNeeded {
    NSArray* cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* userCacheFolder = [cachePaths objectAtIndex: 0];

	if(!_cacheFolder){
		_cacheFolder = [[FLFolder alloc] initWithPath:[userCacheFolder stringByAppendingPathComponent:self.userLogin.userGuid]];
		[_cacheFolder createIfNeeded];
	}
	if(!_photoCacheFolder) {
		_photoCacheFolder = [[FLFolder alloc] initWithPath:[userCacheFolder stringByAppendingPathComponent:@"photos"]];
		[_photoCacheFolder createIfNeeded];
	}
	if(!_tempFolder) {
		_tempFolder = [[FLFolder alloc] initWithPath:[userCacheFolder stringByAppendingPathComponent:@"temp"]];
		[_tempFolder createIfNeeded];
	}
	if(!_logFolder) {
		_logFolder = [[FLFolder alloc] initWithPath:[userCacheFolder stringByAppendingPathComponent:@"logs"]];
		[_logFolder createIfNeeded];
	}

	if(!_cacheDatabase) {
		_cacheDatabase = [[FLObjectDatabase alloc] initWithDefaultName:self.cacheFolder.folderPath];
		[_cacheDatabase openDatabase:FLSqliteDatabaseOpenFlagsDefault];
#if IOS        
        [NSFileManager addSkipBackupAttributeToFile:_cacheDatabase.filePath];
#endif        
	}


#if IOS    
    NSArray* documentsPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* userDocumentsFolder = [documentsPaths objectAtIndex: 0];
    
	if(!_documentsFolder) {
		_documentsFolder = [[FLFolder alloc] initWithPath:[userDocumentsFolder stringByAppendingPathComponent:self.userLogin.userGuid]];
		[_documentsFolder createIfNeeded];
	}
	if(!_photoFolder) {
		_photoFolder = [[FLFolder alloc] initWithPath:[userDocumentsFolder stringByAppendingPathComponent:@"photos"]];
		[_photoFolder createIfNeeded];
	}

#else 
    // TODO: for mac 
    // make folder in application support.
    
    
    // Photo folder doesn't make sense on mac. Consider.

#endif        

	if(!_documentsDatabase) {
		_documentsDatabase = [[FLObjectDatabase alloc] initWithDefaultName:self.documentsFolder.folderPath];
		[_documentsDatabase openDatabase:FLSqliteDatabaseOpenFlagsDefault];
	}
}

- (BOOL) _beginOpeningSession
{
	if(_login && _state.open == NO && !_state.isOpening && _state.willOpen)
	{
		_state.isOpening = YES;

		[self _initSessionObjectsIfNeeded];
		
		FLApplicationDataVersion* input = [FLApplicationDataVersion applicationDataVersion];
		input.userGuid = self.userLogin.userGuid;
		
		FLApplicationDataVersion* dataVersion = [[FLApplicationDataMgr instance].database loadObject:input];
		
        // TODO: show error on downgrade?
        
		if( (dataVersion == nil) || 
            FLStringIsEmpty(dataVersion.versionString) ||
            !FLStringsAreEqual(dataVersion.versionString, [NSFileManager appVersion]))
        {
			_state.upgrading = YES;
		
			_upgradeTaskList = [[FLVersionUpgradeLengthyTaskList alloc] initWithFromVersion:dataVersion.versionString toVersion:[NSFileManager appVersion]];
		
			if(![[FLSqliteDatabaseVersioner instance] databaseVersionEqualToAppVersion:_cacheDatabase])
			{
				[_upgradeTaskList addLengthyTask:[FLSqliteDatabaseUpgrader sqliteDatabaseUpgrader:_cacheDatabase]];
			}
			if(![[FLSqliteDatabaseVersioner instance] databaseVersionEqualToAppVersion:_documentsDatabase])
			{
				[_upgradeTaskList addLengthyTask:[FLSqliteDatabaseUpgrader sqliteDatabaseUpgrader:_documentsDatabase]];
			}
			
			[[NSNotificationCenter defaultCenter] postNotification:
				[NSNotification notificationWithName:FLUserSessionAppVersionChangedNotification object:[FLUserSession instance]]];

			FLAssertIsNotNil(_delegate);
			if(_delegate)
			{
				[_delegate userSession:self appVersionWillChange:_upgradeTaskList];
				[_delegate userSession:self performUpgradeTasks:_upgradeTaskList];
			}
		}
		else
		{
			[_delegate userSessionWillOpen:self];
		}
	}
	
	return NO;
}

- (void) beginOpeningSession:(FLUserLogin*) userLogin wasOpenedBlock:(FLSessionOpenedBlock) wasOpenedBlock
{
	FLAssertIsNotNil(wasOpenedBlock);

	[self closeSession];

	FLAssignObject(_login, userLogin);

	if(self.userLogin)
	{
		FLAssert(FLStringIsNotEmpty(userLogin.userName), @"invalid userLogin"); 
	
		FLReleaseBlockWithNil(_openCallback);
		_openCallback = [wasOpenedBlock copy];
		_state.willOpen = YES;
		_state.isOpening = NO;
		_state.open = NO;
		_state.upgrading = NO;
		[self _beginOpeningSession];
	}
	else
	{
		if(wasOpenedBlock)
		{
			wasOpenedBlock(nil);
		}
	}
}

- (void) finishUpgradeTasks
{	
	if(_state.upgrading)
	{
		FLAssertIsNotNil(self.userLogin);
		FLAssert(_upgradeTaskList != nil, @"not upgrading");
		
		FLApplicationDataVersion* version = [FLApplicationDataVersion applicationDataVersion];
		version.userGuid = self.userLogin.userGuid;
		version.versionString = [NSFileManager appVersion];
		[[FLApplicationDataMgr instance].database saveObject:version];

		FLReleaseWithNil(_upgradeTaskList);
		_state.upgrading = NO;
		
		[_delegate userSessionWillOpen:self];
	}
}

- (void) finishOpeningSession
{
	_state.open = YES;
	_state.willOpen = NO;
	_state.isOpening = NO;

    FLAssignObject(_lastActivateTime, [NSDate date]);

	[[NSNotificationCenter defaultCenter] postNotification:
		[NSNotification notificationWithName:FLUserSessionOpenedNotification object:[FLUserSession instance]]];

	[_delegate userSessionDidOpen:self];

	if(_resumeEventToSendAfterOpen)
	{
		[[NSNotificationCenter defaultCenter] postNotification:
			[NSNotification notificationWithName:_resumeEventToSendAfterOpen object:[FLUserSession instance]]];
			
		FLReleaseWithNil(_resumeEventToSendAfterOpen);
	}

	if(_openCallback)
	{
		_openCallback(self.userLogin);
		FLReleaseBlockWithNil(_openCallback);
	}
}

- (BOOL) backgroundTaskMgrCanBeginBackgroundTasks:(FLBackgroundTaskMgr*) mgr
{
    return _state.open;
}

- (BOOL) isAuthenticated
{
	return _login.isAuthenticatedValue;
}

- (FLUserLogin*) loadLastUserLogin
{
	return [[FLUserLoginMgr instance] loadLastUserLogin];
}
   
- (void) dealloc
{
    [[FLBackgroundTaskMgr instance] removeDelegate:self];

    FLRelease(_lastActivateTime);
	FLRelease(_resumeEventToSendAfterOpen);
	FLRelease(_openCallback);

	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[self closeSession];
	FLSuperDealloc();
}

- (FLUserLogin*) loadDefaultUser
{
	FLUserLogin* login = [[FLUserLoginMgr instance] loadUserLoginWithGuid:[NSString zeroGuidString]];
    if(!login)
    {
        login = [FLUserLogin userLogin];
        login.userName = NSLocalizedString(@"Guest", nil);
        login.isAuthenticatedValue = YES;
        login.userGuid = [NSString zeroGuidString];
        [[FLUserLoginMgr instance] saveUserLogin:login];
        [[FLUserLoginMgr instance] setCurrentUser:login];
    }
	return login;
}

@end

@implementation FLUserSessionClosedEventListener

- (id) initWithTarget:(id) target action:(SEL) action
{
    if((self = [super initWithTarget:target action:action]))
    {
        [self addObserverForEvent:FLUserSessionClosedNotification object:[FLUserSession instance]];
    }
    
    return self;
}

@end
