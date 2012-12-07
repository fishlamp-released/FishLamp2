//
//  FLAuxiliaryViewController.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/16/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLAuxiliaryViewController.h"
#import "FLViewController.h"

#import "FLWidgetView.h"
#import "FLGradientWidget.h"
#import "FLColorRange.h"


#import "_FLAuxiliaryViewController.h"
#import "FLBelowAuxiliaryViewController.h"
#import "FLAboveAuxiliaryViewBehavior.h"
#import "FLAuxiliaryView.h"

@implementation UIViewController (FLAuxiliaryViewController)

FLSynthesizeAssociatedProperty(assign_nonatomic, _auxiliaryViewController, setAuxiliaryViewController, FLAuxiliaryViewController*)

- (FLAuxiliaryViewController*) auxiliaryViewController {
    FLAuxiliaryViewController* controller = self._auxiliaryViewController;
    return controller ? controller : self.parentViewController.auxiliaryViewController;
}

- (void) addAuxiliaryViewController:(FLAuxiliaryViewController*) controller {
    controller.parentViewController = self;
}

- (void) dismissAuxiliaryViewControllerAnimated:(BOOL) animated {
    FLAuxiliaryViewController* controller = [self auxiliaryViewController];
    if(controller) {
        [controller hideViewControllerAnimated:animated];
    }
}

@end

@implementation FLAuxiliaryViewController 

@synthesize parentViewController = _parentViewController;
@synthesize viewController = _viewController;
@synthesize revealSide = _side;
@synthesize containerView = _containerView;
@synthesize onCreateViewController = _createViewController;
@synthesize onAddTouchableViews = _addTouchableViewsCallback;
@synthesize behavior = _behavior;
@synthesize dragController = _dragController;
@synthesize draggableButton = _draggableButton;

- (void) _updateStartDestinationFrame:(FLDragControllerDragDestination*) dest {
    dest.frame = [self startRectForDraggerViewInHostView];
}

- (void) _updateEndDestinationFrame:(FLDragControllerDragDestination*) dest {
    dest.frame = [self destRectForDraggerViewInHostView];
}

- (id) initWithPinnedSide:(FLAuxiliaryViewControllerPinnedSide) side
    behavior:(id<FLAuxiliaryViewControllerBehavior>) behavior {
    if((self = [super init])) {
        self.revealSide = side;
        self.behavior = behavior;
        FLAssertIsNotNil_(_behavior);
        
        _dragController = [[FLDragController alloc] init];
        _dragController.delegate = self;
        
        [_dragController addDragDestination:
            [FLDragControllerDragDestination dragDestination:FLCallbackMake(self, @selector(_updateStartDestinationFrame:))]];
        
        [_dragController addDragDestination:
            [FLDragControllerDragDestination dragDestination:FLCallbackMake(self, @selector(_updateEndDestinationFrame:))]];
    }
    
    return self;
}

+ (id) auxiliaryViewController:(FLAuxiliaryViewControllerPinnedSide) side
    behavior:(id<FLAuxiliaryViewControllerBehavior>) behavior {
    return FLAutorelease([[[self class] alloc] initWithPinnedSide:side behavior:behavior]);
}

- (void) setParentViewController:(UIViewController*) viewController {
    FLRetainObject_(_parentViewController, viewController);
    
    [self addTouchableViews];
    [_behavior didAddTouchableView:self];
    [_dragController startDragWatcher];
}

- (UIView*) view {
    return self.parentViewController.parentViewController.view;
}

- (UIView*) dragControllerGetHostView:(FLDragController*) controller {
    return self.view;
}

- (void) _createViewControllerIfNeeded {
    if(!self.viewController) {
        self.viewController = [self createViewController];
        FLAssertIsNotNil_(self.viewController);
        __block id me = self;
        self.viewController.dismissHandler = ^(UIViewController* controller, BOOL animated) {
            [me hideViewControllerAnimated:animated];
        };
    }
}

- (CGRect) dragControllerCalculateDragBoundsInHostView:(FLDragController*) controller {
    return CGRectUnion( [self onscreenFrameInHostView], 
                        [self destRectForDraggerViewInHostView]);
}

- (void) dragControllerWillBeginDragging:(FLDragController*) controller {
    [self _createViewControllerIfNeeded];
    [_dragController.touchableView auxiliaryViewControllerDragWillBegin:self];
    
    for(id second in _dragController.secondaryTouchableViews) {
        [second auxiliaryViewControllerDragWillBegin:self];
    }
}

- (void) dragController:(FLDragController*) controller didFinishDraggingWithResults:(FLViewDraggerResults) results {
    [_dragController.touchableView auxiliaryViewController:self didFinishDraggingWithResults:results];
    for(id second in _dragController.secondaryTouchableViews) {
        [second auxiliaryViewController:self didFinishDraggingWithResults:results];
    }

    [_behavior didFinishDraggingWithResults:results viewController:self];
}

- (BOOL) dragController:(FLDragController*) controller didInterceptInternalTouches:(NSSet*) touches event:(UIEvent*) event {
    return [_behavior handleInternalTouches:touches event:event viewController:self];
}

- (BOOL) dragController:(FLDragController*) controller didInterceptExternalTouches:(NSSet*) touches event:(UIEvent*) event {
    UITouch* touch = [touches anyObject];
    if( touch.phase == UITouchPhaseBegan && 
        self.viewController && ![touch.view isDescendantOfView:self.viewController.view]) {
        [self hideViewControllerAnimated:YES];
        return YES;
    }
    return NO;
}

- (UIViewController*) createViewController {
    if(_createViewController) {
        return _createViewController(self);
    }
    
    return nil;
} 

- (void) addTouchableViews {
    if(_addTouchableViewsCallback) {
        _addTouchableViewsCallback(self);
    }
}    

+ (id<FLAuxiliaryViewControllerBehavior>) aboveBehavior {
    return [FLAboveAuxiliaryViewBehavior instance];
}

+ (id<FLAuxiliaryViewControllerBehavior>) belowBehavior {
    return [FLBelowAuxiliaryViewBehavior instance];
}
                        
- (void) dealloc {   
    _dragController.delegate = nil;
#if FL_MRC 
    FLRelease(_createViewController);
    FLRelease(_addTouchableViewsCallback);
    FLRelease(_draggableButton);
    FLRelease(_dragController);
    FLRelease(_behavior);
    FLRelease(_viewController);
    FLRelease(_containerView);
    super_dealloc_();
#endif
}

- (CGRect) onscreenFrame {
    CGRect superBounds = [_behavior parentControllerForAuxiliaryViewController:self].view.bounds;
    
    CGRect viewFrame = _viewController.view.bounds;
    
    switch(_side) {
        case FLAuxiliaryViewControllerPinnedSideRight:
            viewFrame.origin.x = FLRectGetRight(superBounds) - viewFrame.size.width;
            viewFrame.origin.y = 0;
            viewFrame.size.height = superBounds.size.height;
        break;
        
        case FLAuxiliaryViewControllerPinnedSideLeft:
            viewFrame.origin.x = 0;
            viewFrame.origin.y = 0;
            viewFrame.size.height = superBounds.size.height;
        break;

        case FLAuxiliaryViewControllerPinnedSideBottom:
            viewFrame.origin.x = 0;
            viewFrame.origin.y = FLRectGetBottom(superBounds) - viewFrame.size.height;
            viewFrame.size.width = superBounds.size.width;
        break;
        
        case FLAuxiliaryViewControllerPinnedSideTop:
            viewFrame.origin.x = 0;
            viewFrame.origin.y = 0;
            viewFrame.size.width = superBounds.size.width;
        break;
   }
   
   return viewFrame;
}

- (void) addDraggableButtonToView:(UIView*) view {
    if(self.draggableButton) {
        [self.draggableButton removeFromSuperview];
    }

    self.draggableButton = [FLDraggableButtonView viewWithFrame:CGRectMake(0, 0, 44, 44)];

    switch(_side) {
        case FLAuxiliaryViewControllerPinnedSideRight:
            self.draggableButton.frame = FLRectSetLeft(self.draggableButton.frame, FLRectGetRight(view.bounds) - 44);
        break;
        
        case FLAuxiliaryViewControllerPinnedSideLeft:
        break;

        case FLAuxiliaryViewControllerPinnedSideBottom:
        break;
        
        case FLAuxiliaryViewControllerPinnedSideTop:
        break;
   }
    
//    self.areaButton.openButton = [FLDeprecatedButtonbarView createImageButtonByName:@"list_small.png" target:self action:@selector(showSearchPanel:)];
//    self.areaButton.closeButton = [FLDeprecatedButtonbarView createImageButtonByName:@"x.png" target:self action:@selector(hideSearchPanel:)];
    
    [view addSubview:self.draggableButton];
    [self.dragController addSecondaryTouchableView:self.draggableButton];
}

- (CGRect) onscreenFrameInHostView {
    UIView* parentView = [_behavior parentControllerForAuxiliaryViewController:self].view;
    CGRect frame = [self onscreenFrame];
    return parentView != self.view ? [self.view convertRect:frame fromView:parentView] : frame;
}

- (CGRect) offscreenFrame {
    CGRect superBounds = [_behavior parentControllerForAuxiliaryViewController:self].view.bounds;
    
    CGRect viewFrame = _viewController.view.bounds;
    
    switch(_side) {
        case FLAuxiliaryViewControllerPinnedSideRight:
            viewFrame.origin.x = FLRectGetRight(superBounds);
            viewFrame.origin.y = 0;
            viewFrame.size.height = superBounds.size.height;
        break;
        
        case FLAuxiliaryViewControllerPinnedSideLeft:
            viewFrame.origin.x =  -(viewFrame.size.width);
            viewFrame.origin.y = 0;
            viewFrame.size.height = superBounds.size.height;
        break;
        
        case FLAuxiliaryViewControllerPinnedSideBottom:
            viewFrame.origin.x = 0;
            viewFrame.origin.y = FLRectGetBottom(superBounds) - viewFrame.size.height;
            viewFrame.size.width = superBounds.size.width;
        break;
        
        case FLAuxiliaryViewControllerPinnedSideTop:
            viewFrame.origin.x = 0;
            viewFrame.origin.y = 0;
            viewFrame.size.width = superBounds.size.width;
        break;
    }
    return viewFrame;
}

- (void) setViewController:(UIViewController*) viewController  {   
    FLAssertIsNotNil_(viewController);
    FLRetainObject_(_viewController, viewController);

    viewController.auxiliaryViewController = self;

    CGRect frame = [_behavior initialFrameForContainerView:self];
    
    _viewController.view.frame = FLRectSetOrigin(frame, 0, 0);
    
    if(_containerView)
    {
        [_containerView removeFromSuperview];
        FLRelease(_containerView);
    }
        
    _containerView = [[FLAuxiliaryView alloc] initWithFrame:frame];
    _containerView.containedView = _viewController.view;
    [_behavior addContainerViewToParentViewController:self];
}   

- (void) showViewControllerAnimated:(BOOL) animated {
    [self _createViewControllerIfNeeded];
    [_behavior showViewControllerAnimated:animated viewController:self];
}

- (void) _hideAnimationFinished {
    [_dragController removeDragResponder:_containerView];
    [_dragController removeDragResponder:_parentViewController.view];

    [_containerView removeFromSuperview];
    FLReleaseWithNil_(_containerView);

    [_viewController.view removeFromSuperview];
    [_viewController removeFromParentViewController];
    self.viewController.auxiliaryViewController = nil;
    FLReleaseWithNil_(_viewController);
}

- (void) hideViewControllerAnimated:(BOOL) animated {
    [_behavior hideViewControllerAnimated:animated viewController:self];
}      

- (CGRect) destRectForDraggerViewInHostView {
    UIView* view = self.view;
    CGRect frame = [_dragController touchableViewFrameInHostView];
    CGRect limit = [self onscreenFrameInHostView];

    switch(self.revealSide)
    {
        case FLAuxiliaryViewControllerPinnedSideBottom:
            frame.origin.x = 0;
            frame.origin.y = view.bounds.size.height - frame.size.height - limit.size.height;
            frame.size.width = view.bounds.size.width;
        break;
        
        case FLAuxiliaryViewControllerPinnedSideRight:
            frame.origin.x = view.bounds.size.width - frame.size.width - limit.size.width;
            frame.origin.y = 0;
            frame.size.height = view.bounds.size.height;
        break;
        
        case FLAuxiliaryViewControllerPinnedSideLeft:
            frame.origin.x = limit.size.width;
            frame.origin.y = 0;
            frame.size.height = view.bounds.size.height;
        break;
        
        case FLAuxiliaryViewControllerPinnedSideTop:
            frame.origin.x = 0;
            frame.origin.y = limit.size.height;
            frame.size.width = view.bounds.size.width;
        break;
        
    }
    
    return frame;
}

- (CGRect) startRectForDraggerViewInHostView {
    UIView* view = self.view;

    CGRect frame = [_dragController touchableViewFrameInHostView];
    
    switch(self.revealSide) {
        case FLAuxiliaryViewControllerPinnedSideBottom:
            frame.origin.x = 0;
            frame.origin.y = view.bounds.size.height - frame.size.height;
            frame.size.width = view.bounds.size.width;
        break;
        
        case FLAuxiliaryViewControllerPinnedSideRight:
            frame.origin.x = view.bounds.size.width - frame.size.width;
            frame.origin.y = 0;
            frame.size.height = view.bounds.size.height;
        break;
        
        case FLAuxiliaryViewControllerPinnedSideLeft:
            frame.origin.x = 0;
            frame.origin.y = 0;
            frame.size.height = view.bounds.size.height;
        break;
        
        case FLAuxiliaryViewControllerPinnedSideTop:
            frame.origin.x = 0;
            frame.origin.y = 0;
            frame.size.width = view.bounds.size.width;
        break;
    }

    return frame;
}

- (BOOL) auxiliaryViewIsOpen {
    return CGRectEqualToRect([_dragController touchableViewFrameInHostView], [self destRectForDraggerViewInHostView]);
}

#define kInvisibleSize 20.0f

- (void) addInvisibleDragViewToViewController:(UIViewController*) viewController {
    CGRect bounds = viewController.view.bounds;

    CGRect frame;
    switch(self.revealSide) {
        case FLAuxiliaryViewControllerPinnedSideTop:
            frame = CGRectMake(0, 0, bounds.size.width, kInvisibleSize); 
        break;

        case FLAuxiliaryViewControllerPinnedSideBottom:
            frame = CGRectMake(0, FLRectGetBottom(bounds) - kInvisibleSize, bounds.size.width, kInvisibleSize); 
        break;
        
        case FLAuxiliaryViewControllerPinnedSideRight:
            frame = CGRectMake(FLRectGetRight(bounds) - kInvisibleSize, 0, kInvisibleSize, bounds.size.height); 
        break;
        
        case FLAuxiliaryViewControllerPinnedSideLeft:
            frame = CGRectMake(0, 0, kInvisibleSize, bounds.size.height); 
        break;
    }

    UIView* hideaView = [UIView viewWithFrame:frame];
    hideaView.backgroundColor = [UIColor clearColor];
    
    [viewController.view addSubview:hideaView];
    self.dragController.touchableView = hideaView;
}

@end

@implementation UIView (FLTouchableAuxilaryView)

- (void) auxiliaryViewControllerDragWillBegin:(FLAuxiliaryViewController*) controller {
}

- (void) auxiliaryViewController:(FLAuxiliaryViewController*) controller didFinishDraggingWithResults:(FLViewDraggerResults) results {
}

- (BOOL) auxiliaryViewControllerTapWillToggle:(FLAuxiliaryViewController*) controller {
    return NO;
}

@end




