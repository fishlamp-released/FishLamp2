//
//  FLApplicationDelegate.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 4/18/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLApplicationDelegate.h"
#import "FLMobileTheme.h"
#import "FLViewController.h"

@implementation FLApplicationDelegate

@synthesize window = _window;
@synthesize rootViewController = _rootViewController;

- (UIWindow*) createDefaultWindow {
    UIWindow* window = FLReturnAutoreleased([[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]);
    window.backgroundColor = [UIColor blackColor];
    
    return window;
}

- (void) setRootViewController:(UIViewController*) viewController {
    FLAssignObject(_rootViewController, viewController);
    self.window.rootViewController = self.rootViewController;
}

- (void) dealloc {
    FLRelease(_window);
    FLRelease(_rootViewController);
    FLSuperDealloc();
}

- (void) initWindowAndRootViewController {
    if(!self.window) {
        self.window = [self createDefaultWindow];
    }
    if(!self.rootViewController) {
        self.rootViewController = [FLViewController viewController];
    }

    [self.window makeKeyAndVisible];
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
