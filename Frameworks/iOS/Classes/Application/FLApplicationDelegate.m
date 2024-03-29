//
//  FLApplicationDelegate.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 4/18/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLApplicationDelegate.h"
#import "FLMobileTheme.h"
#import "FLViewController.h"
#import "FishLampCore.h"
#import "FLApplicationDataModel.h"
#import "FLViewControllerStack.h"

#if FLUFFY
#import "FLRunUnitTestSubclassTests.h"
#endif

@implementation FLApplicationDelegate

@synthesize window = _window;
@synthesize rootViewController = _rootViewController;


+ (id) instance {
    return [[UIApplication sharedApplication] delegate];
}

- (UIWindow*) createDefaultWindow {
    UIWindow* window = FLAutorelease([[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]);
    window.backgroundColor = [UIColor blackColor];
    
    return window;
}

- (void) setRootViewController:(UIViewController*) viewController {
    FLSetObjectWithRetain(_rootViewController, viewController);
    self.window.rootViewController = self.rootViewController;
}

- (void) dealloc {
    FLRelease(_window);
    FLRelease(_rootViewController);
    FLSuperDealloc();
}

- (void) willInitApp {
    [FishLamp initializeAllModules];
}

- (void) _willStartApp {
//	FLSynchronousOperation* operation = [FLApplicationDataModel instance];
    [self willStartApp];
}

- (void) willStartApp {
}

#if FLUFFY
- (void) runFluffy {

    [self performBlockOnMainThread:^{
        FLRunUnitTestSubclassTests* unitTestMgr = [FLRunUnitTestSubclassTests unitTestRunner];
        [unitTestMgr runTests];
        [self _willStartApp];
        }];

}
#endif

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[FLUserSession instance] addObserver:self];

    [self willInitApp];

    if(!self.window) {
        self.window = [self createDefaultWindow];
    }
    if(!self.rootViewController) {
        self.rootViewController = [FLViewControllerStack viewControllerStack:[FLViewController viewController]];
    }

    [self.window makeKeyAndVisible];
    
#if DEBUG && FLUFFY
    [self runFluffy];
#else 
    [self _willStartApp];
#endif
    
    return YES;
}


@end

@implementation FLNavigationApplicationDelegate

@synthesize navigationController = _navigationController;

- (void)dealloc {
    FLRelease(_navigationController);
    FLSuperDealloc();
}
- (void) setRootViewController:(UIViewController*) viewController {
    self.navigationController = [FLNavigationController navigationController:viewController];
    [super setRootViewController:self.navigationController];
}

@end
