//
//  GtViewControllerStack.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/21/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtViewController.h"
                                             
@protocol GtViewControllerStackAnimation <NSObject> 

- (void) beginShowAnimationForViewController:(UIViewController*) viewController
    parentViewController:(UIViewController*) parentViewController
    finishedBlock: (GtBlock) finishedBlock; 

- (void) beginHideAnimationForViewController:(UIViewController*) viewController
    parentViewController:(UIViewController*) parentViewController
    finishedBlock: (GtBlock) finishedBlock; 

@end        

typedef void (^GtViewControllerStackVisitor)(UIViewController* viewController, BOOL* stop);

@interface GtViewControllerStack : GtViewController {
@private
    NSMutableArray* m_viewControllers;
}

- (id) initWithRootViewController:(UIViewController*) rootViewController;

+ (GtViewControllerStack*) viewControllerStack:(UIViewController*) rootViewController;

@property (readonly, assign, nonatomic) UIViewController* rootViewController;

@property (readwrite, retain, nonatomic) NSArray* viewControllers;

- (void) pushViewController:(UIViewController *)viewController 
             withAnimation:(id<GtViewControllerStackAnimation>) animation;

- (void) pushViewController:(UIViewController *)viewController;

- (void) popViewControllerAnimated:(BOOL) animated; // YES uses the animation in the view controller.
    
- (void) popViewControllerWithAnimation:(id<GtViewControllerStackAnimation>) animation;	

- (void) popToViewController:(UIViewController*) viewController
               withAnimation:(id<GtViewControllerStackAnimation>) animation;

- (UIViewController*) parentControllerForController:(UIViewController*) controller;
	
- (BOOL) containsViewController:(UIViewController*) controller;	   

- (UIViewController*) rootViewController;

- (UIViewController*) visibleViewController;

- (void) visitViewControllers:(GtViewControllerStackVisitor) visitor; // backwards from top

// this visits view controllers in back to front order starting with viewController
- (void) visitViewControllersStartingWithViewController:(UIViewController*) viewController 
                                                visitor:(GtViewControllerStackVisitor) visitor;

+ (id<GtViewControllerStackAnimation>) defaultAnimation;
+ (id<GtViewControllerStackAnimation>) dropAndSlideFromRightAnimation;
@end

@interface UIViewController (GtViewControllerStack)
- (void) willBePushedOnViewControllerStack:(GtViewControllerStack*) controller;
- (void) wasPushedOnViewControllerStack:(GtViewControllerStack*) controller;

- (void) willBePoppedFromViewControllerStack:(GtViewControllerStack*) controller;
- (void) wasPoppedFromViewControllerStack:(GtViewControllerStack*) controller;

@property (readonly, assign, nonatomic) GtViewControllerStack* viewControllerStack;
@property (readwrite, retain, nonatomic) id<GtViewControllerStackAnimation> viewControllerStackAnimation;

@end



        