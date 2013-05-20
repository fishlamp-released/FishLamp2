//
//  GtUserSession.h
//  MyZen
//
//  Created by Mike Fullerton on 12/13/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtSimpleCallback.h"
#import "GtAction.h"
#import "GtUserLogin.h"
#import "GtPhotoFolder.h"
#import "GtFolder.h"
#import "GtDatabaseCache.h"
#import "GtImageCache.h"

extern NSString* const GtUserSessionBeganNotification;
extern NSString* const GtUserSessionUserAuthenticatedNotification;
extern NSString* const GtUserSessionUserLoggedOutNotification;
extern NSString* const GtUserSessionEndedNotification;

@interface GtUserSession : NSObject {
    GtSimpleCallback* m_authenticationCallback;
    GtUserLogin* m_login;
    NSString* m_authenticationToken;
    
    GtPhotoFolder* m_photoFolder;
    GtPhotoFolder* m_photoCacheFolder;
    
    GtFolder* m_documentsFolder;
    GtFolder* m_cacheFolder;
    
    GtDatabaseCache* m_objectDatabase;
    GtImageCache* m_imageCache;
    
    GtObjectDatabase* m_cacheDatabase;
    
// state    
    struct {
        unsigned int isSessionActive:1;
        unsigned int isAuthenticating:1;
        unsigned int isAuthenticated:1;
		unsigned int isDisabled:1;
		unsigned int isFullVersion:1;
    } m_flags;
}

GtSingletonProperty(GtUserSession);

@property (readonly, assign, nonatomic) BOOL isSessionActive;
@property (readonly, assign, nonatomic) BOOL isAuthenticating; 
@property (readonly, assign, nonatomic) BOOL isAuthenticated;
@property (readonly, assign, nonatomic) BOOL isDisabled; // by default set to no
@property (readonly, assign, nonatomic) BOOL isFullVersion; // by default set to YES

@property (readwrite, assign, nonatomic) NSString* authenticationToken;

@property (readonly, assign, nonatomic) NSString* userLogin; // returns current or last userLogin name
@property (readonly, assign, nonatomic) NSString* userGuid;
@property (readwrite, assign, nonatomic) NSString* userPassword;

// folders
@property (readonly, assign, nonatomic) GtFolder* documentsFolder;
@property (readonly, assign, nonatomic) GtFolder* cacheFolder;

// photo folders
@property (readonly, assign, nonatomic) GtPhotoFolder* photoFolder;
@property (readonly, assign, nonatomic) GtPhotoFolder* photoCacheFolder;

// caching
@property (readonly, assign, nonatomic) GtDatabaseCache* objectCache;
@property (readonly, assign, nonatomic) GtImageCache* imageCache;
@property (readonly, assign, nonatomic) GtObjectDatabase* cacheDatabase;

// TODO add user documents database

- (BOOL) createNewUserLogin:(NSString*) userLogin 
                   password:(NSString*) passwordOrNil
                   outError:(NSError**) errorOrNil;

- (BOOL) saveUserLogin:(NSError**) errorOrNil;

- (BOOL) restartSession:(NSError**) errorOrNil;

- (BOOL) startSession:(NSString*) userLogin 
             outError:(NSError**) errorOrNil;

- (BOOL) canAuthenticate;
- (void) beginAuthenticationAction:(GtAction*) authenticationAction
             canLoadAuthenticationTokenFromCache:(BOOL) canLoadFromCache;
- (void) endSession;
- (void) logout;

- (void) showLogoutAlert:(id) sender;

@end

