//
//	GtNavigationController.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/20/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtToolbarButtonbarView.h"

typedef enum { 
	GtNavigationControllerAnimationDefault, // slide in/out from right.
	GtNavigationControllerAnimationFlipFromLeft = UIViewAnimationTransitionFlipFromLeft,
	GtNavigationControllerAnimationFlipFromRight = UIViewAnimationTransitionFlipFromRight,
	GtNavigationControllerAnimationCurlUp = UIViewAnimationTransitionCurlUp,
	GtNavigationControllerAnimationCurlDown = UIViewAnimationTransitionCurlDown,
	GtNavigationControllerAnimationFade,
	GtNavigationControllerAnimationSlideInFromBottom,
	GtNavigationControllerAnimationNone
} GtNavigationControllerAnimation;

typedef void (^GtNavigationControllerVisitor)(id viewController, BOOL* stop);

@interface UINavigationController (GtExtras)
- (void) setNavigationBarHiddenWithFadeAnimation:(BOOL) hidden;

- (void)pushViewController:(UIViewController *)viewController 
	withAnimation:(GtNavigationControllerAnimation) animation;
	
- (void) popViewControllerWithAnimation:(GtNavigationControllerAnimation) animation;	
- (void) popToViewController:(UIViewController*) viewController withAnimation:(GtNavigationControllerAnimation) animation;	  

- (UIViewController*) parentControllerForController:(UIViewController*) controller;
	
- (BOOL) containsViewController:(UIViewController*) controller;	   

- (UIViewController*) rootViewController;

- (void) visitViewControllers:(GtNavigationControllerVisitor) visitor; // backwards from top

- (void) visitViewControllersForClass:(Class) aClass 
                              visitor:(GtNavigationControllerVisitor) visitor;

// this visits view controllers in back to front order starting with viewController
- (void) visitViewControllersStartingWithViewController:(UIViewController*) viewController 
                                                visitor:(GtNavigationControllerVisitor) visitor;

- (void) viewControllerDismissDelegate:(UIViewController*) viewController dismissViewControllerAnimated:(BOOL) animated;


@end

@interface UIViewController (GtNavigationController)
- (void) willBePushedOnNavigationController:(UINavigationController*) controller;
- (void) wasPushedOnNavigationController:(UINavigationController*) controller;
- (void) wasPoppedFromNavigationController:(UINavigationController*) controller;
- (GtButtonbarView*) buttonbar;



@end

// use this because it send the new events to UIViewController (above)
@interface GtNavigationController : UINavigationController {
@private
	UIViewController* m_superViewController;
}

+ (GtNavigationController*) navigationController:(UIViewController*) rootViewController;
@end

