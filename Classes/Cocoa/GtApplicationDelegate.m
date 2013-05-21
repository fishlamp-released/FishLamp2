//
//  GtApplicationDelegate.m
//  fBee
//
//  Created by Mike Fullerton on 5/21/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtApplicationDelegate.h"
#import "GtLowMemoryHandler.h"
#import "GtDefaultUserNotificationErrorFormatters.h"
#import "GtHttpOperation.h"
#import "NSURLRequest+HTTP.h"
#import "GtKeyboardManager.h"
#import "GtNetworkActivityIndicator.h"
#import "GtRandom.h"
#import "GtViewController.h"
#import "GtApplicationDataMgr.h"
#import "GtThemeManager.h"
#import "GtLengthyTask+Mobile.h"
#import "GtTempFileMgr.h"
#import "GtNavigationControllerViewController.h"
#import "GtNetworkActivityIndicator.h"
#import "GtOldProgressView.h"
#import "NSFileManager+GtExtras.h"

#if UNIT_TESTS
#import "GtUnitTestManager.h"
#endif

@implementation GtApplicationRootViewController
+ (id) applicationRootViewController {
return [[[[self class] alloc] init] autorelease];
}
@end

@implementation GtApplicationDelegate

@synthesize window = m_window;

static GtApplicationDelegate* s_instance = nil;
@synthesize navigationController = _navigationController;

+ (id) instance
{
	return s_instance;
}

- (void)dealloc 
{
#if DEPRECATED
	[[NSNotificationCenter defaultCenter] removeObserver:[UIDevice currentDevice]];
#endif    
	[[NSNotificationCenter defaultCenter] removeObserver:self];

    [_navigationController release];

	GtRelease(m_window);
	s_instance = nil;
    GtSuperDealloc();
}

- (void) initializeAppWithTheme:(GtMobileTheme*) theme;
{    
	s_instance = self;
	
    // Override point for customization after application launch.
    
	GtSetOSVersion();
	
	GtSetRandomSeed();
	
#if DEBUG	
	if(getenv("NSZombieEnabled") || getenv("NSAutoreleaseFreedObjectCheckEnabled")) 
	{
		GtLog(@"NSZombieEnabled/NSAutoreleaseFreedObjectCheckEnabled enabled!");
	}
#endif
  
// This is experimental
// TODO: finish this	  
//	  GtInstallUncaughtExceptionHandler();

#if DEPRECATED
 // set device for rotation events	 
	[[NSNotificationCenter defaultCenter] addObserver:[UIDevice currentDevice]
											 selector:@selector(handleRotatedEvent:)
												 name:UIDeviceOrientationDidChangeNotification
											   object:nil];
#endif
	
    // NOTE if app crashes here, it probably means you need to add "-ObjC" option to linker flags. 
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];	
 
// low memory handling		
	[[GtLowMemoryHandler defaultHandler] registerForEvents];
	
// error message formatters	   
	InstallDefaultUserNotificationErrorFormatters();
		
// wire core networkOperation up to mobile networkActivityIndicator	   
	[GtGlobalNetworkActivityIndicator setGlobalNetworkActivityIndicator: [GtNetworkActivityIndicator instance]];
		
	[[GtKeyboardManager instance] startWatchingKeyboard];

	[GtNotificationDisplayManager setDefaultDisplayManager:self];
	
	[[GtApplicationDataMgr instance] openDatabase];

	[[GtThemeManager instance] beginListeningToSessionChanges];
    [[GtThemeManager instance] setTheme:theme];
    
    [[GtThemeManager theme] applyThemeToStatusBar];
    
 	[GtUserSession instance].delegate = self;
    
    [[GtBackgroundTaskMgr instance] registerForEvents];


    NSString* defaultUserAgent = [NSString stringWithFormat:@"%@/%@ (%@; %@; %@; %@;)", 
                [NSFileManager appName], 
                [NSFileManager appVersion],
                [UIDevice currentDevice].model,
                [UIDevice currentDevice].machineName,
                [UIDevice currentDevice].systemName,
                [UIDevice currentDevice].systemVersion];

    [GtHttpRequest setDefaultUserAgent:defaultUserAgent];
    [NSURLRequest setDefaultUserAgent:defaultUserAgent];

    if(!self.window)
    {
        self.window = GtReturnAutoreleased([[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]);
        self.window.backgroundColor = [UIColor blackColor];
        [self.window makeKeyAndVisible];
    }

    [self.window makeKeyAndVisible];
}

- (UIViewController*) createRootViewController
{
    return GtReturnAutoreleased([[GtApplicationRootViewController alloc] init]);
}

- (void) setRootViewControllerWithNavigationController {
    [self setRootViewControllerWithNavigationController:[GtApplicationRootViewController applicationRootViewController]];
}

- (void) setRootViewControllerWithNavigationController:(UIViewController*) rootViewController
{
	self.navigationController = [GtNavigationController navigationController:rootViewController];
    [[GtThemeManager theme] applyThemeToNavigationController:self.navigationController];
    [self setRootViewController:self.navigationController];
}

- (void) setRootViewController:(UIViewController*) rootViewController {
    self.window.rootViewController = rootViewController;
}

- (void) initWindow
{
    GtAssertNotNil(self.window);
    
    
// root window needs to be a GtWindow

}

- (void) beginLoggingOut
{
    [[GtBackgroundTaskMgr instance] resetAllTasks];
    [[GtUserSession instance] setUserLoggedOut];
}

- (void) logout
{
    if([[GtBackgroundTaskMgr instance] isExecutingBackgroundTask])
    {
        GtOldProgressView* progress = [GtOldProgressView defaultModalProgressView];
        [progress setTitle:NSLocalizedString(@"Logging Out…", nil)];
        [progress showProgress];
    
        [[GtBackgroundTaskMgr instance] beginCancellingAllTasks:^{
            
            [self beginLoggingOut];
            [progress hideProgress];
            } ];
    }
    else
    {
        [self beginLoggingOut];
    }
}

#if UNIT_TESTS
- (void) runUnitTests
{
	GtUnitTestManager* manager = [[GtUnitTestManager alloc] init];
	[manager discoverTests];
	[manager executeTests];
	GtReleaseWithNil(manager);
}
#endif

- (UIViewController*) defaultViewController
{
	if([GtViewController isPresentingModalViewController])
	{
		UIViewController* controller = [GtViewController presentingModalViewController].modalViewController;
        if(controller.navigationController)
        {
            return [controller.navigationController topViewController];
        }
        
        if([controller respondsToSelector:@selector(rootNavigationController)])
        {
            UINavigationController* navController = [((id) controller) rootNavigationController];
            if(navController)
            {
                return [navController topViewController];
            }
        }
        
        return controller;
    }
    
    UIViewController* viewController = self.window.rootViewController;
    
    if(viewController.navigationController)
    {
        return [viewController.navigationController topViewController];
    }

	return viewController;
}

- (void) userSessionWillOpen:(GtUserSession*) userSession
{
	[userSession finishOpeningSession];
}

- (void) userSession:(GtUserSession*) userSession appVersionWillChange:(GtVersionUpgradeLengthyTaskList*) taskListToAddTo
{
}

- (void) userSession:(GtUserSession*) userSession performUpgradeTasks:(GtVersionUpgradeLengthyTaskList*) withLengthyTask
{
    GtActionContext* context = [[GtActionContext alloc] init];
    
	[withLengthyTask executeLengthyTask:context
		operationNameForProgress:[NSString stringWithFormat:(NSLocalizedString(@"Updating App data to version: %@", nil)), [NSFileManager appVersion]]
		finishedBlock:^(NSError* error) {
			if(!error)
			{
				[userSession finishUpgradeTasks];
			}
            
            GtRelease(context);
		}];
}

- (void) userSessionDidOpen:(GtUserSession*) userSession
{
    [GtTempFileMgr instance].folder = userSession.tempFolder;
// TODO: add this back
//    [[GtTempFileMgr instance] beginPurgeInBackgroundThread:nil];
}

- (void) userSessionDidClose:(GtUserSession*) userSession
{
// TODO: add this back
//    [[GtTempFileMgr instance] beginPurgeInBackgroundThread:nil];
}

- (void) userSessionUserDidLogout:(GtUserSession*) userSession
{
}

- (void) showNotification:(GtNotificationViewController*) notification
{
    [notification showNotificationInViewController:self.defaultViewController];
}

- (void) showProgress:(GtProgressViewController*)progress
{
	[progress showProgressInViewController:[self defaultViewController]];
}

- (id<GtDisplayedNotification>) createNotificationWithType:(GtDisplayedNotificationType) type
{
	return GtReturnAutoreleased([[GtUserNotificationView alloc] initWithType:type]);
}

- (void) openAppWithDefaultUser:(GtBlock) userLoginCompleted
{
    userLoginCompleted = GtReturnAutoreleased([userLoginCompleted copy]);

    [[GtUserSession instance] beginOpeningSession:[[GtUserSession instance] loadDefaultUser]
		wasOpenedBlock:^(GtUserLogin* login){
            if(userLoginCompleted)
            {   
                userLoginCompleted();
            }
		}];
}



@end
