//
//	GtUserSession.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/13/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtUserLogin.h"
#import "GtFolder.h"
#import "GtObjectDatabase.h"

#import "GtLengthyTask.h"
#import "GtLengthyTaskList.h"
#import "GtVersionUpgradeLengthyTaskList.h"

#import "GtBackgroundTaskMgr.h"

typedef void (^GtSessionWasOpenedBlock)(GtLengthyTaskList* taskList);

extern NSString* const GtUserSessionAppVersionChangedNotification;
extern NSString* const GtUserSessionOpenedNotification;
extern NSString* const GtUserSessionClosedNotification;

extern NSString* const GtUserSessionWillResignActiveNotification;
extern NSString* const GtUserSessionDidBecomeActiveNotification;
extern NSString* const GtUserSessionDidEnterBackgroundNotification;
extern NSString* const GtUserSessionWillEnterForegroundNotification;

extern NSString* const GtUserSessionUserLoggedOutNotification;

extern NSString* const GtAuthenticationErrorDomain;

typedef enum {
	GtAuthenticationErrorPasswordIncorrect				= -100,
	GtAuthenticationErrorPasswordIncorrectOffline		= -101
} GtAuthenticationErrorDomainCode;

@protocol GtUserSessionDelegate;

typedef void (^GtSessionOpenedBlock)(GtUserLogin* login); 

@interface GtUserSession : NSObject<GtBackgroundTaskMgrDelegate> {
@private
	GtUserLogin* m_login;
	GtObjectDatabase* m_cacheDatabase;
	GtObjectDatabase* m_documentsDatabase;
	GtFolder* m_documentsFolder;
	GtFolder* m_cacheFolder;
	GtFolder* m_photoFolder;
	GtFolder* m_photoCacheFolder;
	GtFolder* m_tempFolder;
	
	struct {
		unsigned int willOpen: 1;
		unsigned int isOpening: 1;
		unsigned int open: 1;
		unsigned int upgrading: 1;
	} m_state;
	
	GtVersionUpgradeLengthyTaskList* m_upgradeTaskList;
	
	id<GtUserSessionDelegate> m_delegate;
	
	GtSessionOpenedBlock m_openCallback;
	NSString* m_resumeEventToSendAfterOpen;
	
	NSDate* m_lastActivateTime; 
}

GtSingletonProperty(GtUserSession);

@property (readonly, retain, nonatomic) NSDate* lastActivateTime; // changes when session changes or user switches app into foreground

@property (readwrite, assign, nonatomic) id<GtUserSessionDelegate> delegate;

@property (readonly, assign) BOOL isSessionOpen;
@property (readonly, assign) BOOL isAuthenticated;

@property (readonly, copy) GtUserLogin* userLogin; // yes, atomic and copy

- (GtUserLogin*) loadLastUserLogin;
- (GtUserLogin*) loadDefaultUser;

- (void) beginOpeningSession:(GtUserLogin*) userLogin wasOpenedBlock:(GtSessionOpenedBlock) block;
- (void) finishOpeningSession;
- (void) closeSession;

- (void) setUserLoggedOut;

- (void) finishUpgradeTasks;
@property (readonly, retain, nonatomic) GtVersionUpgradeLengthyTaskList* upgradeTaskList;

// caching
@property (readonly, retain, nonatomic) GtObjectDatabase* cacheDatabase;
@property (readonly, retain, nonatomic) GtObjectDatabase* documentsDatabase;

// folders
@property (readonly, retain, nonatomic) GtFolder* documentsFolder;
@property (readonly, retain, nonatomic) GtFolder* cacheFolder;
@property (readonly, retain, nonatomic) GtFolder* photoFolder;
@property (readonly, retain, nonatomic) GtFolder* photoCacheFolder;
@property (readonly, retain, nonatomic) GtFolder* tempFolder;

@end

@protocol GtUserSessionDelegate <NSObject>

- (void) userSessionWillOpen:(GtUserSession*) userSession;
- (void) userSessionDidOpen:(GtUserSession*) userSession;
- (void) userSessionDidClose:(GtUserSession*) userSession;
- (void) userSessionUserDidLogout:(GtUserSession*) userSession;

- (void) userSession:(GtUserSession*) userSession appVersionWillChange:(GtVersionUpgradeLengthyTaskList*) taskListToAddTo;

- (void) userSession:(GtUserSession*) userSession performUpgradeTasks:(GtVersionUpgradeLengthyTaskList*) withLengthyTask;
@end

#import "GtNotificationListener.h"

@interface GtUserSessionClosedEventListener : GtNotificationListener
@end
