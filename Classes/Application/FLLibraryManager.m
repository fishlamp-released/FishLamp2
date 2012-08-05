//
//  FLApplicationDelegate.m
//  fBee
//
//  Created by Mike Fullerton on 5/21/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLLibraryManager.h"
#import "FLLowMemoryHandler.h"
#import "FLDefaultUserNotificationErrorFormatters.h"
#import "FLHttpOperation.h"
#import "NSURLRequest+HTTP.h"
#import "FLKeyboardManager.h"
#import "FLNetworkActivityIndicator.h"
#import "FLRandom.h"
#import "FLViewController.h"
#import "FLApplicationDataMgr.h"
#import "FLThemeManager.h"
#import "FLLengthyTask+Mobile.h"
#import "FLNavigationControllerViewController.h"
#import "FLNetworkActivityIndicator.h"
#import "NSFileManager+FLExtras.h"
#import "FLProgressViewController.h"
#import "FLSimpleProgressView.h"
#import "FLFullScreenProgressView.h"

#if TEST
#import "FLUnitTestManager.h"
#endif

@implementation FLLibraryManager

FLSynthesizeSingleton(FLLibraryManager);
@synthesize delegate = _delegate;

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	FLSuperDealloc();
}

- (void) initializeAppWithTheme:(FLTheme*) theme {    
	// Override point for customization after application launch.
    
	FLSetRandomSeed();
	
#if DEBUG	
	if(getenv("NSZombieEnabled") || getenv("NSAutoreleaseFreedObjectCheckEnabled")) {
		FLLog(@"NSZombieEnabled/NSAutoreleaseFreedObjectCheckEnabled enabled!");
	}
#endif
  
// This is experimental
// TODO: finish this	  
//	  FLInstallUncaughtExceptionHandler();
	
    // NOTE if app crashes here, it probably means you need to add "-ObjC" option to linker flags. 
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];	
 
// low memory handling		
// TODO: maybe get rid of this
	[[FLLowMemoryHandler defaultHandler] registerForEvents];
	
// error message formatters	
// TODO: abstract this so it's not coupled?   
	InstallDefaultUserNotificationErrorFormatters();
		
// wire core networkOperation up to mobile networkActivityIndicator	   
	[FLGlobalNetworkActivityIndicator setInstance: [FLNetworkActivityIndicator instance]];
		
	[[FLKeyboardManager instance] startWatchingKeyboard];

	[[FLApplicationDataMgr instance] openDatabase];

	[[FLThemeManager instance] beginListeningToSessionChanges];
    [[FLThemeManager instance] loadThemeList];
    [[FLThemeManager instance] setDefaultTheme];

    [[FLApplication sharedApplication] didInitializeApp];;
 	[FLUserSession instance].delegate = self;
    
    [[FLBackgroundTaskMgr instance] registerForEvents];

    NSString* defaultUserAgent = [NSString stringWithFormat:@"%@/%@ (%@; %@; %@; %@;)", 
                [NSFileManager appName], 
                [NSFileManager appVersion],
                [UIDevice currentDevice].model,
                [UIDevice currentDevice].machineName,
                [UIDevice currentDevice].systemName,
                [UIDevice currentDevice].systemVersion];

    [FLHttpRequest setDefaultUserAgent:defaultUserAgent];
    [NSURLRequest setDefaultUserAgent:defaultUserAgent];
}


- (void) _beginLoggingOut {
    if([self.delegate respondsToSelector:@selector(willLogoutUser:)]) {
        [self.delegate willLogoutUser:self];
    }

    [[FLBackgroundTaskMgr instance] resetAllTasks];
    [[FLUserSession instance] setUserLoggedOut];
}

- (void) beginLoggingOutUser {
    if([[FLBackgroundTaskMgr instance] isExecutingBackgroundTask]) {
        FLProgressViewController* progress = [FLProgressViewController progressViewController:[FLSimpleProgressView class] presentationBehavior:[FLModalPresentationBehavior instance]];
        [progress setTitle:NSLocalizedString(@"Logging Out…", nil)];
    
        [[FLBackgroundTaskMgr instance] beginCancellingAllTasks:^(id backgroundTaskMgr) {
            
            [self _beginLoggingOut];
            [progress dismissViewControllerAnimated:YES];
            } ];
    }
    else {
        [self _beginLoggingOut];
    }
}

- (void) userSessionWillOpen:(FLUserSession*) userSession {
	[userSession finishOpeningSession];
    
    if([self.delegate respondsToSelector:@selector(userSessionWillOpen:)]) {
        [self.delegate userSessionWillOpen:userSession];
    }
}

- (void) userSession:(FLUserSession*) userSession 
appVersionWillChange:(FLVersionUpgradeLengthyTaskList*) taskListToAddTo {
    if([self.delegate respondsToSelector:@selector(userSession:appVersionWillChange:)]) {
        [self.delegate userSession:userSession appVersionWillChange:taskListToAddTo];
    }
}

- (void) userSession:(FLUserSession*) userSession 
 performUpgradeTasks:(FLVersionUpgradeLengthyTaskList*) withLengthyTask {
    
    FLActionContext* context = [[FLActionContext alloc] init];
    [withLengthyTask executeLengthyTask:context
		operationNameForProgress:[NSString stringWithFormat:(NSLocalizedString(@"Updating App to Version: %@", nil)), [NSFileManager appVersion]]
		progressViewClass:[FLFullScreenProgressView class]
        finishedBlock:^(NSError* error) {
			if(!error) {
				[userSession finishUpgradeTasks];
			}
            else {
                // TODO: Ok, now what?
            }
            
            
            FLRelease(context); // need to make sure the action sticks around long enough.
		}];
}

- (void) userSessionDidOpen:(FLUserSession*) userSession {
    if([self.delegate respondsToSelector:@selector(userSessionDidOpen:)]) {
        [self.delegate userSessionDidOpen:userSession];
    }
}

- (void) userSessionDidClose:(FLUserSession*) userSession {
    if([self.delegate respondsToSelector:@selector(userSessionDidClose:)]) {
        [self.delegate userSessionDidClose:userSession];
    }
}

- (void) userSessionUserDidLogout:(FLUserSession*) userSession {
    if([self.delegate respondsToSelector:@selector(userSessionUserDidLogout:)]) {
        [self.delegate userSessionUserDidLogout:userSession];
    }
}

- (void) openAppWithDefaultUser:(FLEventCallback) userLoginCompleted {
    userLoginCompleted = FLReturnAutoreleased([userLoginCompleted copy]);

    [[FLUserSession instance] beginOpeningSession:[[FLUserSession instance] loadDefaultUser]
		wasOpenedBlock:^(FLUserLogin* login){
            if(userLoginCompleted) {   
                userLoginCompleted();
            }
		}];
}

@end



