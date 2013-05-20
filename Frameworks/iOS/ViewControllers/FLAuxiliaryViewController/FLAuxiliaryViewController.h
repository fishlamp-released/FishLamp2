//
//  FLAuxiliaryViewController.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/16/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLDraggableButtonView.h"
#import "FLDragController.h"
#import "FLAuxiliaryViewControllerBehavior.h"

typedef enum { 
    FLAuxiliaryViewControllerPinnedSideLeft,
    FLAuxiliaryViewControllerPinnedSideRight,
    FLAuxiliaryViewControllerPinnedSideBottom,
    FLAuxiliaryViewControllerPinnedSideTop
} FLAuxiliaryViewControllerPinnedSide;

@class FLAuxiliaryViewController;
@class FLAuxiliaryView;

typedef void (^FLAuxiliaryViewControllerBlock)(FLAuxiliaryViewController* controller);

typedef UIViewController* (^FLAuxiliaryViewControllerCreateViewControllerBlock)(FLAuxiliaryViewController* controller);

@interface FLAuxiliaryViewController : NSObject<FLDragControllerDelegate> {
@private
    __unsafe_unretained UIViewController* _parentViewController; // not retained.
    UIViewController* _viewController;
    FLAuxiliaryView* _containerView;
    id<FLAuxiliaryViewControllerBehavior> _behavior;
    FLAuxiliaryViewControllerPinnedSide _side;
    FLAuxiliaryViewControllerCreateViewControllerBlock _createViewController;
    FLAuxiliaryViewControllerBlock _addTouchableViewsCallback;
    FLDragController* _dragController;
    FLDraggableButtonView* _draggableButton;
}

@property (readonly, strong, nonatomic) FLDraggableButtonView* draggableButton;

@property (readonly, strong, nonatomic) FLDragController* dragController;

@property (readwrite, strong, nonatomic) UIViewController* viewController;

@property (readonly, assign, nonatomic) BOOL auxiliaryViewIsOpen;

@property (readwrite, strong, nonatomic) FLAuxiliaryViewControllerCreateViewControllerBlock onCreateViewController;

@property (readwrite, strong, nonatomic) FLAuxiliaryViewControllerBlock onAddTouchableViews;

@property (readonly, strong, nonatomic) UIView* view;

- (id) initWithPinnedSide:(FLAuxiliaryViewControllerPinnedSide) side
                 behavior:(id<FLAuxiliaryViewControllerBehavior>) behavior;

+ (id) auxiliaryViewController:(FLAuxiliaryViewControllerPinnedSide) side
                      behavior:(id<FLAuxiliaryViewControllerBehavior>) behavior;

- (void) showViewControllerAnimated:(BOOL) animated;

- (void) hideViewController:(BOOL) animated;

+ (id<FLAuxiliaryViewControllerBehavior>) aboveBehavior;
+ (id<FLAuxiliaryViewControllerBehavior>) belowBehavior;

// override points.
- (UIViewController*) createViewController; // this calls the callback by default.

- (void) addTouchableViews;

- (void) addInvisibleDragViewToViewController:(UIViewController*) viewController;

- (void) addDraggableButtonToView:(UIView*) view;

@end

@interface UIViewController (FLAuxiliaryViewController)

- (void) addAuxiliaryViewController:(FLAuxiliaryViewController*) controller;

/// @brief the presenting auxiliaryViewController.
/// Does nothing if not presented in Aux view controller
- (void) dismissAuxiliaryViewControllerAnimated:(BOOL) animated;

// valid only when presented in aux view controller.
@property (readonly, assign, nonatomic) FLAuxiliaryViewController* auxiliaryViewController;
@end


