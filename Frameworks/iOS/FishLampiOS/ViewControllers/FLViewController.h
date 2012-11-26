//
//	FLViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/8/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLToolbarButtonbarView.h"
#import "FLReachableNetwork.h"

#import "FLNavigationController.h"
#import "FLCallbackObject.h"
#import "FLWeakReference.h"
#import "FLBackgroundTaskMgr.h"
#import "FLViewContentsDescriptor.h"
#import "UIViewController+FLExtras.h"
#import "FLFinisher.h"

@class FLAction;

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

@interface FLViewController : UIViewController {
@private
	FLOperationContext* _operationContext;
	NSMutableArray* _didAppearCallbacks;
	
    FLNavigationControllerAnimation _navigationControllerCloseAnimation;
	__unsafe_unretained FLViewController* _modalParent;
    FLSize _floatingViewContentSize;
    FLSize _startSize;
    
    BOOL _viewIsVisible;
    BOOL _disableBackgroundTasks;
#if DEBUG
    BOOL _dismissed;
#endif        
}

+ (id) viewController;

@property (readonly, strong, nonatomic) FLOperationContext* operationContext;

@end

@interface FLViewController ()

// all this crap will probably be deprecated.

@property (readwrite, assign, nonatomic) BOOL disableBackgroundTasks;
@property (readwrite, assign, nonatomic) FLNavigationControllerAnimation navigationControllerCloseAnimation;
@property (readonly, assign, nonatomic) BOOL viewIsVisible;
@property (readwrite, assign, nonatomic) FLSize contentSizeForViewInFloatingView;

// only called for active view controller
- (void) appDidEnterForeground;

// optional
- (void) updateViewContentsDescriptor;

- (UIView*) createView;

- (void) networkDidBecomeAvailable;
- (void) networkDidBecomeUnavailable;
- (void) addDidAppearCallback:(FLCallbackObject*) callback;

// set this before calling presentModalViewController so that dismissViewControllerAnimated knows to dismissModalView.
@property (readwrite, assign, nonatomic) FLViewController* modalParentViewController;
+ (BOOL) isPresentingModalViewController;
+ (FLViewController*) presentingModalViewController;

@end

@interface UIViewController (FLViewControllerProbablyDeprecated)


- (void) willBePresentedModallyInViewController:(UIViewController*) superViewController;
- (void) wasPresentedModally:(UIViewController*) superViewController;
- (void) wasDismissedFromModalPresentation:(UIViewController*) superViewController;

@property (readonly, assign, nonatomic) FLNavigationControllerAnimation navigationControllerCloseAnimation;

@end

@interface UIViewController (FLOperations)

@property (readonly, strong, nonatomic) FLOperationContext* operationContext;

- (FLFinisher*) startOperation:(FLOperation*) operation
             finisher:(FLFinisher*) finisher;

- (FLFinisher*) startAction:(FLAction*) action
             finisher:(FLFinisher*) finisher;


@end

