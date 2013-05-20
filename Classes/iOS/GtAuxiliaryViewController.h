//
//  GtAuxiliaryViewController.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/16/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtDragController.h"
#import "GtCallback.h"

typedef enum { 
    GtAuxiliaryViewControllerPinnedSideLeft,
    GtAuxiliaryViewControllerPinnedSideRight,
    GtAuxiliaryViewControllerPinnedSideBottom,
    GtAuxiliaryViewControllerPinnedSideTop
} GtAuxiliaryViewControllerPinnedSide;

@protocol GtAuxiliaryViewControllerBehavior;

@interface GtAuxiliaryViewController : NSObject<GtDragControllerDelegate> {
@private
    UIViewController* m_parentViewController; // not retained.
    UIViewController* m_viewController;
    UIView* m_containerView;
    id<GtAuxiliaryViewControllerBehavior> m_behavior;
    GtAuxiliaryViewControllerPinnedSide m_side;
    GtCallback m_createViewController;
    GtCallback m_createTouchableView;
    GtDragController* m_dragController;
}

@property (readonly, retain, nonatomic) GtDragController* dragController;

@property (readwrite, retain, nonatomic) UIViewController* viewController;

@property (readonly, assign, nonatomic) BOOL auxiliaryViewIsOpen;

@property (readwrite, assign, nonatomic) GtCallback createViewControllerCallback;
@property (readwrite, assign, nonatomic) GtCallback createTouchableViewCallback;

@property (readonly, retain, nonatomic) UIView* view;

- (id) initWithPinnedSide:(GtAuxiliaryViewControllerPinnedSide) side
    behavior:(id<GtAuxiliaryViewControllerBehavior>) behavior;

+ (id) auxiliaryViewController:(GtAuxiliaryViewControllerPinnedSide) side
    behavior:(id<GtAuxiliaryViewControllerBehavior>) behavior;

- (void) showViewControllerAnimated:(BOOL) animated;

- (void) hideViewControllerAnimated:(BOOL) animated;

+ (id<GtAuxiliaryViewControllerBehavior>) floatingBehavior;
+ (id<GtAuxiliaryViewControllerBehavior>) hiddenBehavior;

// override points.
- (UIViewController*) createViewController; // this calls the callback by default.
- (UIView*) createTouchableView;

@end


@interface UIViewController (GtAuxiliaryViewController)
- (void) addAuxiliaryViewController:(GtAuxiliaryViewController*) controller;
@end

@interface UIView (GtTouchableAuxilaryView)
- (void) auxiliaryViewControllerDragWillBegin:(GtAuxiliaryViewController*) controller;
- (void) auxiliaryViewControllerDragDidFinish:(GtAuxiliaryViewController*) controller;
@end

@interface GtInvisibleUntilDraggedView : UIView {
@private
    BOOL m_visible;
}
@property (readwrite, assign, nonatomic) CGFloat visibleAlpha;

@end