//
//	GtHoverViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/14/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtHoverViewController.h"
#import "GtNavigationControllerViewController.h"
#import "GtViewController.h"
#import "GtBackgroundTaskMgr.h"
#import "GtApplication.h"

#define kAnimationDuration 0.1

@interface GtHoverViewController ()
- (BOOL) isRelatedToController:(GtHoverViewController*) controller;
@end

@interface GtHoverViewEventReceiver : NSObject<GtEventInterceptor> {
@private
	NSMutableArray* m_popupStack;
	BOOL m_propagateEvents;
	BOOL m_willDismiss;
}

//@property (readwrite, assign, nonatomic) BOOL presentingModalViewController;
@property (readonly, retain, nonatomic) NSArray* viewControllers;

- (void) addPopupViewController:(GtHoverViewController*) controller;
- (void) removePopupViewController:(GtHoverViewController*) controller;

GtSingletonProperty(GtHoverViewEventReceiver);
@end

@implementation GtHoverViewEventReceiver
@synthesize viewControllers = m_popupStack;

GtSynthesizeSingleton(GtHoverViewEventReceiver);

- (id) init
{
	if((self = [super init]))
	{
		m_popupStack = [[NSMutableArray alloc] init];
	}

	return self;
}

- (void) addPopupViewController:(GtHoverViewController*) controller
{
	[m_popupStack addObject:controller];
}

- (void) removePopupViewController:(GtHoverViewController*) controller
{
	[m_popupStack removeObject:controller];
}

- (GtHoverViewController*) controllerFromView:(GtHoverView*) view
{
    for(GtHoverViewController* controller in m_popupStack)
    {
        if(controller.view == view)
        {   
            return controller;
        }   
    }
    return nil;
}

- (BOOL) hoverViewControllerIsInModalController:(GtHoverViewController*) controller
{
	if([GtViewController isPresentingModalViewController])
	{
		UIViewController* modalViewController = [GtViewController presentingModalViewController].modalViewController;
	
		return [controller.view isDescendantOfView:modalViewController.view];
	}
	
	return NO;
}

- (BOOL) didInterceptEvent:(UIEvent*) event
{
	if(m_popupStack.count == 0)
	{
		return NO;
	}
	
	if(event.type == UIEventTypeTouches)
	{
		NSSet* touches = [event allTouches];
		UITouch* touch = [touches anyObject];
		switch(touch.phase)
		{
			case UITouchPhaseBegan:
			{
                GtHoverViewController* topController = m_popupStack.lastObject;
				m_willDismiss = !topController.isModal && !topController.contentViewIsModal;
				m_propagateEvents = NO;
			
			// check for touch in hover view heirarchy
				UIView* touchedView = touch.view;
				UIView* view = touchedView;
				while(view)
				{
                    // if hit modal shield, propgate and return
					if([view isKindOfClass:[GtModalShieldView class]])
					{
						m_willDismiss = NO;
						m_propagateEvents = YES;
						return !m_propagateEvents;
					}
				
					if([view isKindOfClass:[GtHoverView class]])
					{
						if(view == topController.view)
						{
							m_willDismiss = NO;
							m_propagateEvents = YES;
						}
                        else
                        {
                            // don't dismiss if the popups are related
                            GtHoverViewController* controller = [self controllerFromView:(GtHoverView*) view];
                            if(controller && [controller isRelatedToController:topController])
                            {
                                m_willDismiss = NO;
                                m_propagateEvents = YES;
                            }
							
							
                        }
                        
						return !m_propagateEvents;
					}
					
					view = view.superview;
				}
				
			// check for touch in modal controller above us.
				if(	[GtViewController isPresentingModalViewController] &&
					![self hoverViewControllerIsInModalController:topController])
				{
					m_willDismiss = NO;
					m_propagateEvents = YES;
					return !m_propagateEvents;
				}
				
				
                // we're going to iterate through the top view's siblings here and
                // look for a reason not to dismiss 
				NSArray* siblings = topController.view.superview.subviews;
				for(UIView* sibling in [siblings reverseObjectEnumerator])
				{
                    // if the sibling is our top view, then stop looking for a reason not to dismiss
                    // because that means the touch was in a view below us, and we should continue
                    // dismissing.
					if(sibling == topController.view)  
					{	
						break;
					}
					
					if(touchedView == sibling || [sibling hitTest:[touch locationInView:sibling] withEvent:event] == touchedView)
					{
                        // if we get here, this means the touched view is above the top popup view in the superviews stack (our list of siblings), and we don't want to be dismissed.
                        // basically - this means there's a view above us that is supposed to receive the events and supposed to NOT
                        // dismiss the top popup.
						m_propagateEvents = YES;
						m_willDismiss = NO;
						break;
					}
				}
				
			}
			break;
 
			case UITouchPhaseCancelled:
			break;
			
			case UITouchPhaseMoved:
			case UITouchPhaseStationary:
			break;
			
			case UITouchPhaseEnded:
				if(m_willDismiss)
				{
                    GtHoverViewController* pop = m_popupStack.lastObject;
                
                    if(pop.parentHoverViewController)
                    {
                        [pop.parentHoverViewController dismissHoverViewAnimated:YES];
                    }
                    else
                    {
                        [pop dismissHoverViewAnimated:YES];
                    }
				}
			break;
		
		}
	}	
	
	return !m_propagateEvents;
}

- (void) dealloc
{
	GtRelease(m_popupStack);
	[[GtApplication sharedApplication].keyWindow removeEventInterceptor:self];
	GtSuperDealloc();
}

@end 

@interface GtHoverViewController ()
@property (readwrite, assign, nonatomic) GtHoverViewController* parentHoverViewController;
@end

@implementation GtHoverViewController

@synthesize wasDismissedCallback = m_wasDismissedCallback;
@synthesize contentViewController = m_contentController;
@synthesize view = m_view;
@synthesize childHoverViewController = m_childPopover;
@synthesize parentHoverViewController = m_parentPopover;

GtSynthesizeStructProperty(contentViewIsModal, setContentViewIsModal, BOOL, m_state);

- (BOOL) isRelatedToController:(GtHoverViewController*) controller
{
    if(m_childPopover == controller || m_parentPopover == controller)
    {
        return YES;
    }
    
    return NO;
}

- (void) setChildHoverViewController:(GtHoverViewController *)childHoverViewController
{
    GtAssignObject(m_childPopover, childHoverViewController);
    if(childHoverViewController.parentHoverViewController != self)
    {
        childHoverViewController.parentHoverViewController = self;
    }
}

- (void) setParentHoverViewController:(GtHoverViewController *)parentHoverViewController
{
    m_parentPopover = parentHoverViewController;
    if(m_parentPopover.childHoverViewController != self)
    {
        m_parentPopover.childHoverViewController = self;
    }
}

- (BOOL) isModal
{	
	return m_state.style == GtHoverViewStyleModal;
}

+ (void) initialize
{
	static BOOL s_init = NO;
	if(!s_init)
	{	
		s_init = YES;
		[[GtApplication sharedApplication].keyWindow addEventInterceptor:[GtHoverViewEventReceiver instance]];
	}
}

- (id) initWithContentViewController:(UIViewController*) controller
{
	if((self = [super init]))
	{
		m_contentController = GtRetain(controller);
		[[GtHoverViewEventReceiver instance] addPopupViewController:self];
	}
	
	return self;
}

+ (GtHoverViewController*) hoverViewController:(UIViewController*) controller
{
    return GtReturnAutoreleased([[GtHoverViewController alloc] initWithContentViewController:controller]);
}

- (void) setParentPopover:(GtHoverViewController*) parent
{
    m_parentPopover = parent;
}

- (void) dismissChild
{
    if(m_childPopover)
    {
        [m_childPopover setParentPopover:nil];
        [m_childPopover dismissHoverViewAnimated:YES];
        GtReleaseWithNil(m_childPopover);
    }
}

- (void) setChildPopoverViewController:(GtHoverViewController*) child
{
    if(child != m_childPopover)
    {
        if(m_childPopover)
        {
            [self dismissChild];
        }
        GtAssignObject(m_childPopover, child);
        [m_childPopover setParentPopover:self];
    }
}   

- (void) dealloc
{
    GtRelease(m_childPopover);
	GtRelease(m_contentController);
	GtRelease(m_shield);
	GtRelease(m_view);
	GtSuperDealloc();
}

- (void) hideShieldView
{
	if(m_shield)
	{
		[m_shield hideShield];
		GtReleaseWithNil(m_shield);
	}
}

- (BOOL) backgroundTaskMgrCanBeginBackgroundTasks:(GtBackgroundTaskMgr*) mgr
{
    return !self.isModal;
}

- (void)dismissHoverViewAnimated:(BOOL)animated
{
	GtReturnAutoreleased(GtRetain(self));
#if DEBUG
    GtAssert(m_state.dismissed == NO, @"already dismissed!");
    m_state.dismissed = YES;
#endif
    if(m_childPopover)
    {
        [self dismissChild];
    }
   
	[m_contentController viewWillDisappear:YES];
	[m_contentController viewDidDisappear:YES];

	[self hideShieldView];

	[[GtHoverViewEventReceiver instance] removePopupViewController:self];

	[m_view removeFromSuperviewWithAnimationType:GtViewAnimationTypeFade duration:kAnimationDuration finishedBlock:nil];
#if VIEW_AUTOLAYOUT
	m_view.viewDelegate = nil;
#endif
	
	GtInvokeCallback(m_wasDismissedCallback, self);
    
    [[GtBackgroundTaskMgr instance] removeDelegate:self];
}

- (UINavigationController*) navigationController
{
	if([self.contentViewController isKindOfClass:[GtNavigationControllerViewController class]])
	{
		return ((GtNavigationControllerViewController*) self.contentViewController).rootNavigationController;
	}
	
	return nil;
}

- (void) showShieldForViewController:(UIViewController*) viewController
{
	m_shield = [[GtModalShield alloc] init];
	[m_shield showShieldInViewController:viewController];
}

- (void) presentInViewController:(UIViewController*) viewController
         permittedArrowDirection:(GtHoverViewControllerArrowDirection)arrowDirection
            fromPositionProvider:(id) provider
                           style:(GtHoverViewStyle) style
                        animated:(BOOL) animated
{
    m_state.style = style;

    if(self.isModal)
	{
		[self showShieldForViewController:viewController];
		self.contentViewController.modalInPopover = YES;
	}

	m_view = [[GtHoverView alloc] initWithFrame:CGRectMake(0,0,400,400)]; // arbritrary size which will be reset below to hoverViewContentSize
	m_view.positionProvider = provider;
	m_view.arrowDirection = (GtHoverViewArrowDirection) arrowDirection;
	m_view.containedView = m_contentController.view;

#if VIEW_AUTOLAYOUT
	if([viewController conformsToProtocol:@protocol(GtViewDelegate)])
	{
		m_view.viewDelegate = (id<GtViewDelegate>) viewController;
	}
#endif
	
	if(self.isModal)
	{
		[m_view addShadow:[UIColor grayColor]];
	}
	else
	{
		[m_view addShadow:[UIColor blackColor]];
	}

    [viewController.view addSubview:m_view];
    
    [[GtBackgroundTaskMgr instance] addDelegate:self];
    
	[m_contentController viewWillAppear:YES];
    [m_contentController willShowInHoverViewController:self];

	[m_contentController viewDidAppear:YES];
    [m_contentController didShowInHoverViewController:self];
    [m_view setNeedsLayout];
    [m_view layoutIfNeeded];
	[m_view animateOntoScreen:GtViewAnimationTypeFade duration:kAnimationDuration finishedBlock:nil];
}

- (CGSize) contentViewSize
{
	return m_view.hoverViewContentSize;
}

- (void)setContentViewSize:(CGSize)size animated:(BOOL)animated
{
    GtAssert(!GtSizeIsEmpty(size), @"empty size");
    GtAssert(size.height > 0, @"invalid height");
    GtAssert(size.width > 0, @"invalid width");

	[m_view setHoverViewContentSize:size animated:animated];
}

- (void)setContentViewSize:(CGSize)size 
{
	[self setContentViewSize:size animated:YES];
}

+ (GtHoverViewController*) modalPopoverControllerForViewController:(UIViewController*) aController
{
	for(GtHoverViewController* popover in [GtHoverViewEventReceiver instance].viewControllers)
	{
		UIViewController* contentController = popover.contentViewController;

		if(contentController == aController)
		{
			return popover;
		}
		
		if([contentController isKindOfClass:[UINavigationController class]])
		{
			if([((id) contentController) containsViewController:aController])
			{
				return popover;
			}
		}
		
		if([contentController isKindOfClass:[GtNavigationControllerViewController class]])
		{
			if([[((id) contentController) rootNavigationController] containsViewController:aController])
			{
				return popover;
			}
		}
		
		if(contentController.navigationController)
		{
			if(contentController.navigationController.rootViewController == aController)
			{
				return popover;
			}
		}

	}

	return nil;
}

+ (UIViewController*) defaultParentViewController
{
    return [[GtNotificationDisplayManager defaultDisplayManager] defaultViewController];
}

@end

#if HOVERVIEW_DEPRECATED

@implementation GtHoverViewController (Presentation)

+ (GtHoverViewController*) presentViewController:(UIViewController*) contentController
	inViewController:(UIViewController*) viewController
	permittedArrowDirection:(GtHoverViewControllerArrowDirection)arrowDirection
	fromObject:(id)object
	animated:(BOOL) animated
	isModal:(BOOL) isModal
{
	
	GtHoverViewController* modalController = GtReturnAutoreleased([[GtHoverViewController alloc] initWithContentViewController:contentController]);

	if(isModal)
	{
        [modalController showShieldForViewController:viewController];
		contentController.modalInPopover = YES;
	}
	
	[modalController presentInViewController:viewController permittedArrowDirection:arrowDirection fromPositionProvider:object style:GtHoverViewStyleModal animated:animated];
	
	return modalController;
}

+ (GtHoverViewController*) presentViewController:(UIViewController*) contentController
	permittedArrowDirections:(GtHoverViewControllerArrowDirection)arrowDirections
	fromObject:(id) object
	animated:(BOOL) animated
	isModal:(BOOL) isModal
{
	GtAssert(arrowDirections == GtHoverViewControllerArrowDirectionNone || object != nil,
		@"provider not set");
	
	GtHoverViewController* controller = [GtHoverViewController presentViewController:contentController 
		inViewController:[[GtNotificationDisplayManager defaultDisplayManager] defaultViewController] 
		permittedArrowDirection:arrowDirections 
		fromObject:object 
		animated:animated 
		isModal:isModal];

	return controller;
}

+ (GtHoverViewController*) presentViewController:(UIViewController*) contentController
                        permittedArrowDirections:(GtHoverViewControllerArrowDirection)arrowDirections
                                      fromObject:(id) object
                                        animated:(BOOL) animated
{
	return [GtHoverViewController presentViewController:contentController 
                               permittedArrowDirections:arrowDirections 
                                             fromObject:object 
                                               animated:animated 
                                                isModal:NO];
}

+ (GtHoverViewController*) presentModalViewController:(UIViewController*) contentController
                                             animated:(BOOL) animated
{
	return [GtHoverViewController presentViewController:contentController 
                               permittedArrowDirections:0 
                                             fromObject:nil 
                                               animated:animated 
                                                isModal:YES];
}

+ (GtHoverViewController*) presentModalViewController:(UIViewController*) contentController
                             permittedArrowDirections:(GtHoverViewControllerArrowDirection)arrowDirections
                                           fromObject:(id) object
                                             animated:(BOOL) animated
{
	return [GtHoverViewController presentViewController:contentController 
                               permittedArrowDirections:arrowDirections 
                                             fromObject:object 
                                               animated:animated 
                                                isModal:YES];
}



@end

#endif


@implementation UIView (GtHoverViewTargetProvider)
- (CGRect) hoverViewTargetFrame
{	
	return self.bounds;
}
- (UIView*) hoverViewTargetView
{
	return self;
}
@end

@implementation GtWidget (GtHoverViewTargetProvider)
- (CGRect) hoverViewTargetFrame
{	
	return self.frame;
}
- (UIView*) hoverViewTargetView
{
	return self.view;
}
@end

@implementation UIViewController (GtHoverViewController)

- (GtHoverViewController*) hoverViewController
{
	return [GtHoverViewController modalPopoverControllerForViewController:self];
}

- (void) willShowInHoverViewController:(GtHoverViewController*) controller
{
}

- (void) didShowInHoverViewController:(GtHoverViewController*) controller
{
    [controller setContentViewSize:self.contentSizeForViewInHoverView];
}

- (CGSize) contentSizeForViewInHoverView
{
    return CGSizeZero;
}

@end
