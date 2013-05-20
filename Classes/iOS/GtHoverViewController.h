//
//	GtHoverViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/14/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtRoundRectView.h"
#import "GtModalShield.h"
#import "GtHoverView.h"
#import "GtErrorDisplayManager.h"

#import "GtBackgroundTaskMgr.h"

#define HOVERVIEW_DEPRECATED 1 

@protocol GtHoverViewTargetProvider <NSObject>
- (CGRect) hoverViewTargetFrame;
- (UIView*) hoverViewTargetView;
@end

typedef enum {
	GtHoverViewControllerArrowDirectionNone,
	GtHoverViewControllerArrowDirectionUp,
	GtHoverViewControllerArrowDirectionDown,
	GtHoverViewControllerArrowDirectionLeft,
	GtHoverViewControllerArrowDirectionRight,
} GtHoverViewControllerArrowDirection;

typedef enum {
    GtHoverViewStyleNormal,
    GtHoverViewStyleModal
} GtHoverViewStyle;

@interface GtHoverViewController : NSObject<GtBackgroundTaskMgrDelegate> {
@private
	UIViewController* m_contentController;
	GtHoverView* m_view;
	GtModalShield* m_shield;
	GtCallback m_wasDismissedCallback;	  
	
    GtHoverViewController* m_childPopover;
    GtHoverViewController* m_parentPopover;
    
	struct {
		unsigned int contentViewIsModal:1;
		unsigned int touchStartedInView:1;
		GtHoverViewStyle style:4;
#if DEBUG
        unsigned int dismissed: 1;
#endif        
	} m_state;
}

@property (readonly, assign, nonatomic) GtHoverViewController* parentHoverViewController;
@property (readwrite, retain, nonatomic) GtHoverViewController* childHoverViewController;

@property (readonly, retain, nonatomic) GtHoverView* view;
@property (readonly, retain, nonatomic) UINavigationController* navigationController; // if content controller is a GtNavigationControllerViewController, return it's rootNavigationController; 

@property (readwrite, assign, nonatomic) GtCallback wasDismissedCallback;
@property (readwrite, retain, nonatomic) UIViewController *contentViewController;

@property (readonly, assign, nonatomic) BOOL isModal;

@property (readwrite, assign, nonatomic) BOOL contentViewIsModal;

// instantiation
- (id) initWithContentViewController:(UIViewController*) controller;

+ (GtHoverViewController*) hoverViewController:(UIViewController*) controller;

// presentation
- (void) presentInViewController:(UIViewController*) viewController
         permittedArrowDirection:(GtHoverViewControllerArrowDirection)arrowDirection
            fromPositionProvider:(id) provider
                           style:(GtHoverViewStyle) style
                        animated:(BOOL) animated;

- (void)dismissHoverViewAnimated:(BOOL)animated;

// content view size
@property (readonly, assign, nonatomic) CGSize contentViewSize;
- (void) setContentViewSize:(CGSize)size animated:(BOOL)animated;

// for default presentation of hover view
+ (UIViewController*) defaultParentViewController;
+ (GtHoverViewController*) modalPopoverControllerForViewController:(UIViewController*) aController;

@end

#if HOVERVIEW_DEPRECATED

@interface GtHoverViewController (Presentation)

+ (GtHoverViewController*) presentViewController:(UIViewController*) contentController
	inViewController:(UIViewController*) inViewController
	permittedArrowDirection:(GtHoverViewControllerArrowDirection)arrowDirection
	fromObject:(id)object
	animated:(BOOL) animated
	isModal:(BOOL) isModal;

// these present in [[GtNotificationDisplayManager defaultDisplayManager] defaultViewController] 

+ (GtHoverViewController*) presentModalViewController:(UIViewController*) contentController
	animated:(BOOL) animated;
	
+ (GtHoverViewController*) presentViewController:(UIViewController*) contentController
	permittedArrowDirections:(GtHoverViewControllerArrowDirection)arrowDirections
	fromObject:(id) object
	animated:(BOOL) animated; // sending in CGSizeZero makes it ignore size

+ (GtHoverViewController*) presentModalViewController:(UIViewController*) contentController
	permittedArrowDirections:(GtHoverViewControllerArrowDirection)arrowDirections
	fromObject:(id) object
	animated:(BOOL) animated;

@end

#endif

@interface GtWidget (GtHoverViewTargetProvider)
- (CGRect) hoverViewTargetFrame;
- (UIView*) hoverViewTargetView;
@end

@interface UIView (GtHoverViewTargetProvider)
- (CGRect) hoverViewTargetFrame;
- (UIView*) hoverViewTargetView;
@end

@interface UIViewController (GtHoverViewController)
@property (readonly, assign, nonatomic) GtHoverViewController* hoverViewController;
@property (readonly, assign, nonatomic) CGSize contentSizeForViewInHoverView;
- (void) willShowInHoverViewController:(GtHoverViewController*) controller;
- (void) didShowInHoverViewController:(GtHoverViewController*) controller;
@end