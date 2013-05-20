//
//	GtViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/8/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtManagedActionContext.h"
#import "GtToolbarButtonbarView.h"
#import "GtNetworkStatusMonitor.h"

#import "GtNavigationController.h"
#import "GtCallbackObject.h"
#import "GtWeakReference.h"
#import "GtBackgroundTaskMgr.h"
#import "GtViewContentsDescriptor.h"

#if DEBUG
#define TRACE_ACTION_CONTROLLER 0
#endif
@class GtViewController;

@interface GtViewController : UIViewController<GtActionContextDelegate, GtBackgroundTaskMgrDelegate, GtThemedObject> {
@private
	GtManagedActionContext* m_context;
	GtButtonbarView* m_buttonbar;
	NSMutableArray* m_didAppearCallbacks;
	NSString* m_backButtonTitle;
	NSInteger m_tag;
	GtNavigationControllerAnimation m_navigationControllerCloseAnimation;
	GtViewController* m_modalParent;
    CGSize m_hoverViewContentSize;
    GtRectLayout _autoLayoutMode;
	BOOL _autoLayout;    
    struct {
		unsigned int viewIsVisible:1;
        unsigned int disableBackgroundTasks: 1;
#if DEBUG
        unsigned int dismissed: 1;
#endif        
	} m_viewControllerFlags; 
    
    BOOL _wasThemed;
    SEL _themeAction;
}

+ (id) viewController;

@property (readwrite, assign, nonatomic) BOOL autoLayout;
@property (readwrite, assign, nonatomic) GtRectLayout autoLayoutMode;

@property (readwrite, assign, nonatomic) BOOL disableBackgroundTasks;

@property (readwrite, assign, nonatomic) GtNavigationControllerAnimation navigationControllerCloseAnimation;
@property (readwrite, assign, nonatomic) NSInteger tag;
@property (readonly, assign, nonatomic) BOOL viewIsVisible;
@property (readonly, retain, nonatomic) GtActionContext* actionContext;

// will create it if not created.
- (void) createButtonBar;
@property (readonly, retain, nonatomic) GtButtonbarView* buttonbar; 

@property (readwrite, assign, nonatomic) CGSize contentSizeForViewInHoverView;

- (void) didCancelActions;

// only called for active view controller
- (void) appDidEnterForeground;
- (void) appDidEnterBackground;

- (void) networkDidBecomeAvailable;
- (void) networkDidBecomeUnavailable;

- (void) didBecomeActiveContext;
- (void) didBecomeInactiveContext;
- (void) onDeviceWasShaken;

- (void) addDidAppearCallback:(GtCallbackObject*) callback;


// set this before calling presentModalViewController so that dismissViewController knows to dismissModalView.
@property (readwrite, assign, nonatomic) GtViewController* modalParentViewController;

@property (readwrite, retain, nonatomic) NSString* backButtonTitle;
- (void) respondToBackButtonPress:(id) sender; 
- (BOOL) backButtonWillDismissViewController;

- (GtViewContentsDescriptor) describeViewContents;

- (UIView*) createView;
- (void) didCreateView:(UIView*) view;

+ (BOOL) isPresentingModalViewController;
+ (GtViewController*) presentingModalViewController;

- (void) createActionContext;
- (void) createTopToolbar;

- (void) configureNavigationBar;

@end


@protocol GtViewControllerDismissDelegate <NSObject>
- (void) viewControllerDismissDelegate:(UIViewController*) viewController dismissViewControllerAnimated:(BOOL) animated;
@end

@interface UIViewController (GtViewController)
@property (readonly, assign, nonatomic) GtViewContentsDescriptor viewContentsDescriptor;

@property (readwrite, retain, nonatomic) NSString* backButtonTitle; // returns self.title by default
- (void) willBePresentedModallyInViewController:(UIViewController*) superViewController;
- (void) wasPresentedModally:(UIViewController*) superViewController;
- (void) wasDismissedFromModalPresentation:(UIViewController*) superViewController;

@property (readwrite, assign, nonatomic) id dismissDelegate; // should implement method in GtViewControllerDismissDelegate
- (void) dismissViewControllerAnimated:(BOOL) animated;

- (CGRect) frameForTopBarView:(UIView*) view;
- (CGRect) frameForBottomBarView:(UIView*) view;

@property (readwrite, retain, nonatomic) id topBarView;
@property (readwrite, retain, nonatomic) id bottomBarView;

@property (readonly, assign, nonatomic) GtNavigationControllerAnimation navigationControllerCloseAnimation;


@end

