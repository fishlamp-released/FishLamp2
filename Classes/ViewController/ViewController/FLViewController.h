//
//	FLViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/8/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLManagedActionContext.h"
#import "FLToolbarButtonbarView.h"
#import "FLReachableNetwork.h"

#import "FLNavigationController.h"
#import "FLCallbackObject.h"
#import "FLWeakReference.h"
#import "FLBackgroundTaskMgr.h"
#import "FLViewContentsDescriptor.h"
#import "UIViewController+FLExtras.h"

#if DEBUG
#define TRACE_ACTION_CONTROLLER 0
#endif

@protocol FLViewControllerToolbarDelegate <NSObject>
@optional
- (void) viewControllerTitleDidChange:(UIViewController*) viewController;
- (void) viewControllerViewWillAppear:(UIViewController*) viewController;
- (void) viewControllerViewDidDisappear:(UIViewController*) viewController;

- (void) viewController:(UIViewController*) viewController willBePushedOnNavigationController:(UINavigationController *)controller;
@end


@interface FLViewController : UIViewController<FLActionContextDelegate, FLBackgroundTaskMgrDelegate> {
@private
	FLManagedActionContext* _context;
	NSMutableArray* _didAppearCallbacks;
	
    FLNavigationControllerAnimation _navigationControllerCloseAnimation;
	FLViewController* _modalParent;
    CGSize _floatingViewContentSize;
    CGSize _startSize;
    
    BOOL _viewIsVisible;
    BOOL _disableBackgroundTasks;
#if DEBUG
    BOOL _dismissed;
#endif        
}

+ (id) viewController;

@property (readwrite, assign, nonatomic) BOOL disableBackgroundTasks;

@property (readwrite, assign, nonatomic) FLNavigationControllerAnimation navigationControllerCloseAnimation;

@property (readonly, assign, nonatomic) BOOL viewIsVisible;
@property (readonly, retain, nonatomic) FLActionContext* actionContext;

@property (readwrite, assign, nonatomic) CGSize contentSizeForViewInFloatingView;

- (void) didCancelActions;

// only called for active view controller
- (void) appDidEnterForeground;
- (void) appDidEnterBackground;

- (void) networkDidBecomeAvailable;
- (void) networkDidBecomeUnavailable;

- (void) didBecomeActiveContext;
- (void) didBecomeInactiveContext;
- (void) onDeviceWasShaken;

- (void) addDidAppearCallback:(FLCallbackObject*) callback;


// set this before calling presentModalViewController so that dismissViewControllerAnimated knows to dismissModalView.
@property (readwrite, assign, nonatomic) FLViewController* modalParentViewController;

// optional
- (void) updateViewContentsDescriptor;

- (UIView*) createView;

+ (BOOL) isPresentingModalViewController;
+ (FLViewController*) presentingModalViewController;

- (void) createActionContext;

@end

@interface UIViewController (FLViewController)

- (void) willBePresentedModallyInViewController:(UIViewController*) superViewController;
- (void) wasPresentedModally:(UIViewController*) superViewController;
- (void) wasDismissedFromModalPresentation:(UIViewController*) superViewController;

@property (readonly, assign, nonatomic) FLNavigationControllerAnimation navigationControllerCloseAnimation;


@end

