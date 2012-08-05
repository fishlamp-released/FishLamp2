//
//	FLUserSession.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/13/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//
#import "FishLampCocoa.h"

#import "FLUserLogin.h"
#import "FLFolder.h"
#import "FLObjectDatabase.h"

#import "FLLengthyTask.h"
#import "FLLengthyTaskList.h"
#import "FLVersionUpgradeLengthyTaskList.h"

#import "FLBackgroundTaskMgr.h"

typedef void (^FLSessionWasOpenedBlock)(FLLengthyTaskList* taskList);

extern NSString* const FLUserSessionAppVersionChangedNotification;
extern NSString* const FLUserSessionOpenedNotification;
extern NSString* const FLUserSessionClosedNotification;

extern NSString* const FLUserSessionWillResignActiveNotification;
extern NSString* const FLUserSessionDidBecomeActiveNotification;
extern NSString* const FLUserSessionDidEnterBackgroundNotification;
extern NSString* const FLUserSessionWillEnterForegroundNotification;

extern NSString* const FLUserSessionUserLoggedOutNotification;

extern NSString* const FLAuthenticationErrorDomain;

typedef enum {
	FLAuthenticationErrorPasswordIncorrect				= -100,
	FLAuthenticationErrorPasswordIncorrectOffline		= -101
} FLAuthenticationErrorDomainCode;

@protocol FLUserSessionDelegate;

typedef void (^FLSessionOpenedBlock)(FLUserLogin* login); 

@interface FLUserSession : NSObject<FLBackgroundTaskMgrDelegate> {
@private
	FLUserLogin* _login;
	FLObjectDatabase* _cacheDatabase;
	FLObjectDatabase* _documentsDatabase;
	FLFolder* _documentsFolder;
	FLFolder* _cacheFolder;
	FLFolder* _photoFolder;
	FLFolder* _photoCacheFolder;
	FLFolder* _tempFolder;
	
	struct {
		unsigned int willOpen: 1;
		unsigned int isOpening: 1;
		unsigned int open: 1;
		unsigned int upgrading: 1;
	} _state;
	
	FLVersionUpgradeLengthyTaskList* _upgradeTaskList;
	
	__unsafe_unretained id<FLUserSessionDelegate> _delegate;
	
	FLSessionOpenedBlock _openCallback;
	NSString* _resumeEventToSendAfterOpen;
	
	NSDate* _lastActivateTime; 
}

FLSingletonProperty(FLUserSession);

@property (readonly, retain, nonatomic) NSDate* lastActivateTime; // changes when session changes or user switches app into foreground

@property (readwrite, assign, nonatomic) id<FLUserSessionDelegate> delegate;

@property (readonly, assign) BOOL isSessionOpen;
@property (readonly, assign) BOOL isAuthenticated;

@property (readonly, copy) FLUserLogin* userLogin; // yes, atomic and copy

- (FLUserLogin*) loadLastUserLogin;
- (FLUserLogin*) loadDefaultUser;

- (void) beginOpeningSession:(FLUserLogin*) userLogin wasOpenedBlock:(FLSessionOpenedBlock) block;
- (void) finishOpeningSession;
- (void) closeSession;

- (void) setUserLoggedOut;

- (void) finishUpgradeTasks;
@property (readonly, retain, nonatomic) FLVersionUpgradeLengthyTaskList* upgradeTaskList;

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

@end

@protocol FLUserSessionDelegate <NSObject>

- (void) userSessionWillOpen:(FLUserSession*) userSession;
- (void) userSessionDidOpen:(FLUserSession*) userSession;
- (void) userSessionDidClose:(FLUserSession*) userSession;
- (void) userSessionUserDidLogout:(FLUserSession*) userSession;

- (void) userSession:(FLUserSession*) userSession appVersionWillChange:(FLVersionUpgradeLengthyTaskList*) taskListToAddTo;

- (void) userSession:(FLUserSession*) userSession performUpgradeTasks:(FLVersionUpgradeLengthyTaskList*) withLengthyTask;
@end

#import "FLNotificationListener.h"

@interface FLUserSessionClosedEventListener : FLNotificationListener
@end
