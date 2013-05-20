//
//  GtAuxiliaryViewController.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/16/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtAuxiliaryViewController.h"
#import "GtViewController.h"

@protocol GtAuxiliaryViewControllerBehavior <NSObject>
- (UIViewController*) parentControllerForAuxiliaryViewController:(GtAuxiliaryViewController*) viewController;
- (void) addContainerViewToParentViewController:(GtAuxiliaryViewController*) viewController;
- (void) showViewControllerAnimated:(BOOL) animated viewController:(GtAuxiliaryViewController*) viewController;
- (void) hideViewControllerAnimated:(BOOL) animated viewController:(GtAuxiliaryViewController*) viewController;
- (void) didFinishDraggingWithResults:(GtViewDraggerResults) results viewController:(GtAuxiliaryViewController*) viewController;
- (CGRect) initialFrameForContainerView:(GtAuxiliaryViewController*) viewController;
- (BOOL) handleInternalTouches:(NSSet*) touches event:(UIEvent*) event viewController:(GtAuxiliaryViewController*) viewController;
- (void) didAddTouchableView:(GtAuxiliaryViewController*) viewController;
@end

@interface GtAuxiliaryViewController ()
@property (readwrite, assign, nonatomic) UIViewController* parentViewController;

@property (readwrite, assign, nonatomic) GtAuxiliaryViewControllerPinnedSide revealSide;

@property (readonly, assign, nonatomic) CGRect onscreenFrame;
@property (readonly, assign, nonatomic) CGRect offscreenFrame;
@property (readwrite, retain, nonatomic) id<GtAuxiliaryViewControllerBehavior> behavior;
- (CGRect) onscreenFrameInHostView;

- (CGRect) destRectForDraggerViewInHostView;
- (CGRect) startRectForDraggerViewInHostView;

@property (readonly, retain, nonatomic) UIView* containerView;

@end

@interface GtFloatingAuxiliaryViewBehavior : NSObject<GtAuxiliaryViewControllerBehavior> {
}
GtSingletonProperty(GtFloatingAuxiliaryViewBehavior);
@end

@interface GtHiddenAuxiliaryViewBehavior : NSObject<GtAuxiliaryViewControllerBehavior> {
}
GtSingletonProperty(GtHiddenAuxiliaryViewBehavior);
@end

@implementation GtAuxiliaryViewController

@synthesize parentViewController = m_parentViewController;
@synthesize viewController = m_viewController;
@synthesize revealSide = m_side;
@synthesize containerView = m_containerView;
@synthesize createViewControllerCallback = m_createViewController;
@synthesize createTouchableViewCallback = m_createTouchableView;
@synthesize behavior = m_behavior;
@synthesize dragController = m_dragController;

- (void) _updateStartDestinationFrame:(GtDragControllerDragDestination*) dest
{
    dest.frame = [self startRectForDraggerViewInHostView];
}

- (void) _updateEndDestinationFrame:(GtDragControllerDragDestination*) dest
{
    dest.frame = [self destRectForDraggerViewInHostView];
}

- (id) initWithPinnedSide:(GtAuxiliaryViewControllerPinnedSide) side
    behavior:(id<GtAuxiliaryViewControllerBehavior>) behavior
{
    if((self = [super init]))
    {
        self.revealSide = side;
        self.behavior = behavior;
        GtAssertNotNil(m_behavior);
        
        m_dragController = [[GtDragController alloc] init];
        m_dragController.delegate = self;
        
        [m_dragController addDragDestination:
            [GtDragControllerDragDestination dragDestination:GtCallbackMake(self, @selector(_updateStartDestinationFrame:))]];
        
        [m_dragController addDragDestination:
            [GtDragControllerDragDestination dragDestination:GtCallbackMake(self, @selector(_updateEndDestinationFrame:))]];
    }
    
    return self;
}

+ (id) auxiliaryViewController:(GtAuxiliaryViewControllerPinnedSide) side
    behavior:(id<GtAuxiliaryViewControllerBehavior>) behavior
{
    return GtReturnAutoreleased([[[self class] alloc] initWithPinnedSide:side behavior:behavior]);
}

- (void) setParentViewController:(UIViewController*) viewController
{
    GtAssignObject(m_parentViewController, viewController);
    
    m_dragController.touchableView = [self createTouchableView];
    [m_behavior didAddTouchableView:self];
    [m_dragController startDragWatcher];
}

- (UIView*) view
{
    return self.parentViewController.parentViewController.view;
}

- (UIView*) dragControllerGetHostView:(GtDragController*) controller
{
    return self.view;
}

- (void) _createViewControllerIfNeeded
{
    if(!self.viewController)
    {
        self.viewController = [self createViewController];
        self.viewController.dismissDelegate = self;
    }
}

- (CGRect) dragControllerCalculateDragBoundsInHostView:(GtDragController*) controller
{
    return CGRectUnion( [self onscreenFrameInHostView], 
                        [self destRectForDraggerViewInHostView]);
}

- (void) dragControllerWillBeginDragging:(GtDragController*) controller
{
    [self _createViewControllerIfNeeded];
    [m_dragController.touchableView auxiliaryViewControllerDragWillBegin:self];
}

- (void) dragController:(GtDragController*) controller didFinishDraggingWithResults:(GtViewDraggerResults) results
{
    [m_dragController.touchableView auxiliaryViewControllerDragDidFinish:self];
    [m_behavior didFinishDraggingWithResults:results viewController:self];
}

- (BOOL) dragController:(GtDragController*) controller didInterceptInternalTouches:(NSSet*) touches event:(UIEvent*) event
{
    return [m_behavior handleInternalTouches:touches event:event viewController:self];
}

- (BOOL) dragController:(GtDragController*) controller didInterceptExternalTouches:(NSSet*) touches event:(UIEvent*) event
{
    UITouch* touch = [touches anyObject];
    if( touch.phase == UITouchPhaseBegan && 
        self.viewController && ![touch.view isDescendantOfView:self.viewController.view])
    {
        [self hideViewControllerAnimated:YES];
        return YES;
    }
    return NO;
}

- (UIViewController*) createViewController
{
    return GtCallbackPerformWithObject(m_createViewController, self);
} 

- (UIView*) createTouchableView
{
    return GtCallbackPerformWithObject(m_createTouchableView, self);
}    

+ (id<GtAuxiliaryViewControllerBehavior>) floatingBehavior
{
    return [GtFloatingAuxiliaryViewBehavior instance];
}

+ (id<GtAuxiliaryViewControllerBehavior>) hiddenBehavior
{
    return [GtHiddenAuxiliaryViewBehavior instance];
}
                        
- (void) dealloc
{   
    m_dragController.delegate = nil;
    GtRelease(m_dragController);
    GtRelease(m_behavior);
    GtRelease(m_viewController);
    GtRelease(m_containerView);
    GtSuperDealloc();
}

- (CGRect) onscreenFrame
{
    CGRect superBounds = [m_behavior parentControllerForAuxiliaryViewController:self].view.bounds;
    
    CGRect viewFrame = m_viewController.view.bounds;
    
    switch(m_side)
    {
        case GtAuxiliaryViewControllerPinnedSideRight:
            viewFrame.origin.x = GtRectGetRight(superBounds) - viewFrame.size.width;
            viewFrame.origin.y = 0;
            viewFrame.size.height = superBounds.size.height;
        break;
        
        case GtAuxiliaryViewControllerPinnedSideLeft:
            viewFrame.origin.x = 0;
            viewFrame.origin.y = 0;
            viewFrame.size.height = superBounds.size.height;
        break;

        case GtAuxiliaryViewControllerPinnedSideBottom:
            viewFrame.origin.x = 0;
            viewFrame.origin.y = GtRectGetBottom(superBounds) - viewFrame.size.height;
            viewFrame.size.width = superBounds.size.width;
        break;
        
        case GtAuxiliaryViewControllerPinnedSideTop:
            viewFrame.origin.x = 0;
            viewFrame.origin.y = 0;
            viewFrame.size.width = superBounds.size.width;
        break;
   }
   
   return viewFrame;
}

- (CGRect) onscreenFrameInHostView
{
    UIView* parentView = [m_behavior parentControllerForAuxiliaryViewController:self].view;
    CGRect frame = [self onscreenFrame];
    return parentView != self.view ? [self.view convertRect:frame fromView:parentView] : frame;
}

- (CGRect) offscreenFrame
{
    CGRect superBounds = [m_behavior parentControllerForAuxiliaryViewController:self].view.bounds;
    
    CGRect viewFrame = m_viewController.view.bounds;
    
    switch(m_side)
    {
        case GtAuxiliaryViewControllerPinnedSideRight:
            viewFrame.origin.x = GtRectGetRight(superBounds);
            viewFrame.origin.y = 0;
            viewFrame.size.height = superBounds.size.height;
        break;
        
        case GtAuxiliaryViewControllerPinnedSideLeft:
            viewFrame.origin.x =  -(viewFrame.size.width);
            viewFrame.origin.y = 0;
            viewFrame.size.height = superBounds.size.height;
        break;
        
        case GtAuxiliaryViewControllerPinnedSideBottom:
            viewFrame.origin.x = 0;
            viewFrame.origin.y = GtRectGetBottom(superBounds) - viewFrame.size.height;
            viewFrame.size.width = superBounds.size.width;
        break;
        
        case GtAuxiliaryViewControllerPinnedSideTop:
            viewFrame.origin.x = 0;
            viewFrame.origin.y = 0;
            viewFrame.size.width = superBounds.size.width;
        break;

   }
   
   return viewFrame;
}

#define kBelowBuffer 2.0f

- (void) setViewController:(UIViewController*) viewController 
{   
    GtAssertNotNil(viewController);
    GtAssignObject(m_viewController, viewController);

    CGRect frame = [m_behavior initialFrameForContainerView:self];
    
    m_viewController.view.frame = GtRectSetOrigin(frame, 0, 0);
    
    if(m_containerView)
    {
        [m_containerView removeFromSuperview];
        GtRelease(m_containerView);
    }
        
    m_containerView = [[UIView alloc] initWithFrame:frame];
    m_containerView.autoresizesSubviews = YES;
    m_containerView.autoresizingMask = 0;
    [m_containerView addSubview:m_viewController.view];
        
    [m_behavior addContainerViewToParentViewController:self];
}   

- (void) showViewControllerAnimated:(BOOL) animated
{
    [self _createViewControllerIfNeeded];
    [m_behavior showViewControllerAnimated:animated viewController:self];
}

- (void) _hideAnimationFinished
{
    [m_dragController removeDragResponder:m_containerView];
    [m_dragController removeDragResponder:m_parentViewController.view];

    [m_containerView removeFromSuperview];
    GtReleaseWithNil(m_containerView);

    [m_viewController.view removeFromSuperview];
    [m_viewController removeFromParentViewController];
    GtReleaseWithNil(m_viewController);
}

- (void) hideViewControllerAnimated:(BOOL) animated
{
    [m_behavior hideViewControllerAnimated:animated viewController:self];
}      

- (CGRect) destRectForDraggerViewInHostView
{
    UIView* view = self.view;
    CGRect frame = [m_dragController touchableViewFrameInHostView];
    CGRect limit = [self onscreenFrameInHostView];

    switch(self.revealSide)
    {
        case GtAuxiliaryViewControllerPinnedSideBottom:
            frame.origin.x = 0;
            frame.origin.y = view.bounds.size.height - frame.size.height - limit.size.height;
            frame.size.width = view.bounds.size.width;
        break;
        
        case GtAuxiliaryViewControllerPinnedSideRight:
            frame.origin.x = view.bounds.size.width - frame.size.width - limit.size.width;
            frame.origin.y = 0;
            frame.size.height = view.bounds.size.height;
        break;
        
        case GtAuxiliaryViewControllerPinnedSideLeft:
            frame.origin.x = frame.size.width + limit.size.width;
            frame.origin.y = 0;
            frame.size.height = view.bounds.size.height;
        break;
        
        case GtAuxiliaryViewControllerPinnedSideTop:
            frame.origin.x = 0;
            frame.origin.y = limit.size.width + frame.size.width;
            frame.size.width = view.bounds.size.width;
        break;
        
    }
    
    return frame;
}

- (CGRect) startRectForDraggerViewInHostView
{
    UIView* view = self.view;

    CGRect frame = [m_dragController touchableViewFrameInHostView];
    
    switch(self.revealSide)
    {
        case GtAuxiliaryViewControllerPinnedSideBottom:
            frame.origin.x = 0;
            frame.origin.y = view.bounds.size.height - frame.size.height;
            frame.size.width = view.bounds.size.width;
        break;
        
        case GtAuxiliaryViewControllerPinnedSideRight:
            frame.origin.x = view.bounds.size.width - frame.size.width;
            frame.origin.y = 0;
            frame.size.height = view.bounds.size.height;
        break;
        
        case GtAuxiliaryViewControllerPinnedSideLeft:
            frame.origin.x = 0;
            frame.origin.y = view.bounds.size.height - frame.size.height;
            frame.size.height = view.bounds.size.height;
        break;
        
        case GtAuxiliaryViewControllerPinnedSideTop:
            frame.origin.x = 0;
            frame.origin.y = view.bounds.size.height - frame.size.height;
            frame.size.width = view.bounds.size.width;
        break;
        
    }

    return frame;
}


- (BOOL) auxiliaryViewIsOpen
{
    return CGRectEqualToRect([m_dragController touchableViewFrameInHostView], [self destRectForDraggerViewInHostView]);
}

- (void) viewControllerDismissDelegate:(UIViewController*) viewController dismissViewControllerAnimated:(BOOL) animated
{
    [self hideViewControllerAnimated:animated];
}

@end


@implementation GtHiddenAuxiliaryViewBehavior

GtSynthesizeSingleton(GtHiddenAuxiliaryViewBehavior);

- (UIViewController*) parentControllerForAuxiliaryViewController:(GtAuxiliaryViewController*) viewController
{
    return viewController.parentViewController.parentViewController;
}

- (void) addContainerViewToParentViewController:(GtAuxiliaryViewController*) viewController
{
    [viewController.parentViewController.parentViewController addChildViewController:viewController.viewController];
    [viewController.parentViewController.parentViewController.view insertSubview:viewController.containerView belowSubview:viewController.parentViewController.view];
    [viewController.dragController addDragResponder:viewController.parentViewController.view];
}

- (CGRect) scrollDestinationRectForBelowStyle:(GtAuxiliaryViewController*) viewController
{
    CGRect onScreenFrame = [viewController onscreenFrame];
    UIView* view = viewController.parentViewController.view;
    CGRect frame; 
    switch(viewController.revealSide)
    {
        case GtAuxiliaryViewControllerPinnedSideRight:
            frame = GtRectSetLeft(view.frame, view.superview.bounds.origin.x - onScreenFrame.size.width - kBelowBuffer);    
        break;
        
        case GtAuxiliaryViewControllerPinnedSideLeft:
            frame = GtRectSetLeft(view.frame, view.superview.bounds.origin.x + onScreenFrame.size.width + kBelowBuffer);    
        break;

        case GtAuxiliaryViewControllerPinnedSideBottom:
            frame = GtRectSetTop(view.frame, view.superview.bounds.origin.y - onScreenFrame.size.height - kBelowBuffer);    
        break;
        
        case GtAuxiliaryViewControllerPinnedSideTop:
            frame = GtRectSetTop(view.frame, view.superview.bounds.origin.y + onScreenFrame.size.height + kBelowBuffer);    
        break;
    }            

    return frame;
}

- (void) showViewControllerAnimated:(BOOL) animated viewController:(GtAuxiliaryViewController*) viewController
{
    if(viewController.revealSide == GtAuxiliaryViewControllerPinnedSideBottom)
    {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }

    CGPoint delta = GtPointSubtractPointFromPoint([self scrollDestinationRectForBelowStyle:viewController].origin, viewController.parentViewController.view.frame.origin);
            
    [viewController.dragController moveDragRespondersByAmount:delta animationDuration:0.3 animationFinished:nil];
}

- (void) hideViewControllerAnimated:(BOOL) animated viewController:(GtAuxiliaryViewController*) viewController
{
    if(viewController.revealSide == GtAuxiliaryViewControllerPinnedSideBottom)
    {
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    }

    CGPoint delta = GtPointSubtractPointFromPoint(viewController.parentViewController.view.superview.bounds.origin, viewController.parentViewController.view.frame.origin);

    [viewController.dragController moveDragRespondersByAmount:delta animationDuration:0.3 animationFinished:^{ [viewController _hideAnimationFinished]; }];
} 

- (void) didFinishDraggingWithResults:(GtViewDraggerResults) results viewController:(GtAuxiliaryViewController*) viewController
{    
    CGRect frame = [viewController.dragController touchableViewFrameInHostView];
    
    if( results.userDidTouchView &&
        results.lastTouchInTouchableView &&
        !results.didDragView)
    {
        if(CGRectEqualToRect(frame, [viewController startRectForDraggerViewInHostView]))
        {
            [viewController showViewControllerAnimated:YES];
        }
        else
        {
            [viewController hideViewControllerAnimated:YES];
        }
        
    }
    else
    {
        if(CGRectEqualToRect(frame, [viewController startRectForDraggerViewInHostView]))
        {
            [viewController hideViewControllerAnimated:NO];
        }
        else
        {
            if(viewController.revealSide == GtAuxiliaryViewControllerPinnedSideBottom)
            {
                [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
            }
        }
    }
}

- (CGRect) initialFrameForContainerView:(GtAuxiliaryViewController*) viewController
{
    return [viewController onscreenFrame];
}

- (BOOL) handleInternalTouches:(NSSet*) touches event:(UIEvent*) event viewController:(GtAuxiliaryViewController*) viewController
{
    return YES;
}

- (void) didAddTouchableView:(GtAuxiliaryViewController*) viewController
{
}

@end


@implementation GtFloatingAuxiliaryViewBehavior

GtSynthesizeSingleton(GtFloatingAuxiliaryViewBehavior);

- (BOOL) handleInternalTouches:(NSSet*) touches event:(UIEvent*) event viewController:(GtAuxiliaryViewController*) viewController
{
    return YES;
}

- (UIViewController*) parentControllerForAuxiliaryViewController:(GtAuxiliaryViewController*) viewController
{
    return viewController.parentViewController;
}

- (void) addContainerViewToParentViewController:(GtAuxiliaryViewController*) viewController
{
    [viewController.parentViewController addChildViewController:viewController.viewController];
    [viewController.parentViewController.view addSubview:viewController.containerView];
    [viewController.dragController addDragResponder:viewController.containerView];
}

- (void) showViewControllerAnimated:(BOOL) animated viewController:(GtAuxiliaryViewController*) viewController
{
    CGPoint delta = GtPointSubtractPointFromPoint([viewController onscreenFrame].origin, viewController.containerView.frame.origin);
    [viewController.dragController moveDragRespondersByAmount:delta animationDuration:0.3 animationFinished:nil];
}

- (void) hideViewControllerAnimated:(BOOL) animated viewController:(GtAuxiliaryViewController*) viewController
{
    if(viewController.viewController)
    {
        CGPoint delta = GtPointSubtractPointFromPoint([viewController offscreenFrame].origin, viewController.containerView.frame.origin);
        [viewController.dragController moveDragRespondersByAmount:delta animationDuration:0.3 animationFinished:^{ [viewController _hideAnimationFinished]; }];
    }
} 

- (void) didFinishDraggingWithResults:(GtViewDraggerResults) results viewController:(GtAuxiliaryViewController*) viewController
{
    CGRect frame = [viewController.dragController touchableViewFrameInHostView];
    
    BOOL cleanUp = YES;

    if( results.userDidTouchView &&
        results.lastTouchInTouchableView &&
        !results.didDragView)
    {
        if(CGRectEqualToRect(frame, [viewController destRectForDraggerViewInHostView]))
        {
            cleanUp = NO;
            
            [viewController hideViewControllerAnimated:YES];
        }
    }
    
    if(cleanUp)
    {
        if(CGRectEqualToRect(frame, [viewController startRectForDraggerViewInHostView]))
        {
            [viewController hideViewControllerAnimated:NO];
        }
    }
}

- (CGRect) initialFrameForContainerView:(GtAuxiliaryViewController*) viewController
{
    return [viewController offscreenFrame];
}

- (void) didAddTouchableView:(GtAuxiliaryViewController*) viewController
{
    [viewController.dragController addDragResponder:viewController.dragController.touchableView];
}

@end

@implementation UIView (GtTouchableAuxilaryView)

- (void) auxiliaryViewControllerDragWillBegin:(GtAuxiliaryViewController*) controller
{
}

- (void) auxiliaryViewControllerDragDidFinish:(GtAuxiliaryViewController*) controller
{
}

@end


@implementation UIViewController (GtAuxiliaryViewController)
- (void) addAuxiliaryViewController:(GtAuxiliaryViewController*) controller
{
    controller.parentViewController = self;
}
@end

#define kInvisibleAlpha 0.0

@implementation GtInvisibleUntilDraggedView

@synthesize visibleAlpha = m_visibleAlpha;

- (id) initWithFrame:(CGRect) frame
{
    if((self = [super initWithFrame:frame]))
    {   
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 1.0;
        self.visibleAlpha = 1.0f;
        self.autoresizesSubviews = YES;

        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0;
        self.layer.shadowRadius = 20.0;
        self.layer.shadowOffset = CGSizeMake(0,3);
    }
    
    return self;
}

- (void) addSubview:(UIView*) view
{
    view.hidden = YES;
    [super addSubview:view];
}

- (void) showSubviewsWithFade:(CGFloat) duration
{
    NSArray* subviews = self.subviews;
    NSMutableArray* alphas = [NSMutableArray array];
    
    for(UIView* view in subviews)
    {
        view.hidden = NO;
        [alphas addObject:[NSNumber numberWithFloat:view.alpha]];
        view.alpha = 0;
    }
    [UIView animateWithDuration:duration
            delay:0.0f
            options:UIViewAnimationOptionCurveEaseInOut
            animations:^{
                NSUInteger alphaIndex = 0;
                for(UIView* view in subviews)
                {
                    view.alpha = [[alphas objectAtIndex:alphaIndex++] floatValue];
                }        
                self.layer.shadowOpacity = .8;
            } 
            completion:^(BOOL completed) {
                m_visible = YES;        
            }
        ];
}

- (void) hideSubviewsWithFade:(CGFloat) duration
{
    NSArray* subviews = self.subviews;
    NSMutableArray* alphas = [NSMutableArray array];
    
    for(UIView* view in subviews)
    {
        [alphas addObject:[NSNumber numberWithFloat:view.alpha]];
    }
    [UIView animateWithDuration:duration
            delay:0.0f
            options:UIViewAnimationOptionCurveEaseInOut
            animations:^{
                for(UIView* view in subviews)
                {
                    view.alpha = 0.0;
                }
                self.layer.shadowOpacity = 0;
            } 
            completion:^(BOOL completed) {
                NSUInteger alphaIndex = 0;
                for(UIView* view in subviews)
                {
                    view.hidden = YES;
                    view.alpha = [[alphas objectAtIndex:alphaIndex++] floatValue];
                }
                m_visible = NO;        
            }
        ];
}

- (void) auxiliaryViewControllerDragWillBegin:(GtAuxiliaryViewController*) controller
{
    if(!m_visible)
    {
        [self showSubviewsWithFade:0.15];
    }
    self.alpha = 0.5;
}

- (void) auxiliaryViewControllerDragDidFinish:(GtAuxiliaryViewController*) controller
{
    if(!controller.auxiliaryViewIsOpen && m_visible)
    {
        [self hideSubviewsWithFade:0.15];
    }
    self.alpha = 1.0;
}

@end
