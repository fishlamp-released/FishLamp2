//
//  FLApplicationDelegate.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 4/18/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLApplicationDelegate : UIResponder {
@private
    UIWindow* _window;
    UIViewController* _rootViewController;
}

@property (readwrite, retain, nonatomic) IBOutlet UIWindow *window;
@property (readwrite, retain, nonatomic) IBOutlet UIViewController* rootViewController;

- (UIWindow*) createDefaultWindow;

- (void) initWindowAndRootViewController;

@end

#import "FLNavigationController.h"

@interface FLNavigationApplicationDelegate : FLApplicationDelegate {
@private
    FLNavigationController* _navigationController;
}

@property (readwrite, retain, nonatomic) UINavigationController* navigationController;

@end


