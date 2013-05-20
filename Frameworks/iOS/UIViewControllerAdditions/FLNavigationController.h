//
//	FLNavigationController.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/20/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@class FLDeprecatedButtonbarView;

typedef enum { 
	FLNavigationControllerAnimationDefault, // slide in/out from right.
	FLNavigationControllerAnimationFlipFromLeft = UIViewAnimationTransitionFlipFromLeft,
	FLNavigationControllerAnimationFlipFromRight = UIViewAnimationTransitionFlipFromRight,
	FLNavigationControllerAnimationCurlUp = UIViewAnimationTransitionCurlUp,
	FLNavigationControllerAnimationCurlDown = UIViewAnimationTransitionCurlDown,
	FLNavigationControllerAnimationFade,
	FLNavigationControllerAnimationSlideInFromBottom,
	FLNavigationControllerAnimationNone
} FLNavigationControllerAnimation;

typedef void (^FLNavigationControllerVisitor)(id viewController, BOOL* stop);

@interface UINavigationController (FLExtras)

- (void) setNavigationBarHiddenWithFadeAnimation:(BOOL) hidden;

- (void)pushViewController:(UIViewController *)viewController 
	withAnimation:(FLNavigationControllerAnimation) animation;
	
- (void) popViewControllerWithAnimation:(FLNavigationControllerAnimation) animation;	

- (void) popToViewController:(UIViewController*) viewController 
               withAnimation:(FLNavigationControllerAnimation) animation;	  

- (UIViewController*) parentControllerForController:(UIViewController*) controller;
	
- (BOOL) containsViewController:(UIViewController*) controller;	   

- (UIViewController*) rootViewController;

- (void) visitViewControllers:(FLNavigationControllerVisitor) visitor; // backwards from top

- (void) visitViewControllersForClass:(Class) aClass 
                              visitor:(FLNavigationControllerVisitor) visitor;

// this visits view controllers in back to front order starting with viewController
- (void) visitViewControllersStartingWithViewController:(UIViewController*) viewController 
                                                visitor:(FLNavigationControllerVisitor) visitor;
@end

@interface UIViewController (FLNavigationController)
- (void) willBePushedOnNavigationController:(UINavigationController*) controller;
- (void) wasPushedOnNavigationController:(UINavigationController*) controller;
- (void) wasPoppedFromNavigationController:(UINavigationController*) controller;

// TODO: deprecate this
- (FLDeprecatedButtonbarView*) buttonbar;

- (UINavigationController*) createContainingNavigationController;
@end

// use this because it send the new events to UIViewController (above)
@interface FLNavigationController : UINavigationController {
@private
	UIViewController* _superViewController;
}

+ (FLNavigationController*) navigationController:(UIViewController*) rootViewController;
@end

