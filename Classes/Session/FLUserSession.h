//
//	FLUserSession.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/13/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//
#import "FishLampCore.h"
#import "FLUserLogin.h"
#import "FLObjectDatabase.h"
#import "FLFolder.h"
#import "FLVersionUpgradeLengthyTaskList.h"
#import "FLLengthyTask.h"
#import "FLLengthyTaskList.h"
#import "FLVersionUpgradeLengthyTaskList.h"
#import "FLObservable.h"
#import "FLUserService.h"
#import "FLAppService.h"
#import "FLBackgroundTaskMgr.h"

@protocol FLUserSession <FLUserService>
@property (readonly, strong) FLFolder* documentsFolder;
@property (readonly, strong) FLObjectDatabase* documentsDatabase;
@end

@interface FLUserSession : FLAppService<FLUserSession> {
@private
	FLUserLogin* _login;
	FLObjectDatabase* _cacheDatabase;
	FLObjectDatabase* _documentsDatabase;
	FLFolder* _documentsFolder;
	FLFolder* _cacheFolder;
	FLFolder* _photoFolder;
	FLFolder* _photoCacheFolder;
	FLFolder* _tempFolder;
	FLFolder* _logFolder;
    id<FLFinisher> _openFinisher; 
    
	struct {
		unsigned int willOpen: 1;
		unsigned int isOpening: 1;
		unsigned int open: 1;
		unsigned int upgrading: 1;
	} _state;
	
	FLVersionUpgradeLengthyTaskList* _upgradeTaskList;
    FLBackgroundTaskMgr* _backgroundTasks;
}

- (id) initWithUserLogin:(FLUserLogin*) userLogin;

@property (readonly, assign) BOOL isSessionOpen;
@property (readonly, assign) BOOL isAuthenticated;
@property (readonly, strong) FLUserLogin* userLogin;

// caching
@property (readonly, strong) FLObjectDatabase* cacheDatabase;
@property (readonly, strong) FLObjectDatabase* documentsDatabase;

// folders
@property (readonly, strong) FLFolder* documentsFolder;
@property (readonly, strong) FLFolder* cacheFolder;
@property (readonly, strong) FLFolder* photoFolder;
@property (readonly, strong) FLFolder* photoCacheFolder;
@property (readonly, strong) FLFolder* tempFolder;
@property (readonly, strong) FLFolder* logFolder;

+ (FLUserLogin*) loadLastUserLogin;
+ (FLUserLogin*) loadDefaultUser;

// app services
@property (readonly, strong) FLBackgroundTaskMgr* backgroundTasks;

@end

@interface FLUserSession (PlatformSpecific)
+ (id) createVersionUpgradeProgressViewController:(FLLengthyTask*) lengthyTask;
+ (id) createUserLoggingOutProgressViewController;
@end

@protocol FLUserSessionObserver <FLObserver>
@optional

- (void) userSessionWillOpen:(id<FLUserSession>) userSession;
- (void) userSessionDidOpen:(id<FLUserSession>) userSession;
- (void) userSessionWillClose:(id<FLUserSession>) userSession;
- (void) userSessionDidClose:(id<FLUserSession>) userSession;

- (void) userSession:(id<FLUserSession>) userSession
appVersionWillChange:(FLVersionUpgradeLengthyTaskList*) taskListToAddTo;

@end
