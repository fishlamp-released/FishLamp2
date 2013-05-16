//
//  GtUserSession.m
//  MyZen
//
//  Created by Mike Fullerton on 12/13/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtUserSession.h"
#import "GtPhotoFolder.h"
#import "GtDatabaseCache.h"
#import "GtImageCache.h"
#import "GtUserDefaults.h"
#import "GtFileUtilities.h"
#import "GtUserDefaults.h"
#import "GtAlertView.h"
#import "GtCachedAuthenticationToken.h"

@implementation GtUserSession

NSString *const GtUserSessionBeganNotification = @"GtUserSessionBegan";
NSString *const GtUserSessionUserAuthenticatedNotification  = @"GtUserSessionUserAuthenticated";
NSString *const GtUserSessionEndedNotification  = @"GtUserSessionEnded";;
NSString *const GtUserSessionUserLoggedOutNotification  = @"GtUserSessionUserLoggedOut";;

GtSynthesizeSingleton(GtUserSession);

GtSynthesizeString(authenticationToken, setAuthenticationToken);

GtSynthesize(login, setLogin, GtUserLogin, m_login);

GtSynthesizeStructProperty(isAuthenticated, setIsAuthenticated, BOOL, m_flags);
GtSynthesizeStructProperty(isAuthenticating, setIsAuthenticating, BOOL, m_flags);
GtSynthesizeStructProperty(isDisabled, setIsDisabled, BOOL, m_flags);
GtSynthesizeStructProperty(isFullVersion, setIsFullVersion, BOOL, m_flags);
GtSynthesizeStructProperty(isSessionActive, setIsSessionActive, BOOL, m_flags);

GtSynthesize(authCallback, setAuthCallback, GtSimpleCallback, m_authenticationCallback);

- (id) init
{
    if(self = [super init])
    {
    	self.isDisabled = NO;
		self.isFullVersion = YES;
    }
	
    return self;
}

- (void) dealloc
{
    [self endSession];

    GtRelease(m_authenticationCallback);
    GtRelease(m_login);
    GtRelease(m_authenticationToken);
    
    [super dealloc];
}

- (BOOL) restartSession:(NSError**) errorOrNil
{
    return [self startSession:@"" outError:errorOrNil];
}


- (BOOL) startSession:(NSString*) inUserLogin
             outError:(NSError**) errorOrNil
{
    GtAssertNotNil(inUserLogin);

    [self endSession];
    
    GtUserLogin* userLogin = [GtAlloc(GtUserLogin) init];
    userLogin.userName = inUserLogin;

    BOOL loadedOk = [GtUserDefaults loadUserLogin:userLogin outError:errorOrNil];
    
    if(loadedOk)
    {
        self.isSessionActive = YES;
        self.login = userLogin;
        
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:GtUserSessionBeganNotification 
            object:[UIApplication sharedApplication]]];
    }
    
    GtRelease(userLogin);
    
    return loadedOk;
}
       
- (GtPhotoFolder*) photoFolder
{
    if(!m_photoFolder)
    {
        m_photoFolder = [GtAlloc(GtPhotoFolder) initWithFullPath:self.documentsFolder.fullPath];
        [m_photoFolder appendStringToPath:@"photos"];
        [m_photoFolder createIfNeeded];
    }
    
    return m_photoFolder;
}       

- (GtPhotoFolder*) photoCacheFolder
{
    if(!m_photoCacheFolder)
    {
        m_photoCacheFolder = [GtAlloc(GtPhotoFolder) initWithFullPath:self.cacheFolder.fullPath];
        [m_photoCacheFolder appendStringToPath:@"photos"];
        [m_photoCacheFolder createIfNeeded];
    }
    
    return m_photoCacheFolder;
}       

- (GtFolder*) documentsFolder
{
    if(!m_documentsFolder)
    {
        m_documentsFolder = [GtAlloc(GtFolder) initWithSearchPathDirectory:NSDocumentDirectory];
        [m_documentsFolder appendStringToPath:self.userGuid]; 
        [m_documentsFolder createIfNeeded];
    }
    
    return m_documentsFolder;
}       

- (GtFolder*) cacheFolder
{
    if(!m_cacheFolder)
    {
        m_cacheFolder = [GtAlloc(GtFolder) initWithSearchPathDirectory:NSCachesDirectory];
        [m_cacheFolder appendStringToPath:self.userGuid]; 
        [m_cacheFolder createIfNeeded];
    }
    
    return m_cacheFolder;
}       

       
- (void) endSession
{
    if(self.isSessionActive)
    {
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:GtUserSessionEndedNotification 
            object:[UIApplication sharedApplication]]];

        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:GtReleaseObjectsCachedInMemoryNotification 
            object:[UIApplication sharedApplication]]];
    }
     
    self.isSessionActive = NO;
    self.isAuthenticating = NO;
    self.isAuthenticated = NO;
    GtReleaseWithNil(m_login);
    GtReleaseWithNil(m_authenticationToken);
    GtReleaseWithNil(m_photoFolder);
    GtReleaseWithNil(m_photoCacheFolder);
    GtReleaseWithNil(m_documentsFolder);
    GtReleaseWithNil(m_cacheFolder);
    
    [m_cacheDatabase close];

    GtReleaseWithNil(m_objectDatabase);
    GtReleaseWithNil(m_imageCache);
    GtReleaseWithNil(m_cacheDatabase);
}

- (void) logout
{
    if(self.isAuthenticated)
    {
        m_login.password = @"";
        self.authenticationToken = nil;
        [GtUserDefaults saveUserLogin:m_login outError:nil];
        self.isAuthenticated = NO;

        [GtCachedAuthenticationToken deleteFromCache];
            
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:GtUserSessionUserLoggedOutNotification 
            object:[UIApplication sharedApplication]]];
            
        [self endSession];
    }
}

-(void) onLogoutAlert:(GtAlertView*) alert
{
    if(alert.clickedButtonIndex == 1)
	{
		[[GtUserSession instance] logout];
	}
}

- (void) showLogoutAlert:(id) sender
{
	GtAlertView* alert = [GtAlloc(GtAlertView) initWithTitle:@"Are you sure?" 
			message:@"Do you really want to logout?" 
			cancelButtonTitle:@"No" 
            otherButtonTitles:@"Yes", nil];
	[alert setButtonClickedCallback:self action:@selector(onLogoutAlert:)];
	[alert show];
	GtRelease(alert);
}

- (BOOL) canAuthenticate
{
    return [m_login userNameHasValue] && [m_login passwordHasValue];
}

- (NSString*) userPassword
{
    return m_login.password;
}

- (void) setUserPassword:(NSString*) password
{
    m_login.password = [password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString*) userLogin
{
    if(self.isSessionActive)
    {
        return m_login.userName;
    }
    
    GtUserLogin* userLogin = [GtAlloc(GtUserLogin) init];
 
    NSString* outString = nil;
    if([GtUserDefaults loadUserLogin:userLogin outError:nil])
    {
        outString = [[userLogin.userName retain] autorelease];
    }
    GtRelease(userLogin);
    
    return outString;
}

- (void) setUserLogin:(NSString*) userLogin
{
    m_login.userName = [userLogin stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (void) loadUserLogin
{
    [GtUserDefaults loadUserLogin:m_login outError:nil];
}

- (BOOL) createNewUserLogin:(NSString*) userLogin 
                   password:(NSString*) passwordOrNil
                   outError:(NSError**) errorOrNil
{
    GtUserLogin* login = [GtAlloc(GtUserLogin) init];
    login.userName = userLogin;
    login.password = passwordOrNil;
    BOOL savedOk = [GtUserDefaults saveUserLogin:login outError:errorOrNil];
    GtRelease(login);
    return savedOk;
}

- (BOOL) saveUserLogin:(NSError**) errorOrNil
{
#if DEBUG
    if(m_login.userGuidHasValue)
    {
        GtUserLogin* login = [GtAlloc(GtUserLogin) init];
        if([GtUserDefaults loadUserLogin:login outError:nil])
        {
            GtAssert([login.userGuid isEqualToString:m_login.userGuid], @"Different user guids, this is bad!!"); 
        }
        GtRelease(login);
    }
#endif

    return [GtUserDefaults saveUserLogin:m_login outError:errorOrNil];
}

- (NSString*) userGuid
{
    return m_login.userGuid;
}

- (void) authenticationCompleted:(GtAction*) action
{
	if(action.didSucceed)
	{
		self.isAuthenticating = NO;
    	self.isAuthenticated = YES;
	}
    else
    {
        [GtCachedAuthenticationToken deleteFromCache];
        [self endSession];
    }   

    if(m_authenticationCallback)
    {
        [m_authenticationCallback invoke:action];
        GtReleaseWithNil(m_authenticationCallback);
    }
    
    // should have been set in the callback
    if(action.didSucceed && m_authenticationToken)
    {
        [GtCachedAuthenticationToken saveToCache:m_authenticationToken];
    }
    
	if(action.didSucceed)
	{
		[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:GtUserSessionUserAuthenticatedNotification 
			object:[UIApplication sharedApplication]]];
	}
}

- (void) beginAuthenticationAction:(GtAction*) authenticationAction
    canLoadAuthenticationTokenFromCache:(BOOL) canLoadFromCache
{
    GtAssert(m_login != nil, @"Login is nil, be sure to start session first.");

    GtAssert([self canAuthenticate], @"can't authenticate, set username and pw before calling this");

    GtAssertNotNil(authenticationAction);
    
    self.authCallback = authenticationAction.completedCallback;

    self.isAuthenticating = YES;
    self.isAuthenticated = NO;
    
    if(!canLoadFromCache)
    {
        [GtCachedAuthenticationToken deleteFromCache];
    }
        
    [authenticationAction setCompletedCallback:self selector:@selector(authenticationCompleted:)];
    [authenticationAction beginAction];
}

- (GtObjectDatabase*) cacheDatabase
{
    if(!m_cacheDatabase)
    {
        m_cacheDatabase = [GtAlloc(GtObjectDatabase) initWithDefaultName:self.cacheFolder.fullPath];
        [m_cacheDatabase open:@selector(deleteDatabaseIfVersionOutOfDate)];
	}
    
    return m_cacheDatabase;
}

- (GtDatabaseCache*) objectCache
{
    if(!m_objectDatabase)
    {
        m_objectDatabase = [GtAlloc(GtDatabaseCache) init];
        m_objectDatabase.database = self.cacheDatabase;
    }
    
    return m_objectDatabase;
}

- (GtImageCache*) imageCache
{
    if(!m_imageCache)
    {
        m_imageCache = [GtAlloc(GtImageCache) init];
        m_imageCache.database = self.cacheDatabase;
    }
    
    return m_imageCache;
}

@end
