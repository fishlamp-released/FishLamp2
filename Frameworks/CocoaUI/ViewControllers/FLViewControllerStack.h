//
//  FLViewControllerStack.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/21/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//
#import "FLCocoaUICompatibility.h"
#import "FLViewController.h"
#import "SDKViewController+FLAdditions.h"

typedef void (^FLViewControllerStackVisitor)(SDKViewController* viewController, BOOL* stop);

@interface FLViewControllerStack : FLViewController {
@private
    NSMutableArray* _viewControllers;
    SDKViewController* _rootViewController;
}

// this is the bottom view controller. Think of it as the bottom viewController in the
// stack. 
@property (readonly, retain, nonatomic) SDKViewController* rootViewController;

// the leaf most viewController in the stack (see comment in SDKViewController+FLAdditions.h
@property (readonly, strong, nonatomic) SDKViewController* visibleViewController;

@property (readwrite, retain, nonatomic) NSArray* viewControllers;

- (id) initWithRootViewController:(SDKViewController*) rootViewController;

+ (FLViewControllerStack*) viewControllerStack:(SDKViewController*) rootViewController;

- (void) pushViewController:(SDKViewController *)viewController 
             withAnimation:(id<FLViewControllerTransitionAnimation>) animation;

- (void) pushViewController:(SDKViewController *)viewController;

- (void) popViewControllerAnimated:(BOOL) animated; // YES uses the animation in the view controller.
    
- (void) popViewControllerWithAnimation:(id<FLViewControllerTransitionAnimation>) animation;	

- (void) popToViewController:(SDKViewController*) viewController
               withAnimation:(id<FLViewControllerTransitionAnimation>) animation;

- (SDKViewController*) parentControllerForController:(SDKViewController*) controller;
	
- (BOOL) containsViewController:(SDKViewController*) controller;	   

- (void) visitViewControllers:(FLViewControllerStackVisitor) visitor; // backwards from top

// this visits view controllers in back to front order starting with viewController
- (void) visitViewControllersStartingWithViewController:(SDKViewController*) viewController 
                                                visitor:(FLViewControllerStackVisitor) visitor;

@end

@interface SDKViewController (FLViewControllerStack)
- (void) willBePushedOnViewControllerStack:(FLViewControllerStack*) controller;
- (void) wasPushedOnViewControllerStack:(FLViewControllerStack*) controller;

- (void) willBePoppedFromViewControllerStack:(FLViewControllerStack*) controller;
- (void) wasPoppedFromViewControllerStack:(FLViewControllerStack*) controller;

@property (readonly, assign, nonatomic) FLViewControllerStack* viewControllerStack;

@end





        