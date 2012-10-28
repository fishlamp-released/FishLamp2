//
//	FLNavigationControllerViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 11/23/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLViewController.h"
#import "FLNavigationController.h"

@interface FLNavigationControllerViewController : FLViewController {
@private
	IBOutlet FLNavigationController* _navigationController;
	UIViewController* _rootViewController;
}

- (id) initWithRootViewController:(UIViewController*) viewController;

+ (FLNavigationControllerViewController*) navigationControllerViewController:(UIViewController*) rootNavigationController;

@property (readwrite, retain, nonatomic) UINavigationController* rootNavigationController;

@end
