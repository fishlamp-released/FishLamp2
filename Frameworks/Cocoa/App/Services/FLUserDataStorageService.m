//
//  FLUserDataStorageService.m
//  FLCore
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
#import "FLAction.h"
#import "FLBackgroundTaskMgr.h"
#import "FLAction.h"
#import "FLObjectDatabase.h"
#import "FLAppInfo.h"

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
@synthesize imageFolder = _imageFolder;
@synthesize imageCacheFolder = _imageCacheFolder;
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

+ (id) userDataStorageService {
    return FLAutorelease([[[self class] alloc] init]);
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
	if(_isOpening) {
    	_isOpening = NO;
    }
    if(_upgrading) {
        _upgrading = NO;
    }
    
    FLReleaseWithNil_(_upgradeTaskList);
}

- (void) _appWillBecomeActive:(id) sender {
	if(!self.isServiceOpen && _willOpen) {
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
	return _open;
}	 
 
- (void) deleteServiceData  {
//    [self removeAppService:self.backgroundTasks];
//    self.backgroundTasks = nil;

    FLReleaseWithNil_(_documentsFolder);
	FLReleaseWithNil_(_cacheFolder);
	FLReleaseWithNil_(_imageFolder);
	FLReleaseWithNil_(_imageCacheFolder);
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

//    [self.backgroundTasks beginClosingService:^(FLFinisher* backgroundTaskMgr) {
//        [self closeService];
//        [progress hideProgress];
//        [asyncTask setFinished];
//    }];
    
	if(self.isServiceOpen) {
		[[FLLowMemoryHandler defaultHandler] broadcastReleaseMessage];
	}
	 
	@try {
//        [self.context userLogin].isAuthenticatedValue = NO;
//        [[FLApplicationDataModel instance] saveUserLogin:[self.context userLogin]];
    
		[_cacheDatabase closeDatabase];
		[_documentsDatabase closeDatabase];

		// wtf to do if db close fails???? 
	}
	@finally {
		[self deleteServiceData];

		FLAssertIsNil_v(_cacheDatabase, nil);
		FLAssertIsNil_v(_documentsDatabase, nil);
		
		_open = NO;
		_willOpen = NO;
		_isOpening = NO;
		
        [super closeService];
        
//        [self postObservation:@selector(userServiceDidClose:)];
    }
}

- (void) initCache {
    
    NSArray* cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* userCacheFolder = [cachePaths objectAtIndex: 0];

#if OSX
    userCacheFolder = [userCacheFolder stringByAppendingPathComponent:[FLAppInfo bundleIdentifier]];
#endif

	if(!_cacheFolder){
		_cacheFolder = [[FLFolder alloc] initWithPath:[userCacheFolder stringByAppendingPathComponent:[self.context userLogin].userGuid]];
		[_cacheFolder createIfNeeded];
	}
	if(!_imageCacheFolder) {
		_imageCacheFolder = [[FLImageFolder alloc] initWithPath:[userCacheFolder stringByAppendingPathComponent:@"photos"]];
		[_imageCacheFolder createIfNeeded];
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
}

- (void) initDocuments {

    NSArray* documentsPaths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString* userDocumentsFolder = [documentsPaths objectAtIndex: 0];

#if OSX
    userDocumentsFolder = [userDocumentsFolder stringByAppendingPathComponent:[FLAppInfo bundleIdentifier]];
#endif
    
	if(!_documentsFolder) {
		_documentsFolder = [[FLFolder alloc] initWithPath:[userDocumentsFolder stringByAppendingPathComponent:[self.context userLogin].userGuid]];
		[_documentsFolder createIfNeeded];
	}
    
// does photo folder make sense on OS X?    
	if(!_imageFolder) {
		_imageFolder = [[FLImageFolder alloc] initWithPath:[userDocumentsFolder stringByAppendingPathComponent:@"photos"]];
		[_imageFolder createIfNeeded];
	}
    
	if(!_documentsDatabase) {
		_documentsDatabase = [[FLObjectDatabase alloc] initWithDefaultName:self.documentsFolder.folderPath];
		[_documentsDatabase openDatabase:FLDatabaseOpenFlagsDefault];
	}    
}

- (void) initServiceObjectsIfNeeded {
    [self initCache];
    [self initDocuments];
}

- (void) finishOpeningService {
	_open = YES;
	_willOpen = NO;
	_isOpening = NO;

//    self.backgroundTasks = [FLBackgroundTaskMgr create];
//    [self addAppService:_backgroundTasks];

//    [self.backgroundTasks startOpeningService:^(id result) {
//        [self postObservation:@selector(userServiceDidOpen:)];
//    }];
}

- (BOOL) runUpgradeTasksIfNeeded {
    
    FLApplicationDataVersion* input = [FLApplicationDataVersion applicationDataVersion];
		input.userGuid = [self.context userLogin].userGuid;
		
    FLApplicationDataVersion* dataVersion = [[FLApplicationDataModel instance].database loadObject:input];
		
    if( (dataVersion == nil) || 
        FLStringIsEmpty(dataVersion.versionString) ||
        !FLStringsAreEqual(dataVersion.versionString, [FLAppInfo appVersion]))
    {
        _upgrading = YES;
    
        _upgradeTaskList = [[FLVersionUpgradeLengthyTaskList alloc] initWithFromVersion:dataVersion.versionString toVersion:[FLAppInfo appVersion]];
        
        if([_cacheDatabase databaseNeedsUpgrade]) {
            [_upgradeTaskList.operations addOperation:[FLUpgradeDatabaseLengthyTask upgradeDatabaseLengthyTask:_cacheDatabase]];
        }

        if([_documentsDatabase databaseNeedsUpgrade]) {
            [_upgradeTaskList.operations addOperation:[FLUpgradeDatabaseLengthyTask upgradeDatabaseLengthyTask:_documentsDatabase]];
        }
        
        [self postObservation:@selector(userDataService:appVersionWillChange:) withObject:_upgradeTaskList];
        
        _upgradeTaskList.progressController = [[self class] createVersionUpgradeProgressViewController];
        [_upgradeTaskList.progressController setTitle:[NSString stringWithFormat:(NSLocalizedString(@"Updating to Version: %@", nil)), [FLAppInfo appVersion]]];

        id result = [_upgradeTaskList runSynchronously];
        
        if([result error]) {
            // TODO: Ok, now what?
        }
        else {
            [self finishUpgradeTasks];
        }
        
        return YES;

    }
    
    return NO;

}

- (BOOL) _beginOpeningService
{
	if([self.context userLogin] && _open == NO && !_isOpening && _willOpen)
	{
		_isOpening = YES;

		[self initServiceObjectsIfNeeded];
		
        if(![self runUpgradeTasksIfNeeded]) {
            [self finishOpeningService];
		}
	}
	
	return NO;
}

- (void) openService {
	[self closeService];
    FLAssert_v(FLStringIsNotEmpty([self.context userLogin].userName), @"invalid userLogin");
    _willOpen = YES;
    _isOpening = NO;
    _open = NO;
    _upgrading = NO;
    [self _beginOpeningService];
    
    [super openService];
}

- (void) finishUpgradeTasks {	
	if(_upgrading) {
		FLAssertIsNotNil_v([self.context userLogin], nil);
		FLAssert_v(_upgradeTaskList != nil, @"not upgrading");
		
		FLApplicationDataVersion* version = [FLApplicationDataVersion applicationDataVersion];
		version.userGuid = [self.context userLogin].userGuid;
		version.versionString = [FLAppInfo appVersion];
		[[FLApplicationDataModel instance].database saveObject:version];

		FLReleaseWithNil_(_upgradeTaskList);
		_upgrading = NO;

        [self finishOpeningService];
	}
}

- (BOOL) isServiceAuthenticated {
	return [self.context userLogin].isAuthenticatedValue;
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

