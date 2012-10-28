//
//	FLUserSession.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/13/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//
#import "FishLampCore.h"

#import "FLUserLogin.h"
#import "FLFolder.h"
#import "FLObjectDatabase.h"

#import "FLLengthyTask.h"
#import "FLLengthyTaskList.h"
#import "FLVersionUpgradeLengthyTaskList.h"
#import "FLObservable.h"

typedef void (^FLSessionOpenedBlock)(FLUserLogin* login); 

@interface FLUserSession : FLObservable {
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
    
	struct {
		unsigned int willOpen: 1;
		unsigned int isOpening: 1;
		unsigned int open: 1;
		unsigned int upgrading: 1;
	} _state;
	
	FLVersionUpgradeLengthyTaskList* _upgradeTaskList;
	FLSessionOpenedBlock _openCallback;
}

FLSingletonProperty(FLUserSession);

@property (readonly, assign) BOOL isSessionOpen;
@property (readonly, assign) BOOL isAuthenticated;

@property (readonly, copy) FLUserLogin* userLogin; // yes, atomic and copy

- (FLUserLogin*) loadLastUserLogin;
- (FLUserLogin*) loadDefaultUser;

- (void) beginOpeningSessionWithDefaultUser:(FLSessionOpenedBlock) userLoginCompleted;

- (void) beginOpeningSession:(FLUserLogin*) userLogin
              wasOpenedBlock:(FLSessionOpenedBlock) block;
              
- (void) finishOpeningSession;
- (void) closeSession;

- (void) beginLoggingOutUser:(void (^)()) finishedLogout;

// caching
@property (readonly, retain, nonatomic) FLObjectDatabase* cacheDatabase;
@property (readonly, retain, nonatomic) FLObjectDatabase* documentsDatabase;

// folders
@property (readonly, retain, nonatomic) FLFolder* documentsFolder;
@property (readonly, retain, nonatomic) FLFolder* cacheFolder;
@property (readonly, retain, nonatomic) FLFolder* photoFolder;
@property (readonly, retain, nonatomic) FLFolder* photoCacheFolder;
@property (readonly, retain, nonatomic) FLFolder* tempFolder;
@property (readonly, retain, nonatomic) FLFolder* logFolder;

- (void) registerForEvents;

@end

@interface FLUserSession (PlatformSpecific)
+ (id) createVersionUpgradeProgressViewController:(FLLengthyTask*) lengthyTask;
+ (id) createUserLoggingOutProgressViewController;
@end

@protocol FLUserSessionObserver <FLObserver>
@optional

- (void) userSessionWillOpen:(FLUserSession*) userSession;
- (void) userSessionDidOpen:(FLUserSession*) userSession;
- (void) userSessionDidClose:(FLUserSession*) userSession;
- (void) userSessionUserDidLogout:(FLUserSession*) userSession;

- (void) userSession:(FLUserSession*) userSession
appVersionWillChange:(FLVersionUpgradeLengthyTaskList*) taskListToAddTo;

@end




