//
//	FLNavigationControllerViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 11/23/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
