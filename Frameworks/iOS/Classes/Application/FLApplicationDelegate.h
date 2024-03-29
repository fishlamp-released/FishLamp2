//
//  FLApplicationDelegate.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 4/18/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <UIKit/UIKit.h>

@protocol FLApplicationDelegate <UIApplicationDelegate>
- (void) willInitApp;
- (void) willStartApp;
@end


@interface FLApplicationDelegate : UIResponder<UIApplicationDelegate> {
@private
    UIWindow* _window;
    UIViewController* _rootViewController;
}

@property (readwrite, retain, nonatomic) IBOutlet UIWindow *window;
@property (readwrite, retain, nonatomic) IBOutlet UIViewController* rootViewController;

- (void) willInitApp;
- (void) willStartApp;

+ (id) instance;

@end

@interface FLApplicationDelegate (UIApplicationDelegate)
// if you override this in your app, you MUST call
// [super application:application didFinishLaunchingWithOptions:launchOptions];
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
@end

#import "FLNavigationController.h"

@interface FLNavigationApplicationDelegate : FLApplicationDelegate {
@private
    FLNavigationController* _navigationController;
}

@property (readwrite, retain, nonatomic) UINavigationController* navigationController;

@end


