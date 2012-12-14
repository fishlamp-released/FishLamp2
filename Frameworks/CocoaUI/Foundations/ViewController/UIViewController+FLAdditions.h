//
//  UIViewController+FLAdditions.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/18/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaUIRequired.h"
#import "FLViewContentsDescriptor.h"
#import "FLViewControllerTransitionAnimation.h"

// block called to dismiss the viewController. Be careful not to cause a retain
// cycle using this.
typedef void (^FLViewControllerDismissHandler)(UIViewController* viewController, BOOL animated);

@interface UIViewController (FLExtras)

// if this is set, it is called instead of willDismissViewController from
// dismissViewControllerAnimated
@property (readwrite, copy, nonatomic) FLViewControllerDismissHandler dismissHandler; 

// the animation is saved and used for dismissal
// if the frame of the viewController is zero, the frame is set to the parents views
// bounds, otherwise the frame is preserved. 
- (void) presentChildViewController:(UIViewController*) viewController; 

// called after view & viewController are added to hierarchy, but before animation starts.
- (void) willPresentInViewController; 
                     
// this is called when the transition animation is done.                      
- (void) wasPresentedInParentViewController; 

/// present in default view controller with either the attached behavior and transition
/// animation or used the class's default.
- (void) presentViewControllerAnimated:(BOOL) animated;

// this calls the dismissHandler or willDismissViewControllerAnimated if there isn't a 
// dismiss handler.
- (void) dismissViewControllerAnimated:(BOOL) animated; 

// suitable for a button event, calls dismissViewControllerAnimated:YES
- (void) dismissViewControllerWithSender:(id) sender; 

// this is called when the animation id done 
// (only guarenteed to be called if dismiss delegate is nil). Though best
// practice is that the dismissHandler would call it (or use a transition
// animation to call it).
- (void) wasDismissedFromParentViewController; 

// only called if dismiss delegate is nil. This uses
// the transitionAnimation to dismiss the view controller.
- (void) willDismissViewControllerAnimated:(BOOL) animated; 

// this is the leaf most visible view container that THIS viewController knows about, e.g. 
// THIS viewController asks it's most visible viewController what it's visibleViewController 
// is, and in that way, we can make our way out to the leaf most viewController without
// having to have unholy knowledge of our children. In the end, a viewController will 
// return SELF and complete the process.
- (UIViewController*) visibleViewController;

@end


@interface UIViewController (FLViewControllerTransitionAnimation) 

// calls defaultAnimation by default if there isn't one defined (some some sub classes will have
// there own defined).
@property (readwrite, retain, nonatomic) id<FLViewControllerTransitionAnimation> transitionAnimation;

+ (id<FLViewControllerTransitionAnimation>) defaultTransitionAnimation; // default == no animation at all.
@end

@interface UIViewController (FLNavigation)
// support for the dreaded UINavigationController

@property (readwrite, retain, nonatomic) NSString* backButtonTitle;

- (void) respondToBackButtonPress:(id) sender; 

- (BOOL) backButtonWillDismissViewController;

#if IOS
// returns self.navigationController or self if self IS a navigation controller.
// this is so you can call viewController.rootNavigationController, and you'll
// get all the way to the top of the stack for navigation controllers.
- (UINavigationController*) rootNavigationController;
#endif
@end

#if IOS
#define FLViewControllerTopToolBarTag      'topB'
#define FLViewControllerBottomToolBarTag   'botB'

@interface UIViewController (FLToolbars) 
// these takes into consideration the FLViewContents descriptor, etc.
- (CGRect) frameForTopBarView:(UIView*) view;
- (CGRect) frameForBottomBarView:(UIView*) view;

// these are stored with special tags in the subView list
// Note that either toolBar can be ANY kind of view.
@property (readwrite, retain, nonatomic) id topBarView;
@property (readwrite, retain, nonatomic) id bottomBarView;
@end

@interface UIViewController (FLProgressAdditions)
// this is a convienience method - it just add a centered UIActivityIndicatorView
// to self.view. It's up to the client code to remove it.
- (UIActivityIndicatorView*) addActivityIndicatorView:(UIActivityIndicatorViewStyle) style;
@end
#endif


@interface UIViewController (FLNibLoading)
@property (readonly, strong, nonatomic) NSString* defaultNibName;
- (id) initWithDefaultNibName;
- (id) initWithDefaultNibName:(NSBundle *)nibBundleOrNil;
@end

