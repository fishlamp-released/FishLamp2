//
//	FLFloatingViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/14/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLAutoPositionedViewController.h"
#import "FLFloatingView.h"

#import "FLBackgroundTaskMgr.h"

@protocol FLFloatingViewTargetProvider <NSObject>
- (CGRect) floatingViewTargetFrame;
- (UIView*) floatingViewTargetView;
@end

typedef enum {
	FLFloatingViewControllerArrowDirectionNone  = FLFloatingViewArrowDirectionNone,
	FLFloatingViewControllerArrowDirectionUp    = FLFloatingViewArrowDirectionUp,
	FLFloatingViewControllerArrowDirectionDown  = FLFloatingViewArrowDirectionDown,
	FLFloatingViewControllerArrowDirectionLeft  = FLFloatingViewArrowDirectionLeft,
	FLFloatingViewControllerArrowDirectionRight = FLFloatingViewArrowDirectionRight,
} FLFloatingViewControllerArrowDirection;

extern NSString *const FLPopoverViewWasResized;

@interface FLFloatingViewController : FLAutoPositionedViewController<FLBackgroundTaskMgrDelegate> {
@private
	UIViewController* _contentViewController;
	FLCallback _wasDismissedCallback;	  
    id _positionProvider;

    FLFloatingViewController* _childPopover;
    FLFloatingViewController* _parentPopover;

	CGSize _contentViewSize;
    FLFloatingViewControllerArrowDirection _arrowDirection;
    
	struct {
		unsigned int contentViewIsModal:1;
		unsigned int adjustingForKeyboard: 1;
	} _state;
}

@property (readonly, retain, nonatomic) UIViewController *contentViewController;
@property (readonly, retain, nonatomic) FLFloatingView* floatingView;

@property (readwrite, assign, nonatomic) id positionProvider;
@property (readwrite, assign, nonatomic) FLCallback wasDismissedCallback;
@property (readwrite, assign, nonatomic) CGSize contentViewSize; // setting with this makes animated:YES
- (void) setContentViewSize:(CGSize)size animated:(BOOL)animated;

// children
@property (readonly, assign, nonatomic) FLFloatingViewController* parentFloatingViewController;
@property (readwrite, retain, nonatomic) FLFloatingViewController* childFloatingViewController;

// deprecated
@property (readwrite, assign, nonatomic) BOOL contentViewIsModal;

@end

@interface FLWidget (FLFloatingViewTargetProvider)
- (CGRect) floatingViewTargetFrame;
- (UIView*) floatingViewTargetView;
@end

@interface UIView (FLFloatingViewTargetProvider)
- (CGRect) floatingViewTargetFrame;
- (UIView*) floatingViewTargetView;
@end

@interface UIViewController (FLFloatingViewController)

@property (readonly, assign, nonatomic) FLFloatingViewController* floatingViewController;
@property (readwrite, assign, nonatomic) CGSize contentSizeForViewInFloatingView;

- (FLFloatingViewController*) presentFloatingViewController:(UIViewController*) controller
                                 permittedArrowDirection:(FLFloatingViewControllerArrowDirection)arrowDirection
                                    fromPositionProvider:(id) provider
                                            withBehavior:(id<FLPresentationBehavior>) behavior
                                            withAnimation:(id<FLViewControllerTransitionAnimation>) animation;

- (FLFloatingViewController*) presentFloatingViewController:(UIViewController*) controller
                                               withBehavior:(id<FLPresentationBehavior>) behavior
                                              withAnimation:(id<FLViewControllerTransitionAnimation>) animation;

- (FLFloatingViewController*) presentFloatingViewController:(UIViewController*) controller
    animated:(BOOL) animated;
- (FLFloatingViewController*) presentModalFloatingViewController:(UIViewController*) controller
    animated:(BOOL) animated;

@end