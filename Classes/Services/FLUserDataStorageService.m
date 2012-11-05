//
//  FLUserDataStorageService.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLUserDataStorageService.h"

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
#import "FLJob.h"
#import "FLBackgroundTaskMgr.h"
#import "FLAction.h"


@interface FLUserDataStorageService ()
- (BOOL) _beginOpeningService;
- (void) finishUpgradeTasks;
- (void) registerForEvents;
@property (readonly, retain, nonatomic) FLVersionUpgradeLengthyTaskList* upgradeTaskList;
@end

@implementation FLUserDataStorageService

@synthesize cacheDatabase = _cacheDatabase;
@synthesize documentsDatabase = _documentsDatabase;
@synthesize documentsFolder = _documentsFolder;
@synthesize cacheFolder = _cacheFolder;
@synthesize photoFolder = _photoFolder;
@synthesize photoCacheFolder = _photoCacheFolder;
@synthesize tempFolder = _tempFolder;
@synthesize logFolder = _logFolder;
@synthesize upgradeTaskList = _upgradeTaskList;

- (id) init {
    self = [super init];
	if(self) {   
        [self registerForEvents];
    }

	return self;
}

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
    
    FLReleaseWithNil_(_upgradeTaskList);
}

- (void) _appWillBecomeActive:(id) sender {
	if(!self.isServiceOpen && _state.willOpen) {
        [self _beginOpeningService];
    }
}

- (void) dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];

    super_dealloc_();
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
            name: FLCacheManagerEmptyCacheNotification
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



- (BOOL) isServiceOpen {
	return _state.open;
}	 
 
- (void) deleteServiceData  {
//    [self removeAppService:self.backgroundTasks];
//    self.backgroundTasks = nil;

    FLReleaseWithNil_(_documentsFolder);
	FLReleaseWithNil_(_cacheFolder);
	FLReleaseWithNil_(_photoFolder);
	FLReleaseWithNil_(_photoCacheFolder);
	FLReleaseWithNil_(_tempFolder);
	FLReleaseWithNil_(_logFolder);

	FLReleaseWithNil_(_cacheDatabase);
	FLReleaseWithNil_(_documentsDatabase);
} 
 
- (void) closeService
{
	FLReleaseWithNil_(_upgradeTaskList);
	
//    [self postObservation:@selector(userServiceWillClose:)];

//    id<FLProgressViewController> progress = nil;
    
//    if([self.backgroundTasks isExecutingBackgroundTask]) {
//        progress = [[self class] createUserLoggingOutProgressViewController];
//        [progress setTitle:NSLocalizedString(@"Logging Out…", nil)];
//    }

//    [self.backgroundTasks beginClosingService:^(id<FLResult> backgroundTaskMgr) {
//        [self closeService];
//        [progress hideProgress];
//        [finisher setFinished];
//    }];
    
	if(self.isServiceOpen) {
		[[FLLowMemoryHandler defaultHandler] broadcastReleaseMessage];
	}
	 
	@try {
//        [self.parentService userLogin].isAuthenticatedValue = NO;
//        [[FLApplicationDataModel instance] saveUserLogin:[self.parentService userLogin]];
    
		[_cacheDatabase closeDatabase];
		[_documentsDatabase closeDatabase];

		// wtf to do if db close fails???? 
	}
	@finally {
		[self deleteServiceData];

		FLAssertIsNil_v(_cacheDatabase, nil);
		FLAssertIsNil_v(_documentsDatabase, nil);
		
		_state.open = NO;
		_state.willOpen = NO;
		_state.isOpening = NO;
		
        [super closeService];
        
//        [self postObservation:@selector(userServiceDidClose:)];
    }
}

- (void) _initServiceObjectsIfNeeded {
    NSArray* cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* userCacheFolder = [cachePaths objectAtIndex: 0];

	if(!_cacheFolder){
		_cacheFolder = [[FLFolder alloc] initWithPath:[userCacheFolder stringByAppendingPathComponent:[self.parentService userLogin].userGuid]];
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
		_documentsFolder = [[FLFolder alloc] initWithPath:[userDocumentsFolder stringByAppendingPathComponent:[self.parentService userLogin].userGuid]];
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

- (void) finishOpeningService {
	_state.open = YES;
	_state.willOpen = NO;
	_state.isOpening = NO;

//    self.backgroundTasks = [FLBackgroundTaskMgr create];
//    [self addAppService:_backgroundTasks];

//    [self.backgroundTasks startOpeningService:^(id<FLResult> result) {
//        [self postObservation:@selector(userServiceDidOpen:)];
//    }];
}

- (BOOL) _beginOpeningService
{
	if([self.parentService userLogin] && _state.open == NO && !_state.isOpening && _state.willOpen)
	{
		_state.isOpening = YES;

		[self _initServiceObjectsIfNeeded];
		
		FLApplicationDataVersion* input = [FLApplicationDataVersion applicationDataVersion];
		input.userGuid = [self.parentService userLogin].userGuid;
		
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
            
            [self postObservation:@selector(userDataService:appVersionWillChange:) withObject:_upgradeTaskList];

            FLAction* action = [FLAction action];
            action.actionDescription.actionType = FLActionDescriptionTypeUpdate;
            [action addOperation: [FLLengthyTaskOperation lengthyTaskOperation:_upgradeTaskList]];
            
            action.progressController = [[self class] createVersionUpgradeProgressViewController:_upgradeTaskList];
            [action.progressController setTitle:[NSString stringWithFormat:(NSLocalizedString(@"Updating to Version: %@", nil)), [NSFileManager appVersion]]];

            [[action startAction:^(FLResult result){
                if(action.didSucceed) {
                    [self finishUpgradeTasks];
                }
                else {
                    // TODO: Ok, now what?
                }
            }] waitForResult];
		}
		else {
            [self finishOpeningService];
		}
	}
	
	return NO;
}

- (void) openService {
	[self closeService];
    FLAssert_v(FLStringIsNotEmpty([self.parentService userLogin].userName), @"invalid userLogin");
    _state.willOpen = YES;
    _state.isOpening = NO;
    _state.open = NO;
    _state.upgrading = NO;
    [self _beginOpeningService];
    
    [super openService];
}

- (void) finishUpgradeTasks {	
	if(_state.upgrading) {
		FLAssertIsNotNil_v([self.parentService userLogin], nil);
		FLAssert_v(_upgradeTaskList != nil, @"not upgrading");
		
		FLApplicationDataVersion* version = [FLApplicationDataVersion applicationDataVersion];
		version.userGuid = [self.parentService userLogin].userGuid;
		version.versionString = [NSFileManager appVersion];
		[[FLApplicationDataModel instance].database saveObject:version];

		FLReleaseWithNil_(_upgradeTaskList);
		_state.upgrading = NO;

        [self finishOpeningService];
	}
}

- (BOOL) isServiceAuthenticated {
	return [self.parentService userLogin].isAuthenticatedValue;
}

+ (FLUserLogin*) loadLastUserLogin {
	return [[FLApplicationDataModel instance] loadLastUserLogin];
}

+ (FLUserLogin*) loadDefaultUser {
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

