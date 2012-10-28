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
#import "FLUpgradeDatabaseLengthyTask.h"
#import "FLApplicationDataVersion.h"
#import "FLApplicationDataModel.h"
#import "FLCacheManager.h"
#import "NSFileManager+FLExtras.h"
#import "NSString+Guid.h"
#import "FLLengthyTaskOperation.h"
#import "FLAction.h"
#import "FLBot.h"
#import "FLBackgroundTaskMgr.h"

@interface FLUserSession ()
- (BOOL) _beginOpeningSession;
- (void) finishUpgradeTasks;
@property (readonly, retain, nonatomic) FLVersionUpgradeLengthyTaskList* upgradeTaskList;
@end

@implementation FLUserSession

FLSynthesizeSingleton(FLUserSession);

@synthesize userLogin = _login;
@synthesize cacheDatabase = _cacheDatabase;
@synthesize documentsDatabase = _documentsDatabase;

@synthesize documentsFolder = _documentsFolder;
@synthesize cacheFolder = _cacheFolder;
@synthesize photoFolder = _photoFolder;
@synthesize photoCacheFolder = _photoCacheFolder;
@synthesize tempFolder = _tempFolder;
@synthesize logFolder = _logFolder;

@synthesize upgradeTaskList = _upgradeTaskList;


- (void) _emptyCache:(id) sender
{
    @synchronized(_cacheDatabase) {
        
        [_cacheDatabase cancelCurrentOperation];
    
        [_cacheDatabase closeDatabase];
        [_cacheDatabase deleteOnDisk];
        [_cacheDatabase openDatabase:FLDatabaseOpenFlagsDefault];

#if IOS        
        [NSFileManager addSkipBackupAttributeToFile:_cacheDatabase.filePath];
#endif        
    }
}

- (void) _appWillResignActive:(id) sender {
	if(_state.isOpening) {
    	_state.isOpening = NO;
    }
    if(_state.upgrading) {
        _state.upgrading = NO;
    }
    
    FLReleaseWithNil(_upgradeTaskList);
}

- (void) _appWillBecomeActive:(id) sender {
	if(!self.isSessionOpen && _state.willOpen) {
        [self _beginOpeningSession];
    }
}

//- (void) _appDidEnterBackground:(id) sender {
//}
//
//- (void) _appWillEnterForeground:(id) sender {
//}

- (void) _appWillTerminate:(id) sender {

}

- (void) registerForEvents
{
    [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(_emptyCache:) 
            name: FLUserSessionEmptyCacheNotification // UIApplicationWillTerminateNotification
            object: [FLCacheManager instance]];

#if IOS

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

//    [[NSNotificationCenter defaultCenter] addObserver:self
//        selector:@selector(_appDidEnterBackground:) 
//        name: UIApplicationDidEnterBackgroundNotification // UIApplicationDidEnterBackgroundNotification
//        object: [UIApplication sharedApplication]];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//        selector:@selector(_appWillEnterForeground:) 
//        name: UIApplicationWillEnterForegroundNotification // UIApplicationWillEnterForegroundNotification
//        object: [UIApplication sharedApplication]];
#endif
}

- (id) init
{
	if((self = [super init]))
	{
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
	
	if(self.isSessionOpen) {
		[[FLLowMemoryHandler defaultHandler] broadcastReleaseMessage];
	}
	 
	@try {
		[_cacheDatabase closeDatabase];
		[_documentsDatabase closeDatabase];

		// wtf to do if db close fails???? 
	}
	@finally {
		[self deleteSessionData];

		FLAssertIsNil_v(_cacheDatabase, nil);
		FLAssertIsNil_v(_documentsDatabase, nil);
		
		_state.open = NO;
		_state.willOpen = NO;
		_state.isOpening = NO;
		
        [self postObservation:@selector(userSessionDidClose:)];
    }
}

- (void) setUserLoggedOut {
    [[FLBackgroundTaskMgr instance] resetAllTasks];

	_login.isAuthenticatedValue = NO;
	[[FLApplicationDataModel instance] saveUserLogin:_login];
    [self postObservation:@selector(userSessionUserDidLogout:)];
	[self closeSession];
}

- (void) _beginLoggingOut {
    [[FLUserSession instance] setUserLoggedOut];
}

- (void) beginLoggingOutUser:(void (^)()) finishedLogout {

    if([[FLBackgroundTaskMgr instance] isExecutingBackgroundTask]) {

        finishedLogout = FLReturnAutoreleased([finishedLogout copy]);

        id<FLProgressViewController> progress = [[self class] createUserLoggingOutProgressViewController];
        [progress setTitle:NSLocalizedString(@"Logging Out…", nil)];
    
        [[FLBackgroundTaskMgr instance] beginCancellingAllTasks:^(id backgroundTaskMgr) {
            
            [self setUserLoggedOut];
            [progress hideProgress];
            if(finishedLogout) {
                finishedLogout();
            }

        } ];
    }
    else {
        [self setUserLoggedOut];
        if(finishedLogout) {
            finishedLogout();
        }
    }
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
		[_cacheDatabase openDatabase:FLDatabaseOpenFlagsDefault];
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
		[_documentsDatabase openDatabase:FLDatabaseOpenFlagsDefault];
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
		
		FLApplicationDataVersion* dataVersion = [[FLApplicationDataModel instance].database loadObject:input];
		
        // TODO: show error on downgrade?
        
		if( (dataVersion == nil) || 
            FLStringIsEmpty(dataVersion.versionString) ||
            !FLStringsAreEqual(dataVersion.versionString, [NSFileManager appVersion]))
        {
			_state.upgrading = YES;
		
			_upgradeTaskList = [[FLVersionUpgradeLengthyTaskList alloc] initWithFromVersion:dataVersion.versionString toVersion:[NSFileManager appVersion]];
		
			if([_cacheDatabase databaseNeedsUpgrade]) {
				[_upgradeTaskList addLengthyTask:[FLUpgradeDatabaseLengthyTask upgradeDatabaseLengthyTask:_cacheDatabase]];
			}

			if([_documentsDatabase databaseNeedsUpgrade]) {
				[_upgradeTaskList addLengthyTask:[FLUpgradeDatabaseLengthyTask upgradeDatabaseLengthyTask:_documentsDatabase]];
			}
            
            [self postObservation:@selector(userSession:appVersionWillChange:) withObject:_upgradeTaskList];

            FLAction* action = [FLAction action];
            action.actionDescription.actionType = FLActionDescriptionTypeUpdate;
            [action addOperation: [FLLengthyTaskOperation lengthyTaskOperation:_upgradeTaskList]];
            action.progressController = [[self class] createVersionUpgradeProgressViewController:_upgradeTaskList];
            [action.progressController setTitle:[NSString stringWithFormat:(NSLocalizedString(@"Updating to Version: %@", nil)), [NSFileManager appVersion]]];

            [action startAction:^(id<FLAsyncResult> result){
                if(action.didSucceed) {
                    [self finishUpgradeTasks];
                }
                else {
                    // TODO: Ok, now what?
                }
            }];
		}
		else {
            [self finishOpeningSession];
		}
	}
	
	return NO;
}

- (void) beginOpeningSession:(FLUserLogin*) userLogin
              wasOpenedBlock:(FLSessionOpenedBlock) wasOpenedBlock
{
	FLAssertIsNotNil_v(wasOpenedBlock, nil);

	[self closeSession];

	FLAssignObject(_login, userLogin);

	if(self.userLogin)
	{
		FLAssert_v(FLStringIsNotEmpty(userLogin.userName), @"invalid userLogin");
	
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

- (void) beginOpeningSessionWithDefaultUser:(FLSessionOpenedBlock) userLoginCompleted {

    [self beginOpeningSession:[self loadDefaultUser]
               wasOpenedBlock:userLoginCompleted];
}

- (void) finishUpgradeTasks
{	
	if(_state.upgrading)
	{
		FLAssertIsNotNil_v(self.userLogin, nil);
		FLAssert_v(_upgradeTaskList != nil, @"not upgrading");
		
		FLApplicationDataVersion* version = [FLApplicationDataVersion applicationDataVersion];
		version.userGuid = self.userLogin.userGuid;
		version.versionString = [NSFileManager appVersion];
		[[FLApplicationDataModel instance].database saveObject:version];

		FLReleaseWithNil(_upgradeTaskList);
		_state.upgrading = NO;

        [self finishOpeningSession];
	}
}

- (void) finishOpeningSession
{
	_state.open = YES;
	_state.willOpen = NO;
	_state.isOpening = NO;

    [self postObservation:@selector(userSessionDidOpen:)];

	if(_openCallback) {
		_openCallback(self.userLogin);
		FLReleaseBlockWithNil(_openCallback);
	}
}

- (BOOL) isAuthenticated
{
	return _login.isAuthenticatedValue;
}

- (FLUserLogin*) loadLastUserLogin
{
	return [[FLApplicationDataModel instance] loadLastUserLogin];
}
   
- (void) dealloc
{
	FLRelease(_openCallback);

	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[self closeSession];
	FLSuperDealloc();
}

- (FLUserLogin*) loadDefaultUser
{
	FLUserLogin* login = [[FLApplicationDataModel instance] loadUserLoginWithGuid:[NSString zeroGuidString]];
    if(!login)
    {
        login = [FLUserLogin userLogin];
        login.userName = NSLocalizedString(@"Guest", nil);
        login.isAuthenticatedValue = YES;
        login.userGuid = [NSString zeroGuidString];
        [[FLApplicationDataModel instance] saveUserLogin:login];
        [[FLApplicationDataModel instance] setCurrentUser:login];
    }
	return login;
}

@end


