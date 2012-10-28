//
//  FLViewControllerStack.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/21/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLViewController.h"
#import "UIViewController+FLExtras.h"

typedef void (^FLViewControllerStackVisitor)(UIViewController* viewController, BOOL* stop);

@interface FLViewControllerStack : FLViewController {
@private
    NSMutableArray* _viewControllers;
    UIViewController* _rootViewController;
}

// this is the bottom view controller. Think of it as the bottom viewController in the
// stack. 
@property (readonly, retain, nonatomic) UIViewController* rootViewController;

// the leaf most viewController in the stack (see comment in UIViewController+FLExtras.h
@property (readonly, strong, nonatomic) UIViewController* visibleViewController;

@property (readwrite, retain, nonatomic) NSArray* viewControllers;

- (id) initWithRootViewController:(UIViewController*) rootViewController;

+ (FLViewControllerStack*) viewControllerStack:(UIViewController*) rootViewController;

- (void) pushViewController:(UIViewController *)viewController 
             withAnimation:(id<FLViewControllerTransitionAnimation>) animation;

- (void) pushViewController:(UIViewController *)viewController;

- (void) popViewControllerAnimated:(BOOL) animated; // YES uses the animation in the view controller.
    
- (void) popViewControllerWithAnimation:(id<FLViewControllerTransitionAnimation>) animation;	

- (void) popToViewController:(UIViewController*) viewController
               withAnimation:(id<FLViewControllerTransitionAnimation>) animation;

- (UIViewController*) parentControllerForController:(UIViewController*) controller;
	
- (BOOL) containsViewController:(UIViewController*) controller;	   

- (void) visitViewControllers:(FLViewControllerStackVisitor) visitor; // backwards from top

// this visits view controllers in back to front order starting with viewController
- (void) visitViewControllersStartingWithViewController:(UIViewController*) viewController 
                                                visitor:(FLViewControllerStackVisitor) visitor;

@end

@interface UIViewController (FLViewControllerStack)
- (void) willBePushedOnViewControllerStack:(FLViewControllerStack*) controller;
- (void) wasPushedOnViewControllerStack:(FLViewControllerStack*) controller;

- (void) willBePoppedFromViewControllerStack:(FLViewControllerStack*) controller;
- (void) wasPoppedFromViewControllerStack:(FLViewControllerStack*) controller;

@property (readonly, assign, nonatomic) FLViewControllerStack* viewControllerStack;

@end





        