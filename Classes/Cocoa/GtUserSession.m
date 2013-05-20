//
//	GtUserSession.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/13/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtUserSession.h"
#import "GtFolder.h"
#import "GtLowMemoryHandler.h"
#import "GtSqliteDatabaseVersioner.h"
#import "GtSqliteDatabaseUpgrader.h"
#import "GtUserLoginMgr.h"
#import "GtApplicationDataVersion.h"
#import "GtApplicationDataMgr.h"
#import "GtCacheManager.h"
#import "NSFileManager+GtExtras.h"

NSString* const GtUserSessionOpenedNotification	 		= @"GtUserSessionOpenedNotification";
NSString* const GtUserSessionClosedNotification	 		= @"GtUserSessionClosedNotification";
NSString* const GtUserSessionUserLoggedOutNotification	= @"GtUserSessionUserLoggedOutNotification";
NSString* const GtUserSessionAppVersionChangedNotification			= @"GtUserSessionAppVersionChangedNotification";
//NSString* const GtUserSessionWillOpenSessionNotification			= @"GtUserSessionWillOpenSessionNotification";

NSString* const GtUserSessionDidBecomeActiveNotification = @"GtUserSessionDidBecomeActiveNotification";
NSString* const GtUserSessionWillResignActiveNotification = @"GtUserSessionWillResignActiveNotification";
NSString* const GtUserSessionDidEnterBackgroundNotification = @"GtUserSessionDidEnterBackgroundNotification";
NSString* const GtUserSessionWillEnterForegroundNotification = @"GtUserSessionWillEnterForegroundNotification";

NSString* const GtAuthenticationErrorDomain	 = @"GtAuthenticationErrorDomain";

@interface GtUserSession ()
- (BOOL) _beginOpeningSession;
@end

@implementation GtUserSession

GtSynthesizeSingleton(GtUserSession);

@synthesize userLogin = m_login;
@synthesize cacheDatabase = m_cacheDatabase;
@synthesize documentsDatabase = m_documentsDatabase;
@synthesize delegate = m_delegate;

@synthesize documentsFolder = m_documentsFolder;
@synthesize cacheFolder = m_cacheFolder;
@synthesize photoFolder = m_photoFolder;
@synthesize photoCacheFolder = m_photoCacheFolder;
@synthesize tempFolder = m_tempFolder;

@synthesize upgradeTaskList = m_upgradeTaskList;
@synthesize lastActivateTime = m_lastActivateTime;

- (void) _deactivate:(NSString*) eventToSend
{
	GtReleaseWithNil(m_upgradeTaskList);
	GtReleaseWithNil(m_resumeEventToSendAfterOpen);
	m_state.isOpening = NO;
	m_state.upgrading = NO;
	
	[[NSNotificationCenter defaultCenter] postNotification:
		[NSNotification notificationWithName:eventToSend object:[GtUserSession instance]]];
}

- (void) _activate:(NSString*) eventToSend
{
    GtAssignObject(m_lastActivateTime, [NSDate date]);
		
	if(self.isSessionOpen)
	{
		[[NSNotificationCenter defaultCenter] postNotification:
			[NSNotification notificationWithName:eventToSend object:[GtUserSession instance]]];
	}
	else
	{
		GtAssignObject(m_resumeEventToSendAfterOpen, eventToSend);
		[self _beginOpeningSession];
	}
}

- (void) _appWillTerminate:(id) sender
{
//	[self closeSession]
}

- (void) _appWillResignActive:(id) sender
{
	[self _deactivate:GtUserSessionWillResignActiveNotification];
}

- (void) _appWillBecomeActive:(id) sender
{
	[self _activate:GtUserSessionDidBecomeActiveNotification];
}

- (void) _appDidEnterBackground:(id) sender
{
	[self _deactivate:GtUserSessionDidEnterBackgroundNotification];
}

- (void) _appWillEnterForeground:(id) sender
{
	[self _activate:GtUserSessionWillEnterForegroundNotification];
}

- (void) _emptyCache:(id) sender
{
    @synchronized(m_cacheDatabase) {
        
        [m_cacheDatabase cancelCurrentOperation];
    
        [m_cacheDatabase closeDatabase];
        [m_cacheDatabase deleteOnDisk];
        [m_cacheDatabase openDatabase:GtSqliteDatabaseOpenFlagsDefault];

#if IOS        
        [NSFileManager addSkipBackupAttributeToFile:m_cacheDatabase.filePath];
#endif        
    }
}

- (void) _registerEvents
{
#if IOS	
    [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(_emptyCache:) 
            name: GtUserSessionEmptyCacheNotification // UIApplicationWillTerminateNotification
            object: [GtCacheManager instance]];

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

    [[GtBackgroundTaskMgr instance] addDelegate:self];
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
	return m_state.open;
}	 
 
- (void) deleteSessionData 
{
	GtReleaseWithNil(m_login);
	GtReleaseWithNil(m_documentsFolder);
	GtReleaseWithNil(m_cacheFolder);
	GtReleaseWithNil(m_photoFolder);
	GtReleaseWithNil(m_photoCacheFolder);
	GtReleaseWithNil(m_tempFolder);

	GtReleaseWithNil(m_cacheDatabase);
	GtReleaseWithNil(m_documentsDatabase);
} 
 
- (void) closeSession
{
	GtReleaseWithNil(m_upgradeTaskList);
	GtReleaseWithNil(m_resumeEventToSendAfterOpen);

	if(self.isSessionOpen)
	{
		[[GtLowMemoryHandler defaultHandler] broadcastReleaseMessage];
	}
	 
	@try
	{
		[m_cacheDatabase closeDatabase];
		[m_documentsDatabase closeDatabase];

		// wtf to do if db close fails???? 
	}
	@finally
	{
		[self deleteSessionData];

		GtAssertNil(m_cacheDatabase);
		GtAssertNil(m_documentsDatabase);
		
		m_state.open = NO;
		m_state.willOpen = NO;
		m_state.isOpening = NO;
		
		[[NSNotificationCenter defaultCenter] postNotification:
			[NSNotification notificationWithName:GtUserSessionClosedNotification object:[GtUserSession instance]]];

		[m_delegate userSessionDidClose:self];
    }
}

- (void) setUserLoggedOut
{
	m_login.isAuthenticatedValue = NO;
	[[GtUserLoginMgr instance] saveUserLogin:m_login];

	[[NSNotificationCenter defaultCenter] postNotification:
		[NSNotification notificationWithName:GtUserSessionUserLoggedOutNotification object:[GtUserSession instance]]];
	
	[m_delegate userSessionUserDidLogout:self];
	
	[self closeSession];
}

- (void) _initSessionObjectsIfNeeded
{
	if(!m_cacheFolder)
	{
		m_cacheFolder = [[GtFolder alloc] initWithSearchPathDirectory:NSCachesDirectory];
		[m_cacheFolder appendStringToPath:self.userLogin.userGuid]; 
		[m_cacheFolder createIfNeeded];
	}
	if(!m_photoCacheFolder)
	{
		m_photoCacheFolder = [[GtFolder alloc] initWithFullPath:self.cacheFolder.fullPath];
		[m_photoCacheFolder appendStringToPath:@"photos"];
		[m_photoCacheFolder createIfNeeded];
	}
	if(!m_tempFolder)
	{
		m_tempFolder = [[GtFolder alloc] initWithFullPath:self.cacheFolder.fullPath];
		[m_tempFolder appendStringToPath:@"temp"]; 
		[m_tempFolder createIfNeeded];
	}
	if(!m_documentsFolder)
	{
		m_documentsFolder = [[GtFolder alloc] initWithSearchPathDirectory:NSDocumentDirectory];
		[m_documentsFolder appendStringToPath:self.userLogin.userGuid]; 
		[m_documentsFolder createIfNeeded];
	}
	if(!m_photoFolder)
	{
		m_photoFolder = [[GtFolder alloc] initWithFullPath:self.documentsFolder.fullPath];
		[m_photoFolder appendStringToPath:@"photos"];
		[m_photoFolder createIfNeeded];
	}
	if(!m_cacheDatabase)
	{
		m_cacheDatabase = [[GtObjectDatabase alloc] initWithDefaultName:self.cacheFolder.fullPath];
		[m_cacheDatabase openDatabase:GtSqliteDatabaseOpenFlagsDefault];
        
        [NSFileManager addSkipBackupAttributeToFile:m_cacheDatabase.filePath];
	}
	if(!m_documentsDatabase)
	{
		m_documentsDatabase = [[GtObjectDatabase alloc] initWithDefaultName:self.documentsFolder.fullPath];
		[m_documentsDatabase openDatabase:GtSqliteDatabaseOpenFlagsDefault];
	}
}

- (BOOL) _beginOpeningSession
{
	if(m_login && m_state.open == NO && !m_state.isOpening && m_state.willOpen)
	{
		m_state.isOpening = YES;

		[self _initSessionObjectsIfNeeded];
		
		GtApplicationDataVersion* input = [GtApplicationDataVersion applicationDataVersion];
		input.userGuid = self.userLogin.userGuid;
		
		GtApplicationDataVersion* dataVersion = [[GtApplicationDataMgr instance].database loadObject:input];
		
        // TODO: show error on downgrade?
        
		if( (dataVersion == nil) || 
            GtStringIsEmpty(dataVersion.versionString) ||
            !GtStringsAreEqual(dataVersion.versionString, [NSFileManager appVersion]))
        {
			m_state.upgrading = YES;
		
			m_upgradeTaskList = [[GtVersionUpgradeLengthyTaskList alloc] initWithFromVersion:dataVersion.versionString toVersion:[NSFileManager appVersion]];
		
			if(![[GtSqliteDatabaseVersioner instance] databaseVersionEqualToAppVersion:m_cacheDatabase])
			{
				[m_upgradeTaskList addLengthyTask:[GtSqliteDatabaseUpgrader sqliteDatabaseUpgrader:m_cacheDatabase]];
			}
			if(![[GtSqliteDatabaseVersioner instance] databaseVersionEqualToAppVersion:m_documentsDatabase])
			{
				[m_upgradeTaskList addLengthyTask:[GtSqliteDatabaseUpgrader sqliteDatabaseUpgrader:m_documentsDatabase]];
			}
			
			[[NSNotificationCenter defaultCenter] postNotification:
				[NSNotification notificationWithName:GtUserSessionAppVersionChangedNotification object:[GtUserSession instance]]];

			GtAssertNotNil(m_delegate);
			if(m_delegate)
			{
				[m_delegate userSession:self appVersionWillChange:m_upgradeTaskList];
				[m_delegate userSession:self performUpgradeTasks:m_upgradeTaskList];
			}
		}
		else
		{
			[m_delegate userSessionWillOpen:self];
		}
	}
	
	return NO;
}

- (void) beginOpeningSession:(GtUserLogin*) userLogin wasOpenedBlock:(GtSessionOpenedBlock) wasOpenedBlock
{
	GtAssertNotNil(wasOpenedBlock);

	[self closeSession];

	GtAssignObject(m_login, userLogin);

	if(self.userLogin)
	{
		GtAssert(GtStringIsNotEmpty(userLogin.userName), @"invalid userLogin"); 
	
		GtReleaseBlockWithNil(m_openCallback);
		m_openCallback = [wasOpenedBlock copy];
		m_state.willOpen = YES;
		m_state.isOpening = NO;
		m_state.open = NO;
		m_state.upgrading = NO;
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
	if(m_state.upgrading)
	{
		GtAssertNotNil(self.userLogin);
		GtAssert(m_upgradeTaskList != nil, @"not upgrading");
		
		GtApplicationDataVersion* version = [GtApplicationDataVersion applicationDataVersion];
		version.userGuid = self.userLogin.userGuid;
		version.versionString = [NSFileManager appVersion];
		[[GtApplicationDataMgr instance].database saveObject:version];

		GtReleaseWithNil(m_upgradeTaskList);
		m_state.upgrading = NO;
		
		[m_delegate userSessionWillOpen:self];
	}
}

- (void) finishOpeningSession
{
	m_state.open = YES;
	m_state.willOpen = NO;
	m_state.isOpening = NO;

    GtAssignObject(m_lastActivateTime, [NSDate date]);

	[[NSNotificationCenter defaultCenter] postNotification:
		[NSNotification notificationWithName:GtUserSessionOpenedNotification object:[GtUserSession instance]]];

	[m_delegate userSessionDidOpen:self];

	if(m_resumeEventToSendAfterOpen)
	{
		[[NSNotificationCenter defaultCenter] postNotification:
			[NSNotification notificationWithName:m_resumeEventToSendAfterOpen object:[GtUserSession instance]]];
			
		GtReleaseWithNil(m_resumeEventToSendAfterOpen);
	}

	if(m_openCallback)
	{
		m_openCallback(self.userLogin);
		GtReleaseBlockWithNil(m_openCallback);
	}
}

- (BOOL) backgroundTaskMgrCanBeginBackgroundTasks:(GtBackgroundTaskMgr*) mgr
{
    return m_state.open;
}

- (BOOL) isAuthenticated
{
	return m_login.isAuthenticatedValue;
}

- (GtUserLogin*) loadLastUserLogin
{
	return [[GtUserLoginMgr instance] loadLastUserLogin];
}
   
- (void) dealloc
{
    [[GtBackgroundTaskMgr instance] removeDelegate:self];

    GtRelease(m_lastActivateTime);
	GtRelease(m_resumeEventToSendAfterOpen);
	GtRelease(m_openCallback);

	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[self closeSession];
	GtSuperDealloc();
}

- (GtUserLogin*) loadDefaultUser
{
	GtUserLogin* login = [[GtUserLoginMgr instance] loadUserLoginWithGuid:[NSString zeroGuidString]];
    if(!login)
    {
        login = [GtUserLogin userLogin];
        login.userName = NSLocalizedString(@"Guest", nil);
        login.isAuthenticatedValue = YES;
        login.userGuid = [NSString zeroGuidString];
        [[GtUserLoginMgr instance] saveUserLogin:login];
        [[GtUserLoginMgr instance] setCurrentUser:login];
    }
	return login;
}

@end

@implementation GtUserSessionClosedEventListener

- (id) initWithTarget:(id) target action:(SEL) action
{
    if((self = [super initWithTarget:target action:action]))
    {
        [self addObserverForEvent:GtUserSessionClosedNotification object:[GtUserSession instance]];
    }
    
    return self;
}

@end
