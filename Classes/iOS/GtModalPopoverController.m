//
//	GtModalPopoverController.m
//	FishLamp
//
//	Created by Mike Fullerton on 11/23/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtModalPopoverController.h"
#import "GtViewController.h"
#import "GtNavigationControllerViewController.h"

@implementation GtModalPopoverController

static NSMutableArray* s_stack = nil;

@synthesize modal = m_modal;
@synthesize wasDismissedCallback = m_wasDismissedCallback;

+ (void) initialize
{
	if(!s_stack)
	{
		s_stack = [[NSMutableArray alloc] init];
	}
}

- (id) initWithContentViewController:(UIViewController*) controller isModal:(BOOL) isModal
{
	if((self = [self initWithContentViewController:controller]))
	{
		m_isModal = isModal;	
	}
	
	return self; 
}

- (id) initWithContentViewController:(UIViewController*) controller
{
	if((self = [super initWithContentViewController:controller]))
	{
		[s_stack addObject:self];
		self.delegate = self;
	}
	
	return self;
}

- (void) dealloc
{
	GtRelease(m_shield);
	self.delegate = nil;
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

- (void)dismissPopoverAnimated:(BOOL)animated
{
	GtReturnAutoreleased(GtRetain(self));
	self.delegate = nil;
	[self hideShieldView];
	[s_stack removeObject:self];
	[super dismissPopoverAnimated:animated];
	
	GtInvokeCallback(m_wasDismissedCallback, self);
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
	GtReturnAutoreleased(GtRetain(self));
	self.delegate = nil;
	[self hideShieldView];
	[s_stack removeObject:self];

	GtInvokeCallback(m_wasDismissedCallback, self);
}

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
	return YES;
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
	self.passthroughViews = m_shield.passThroughViewsForPopover;
}

+ (GtModalPopoverController*) presentViewController:(UIViewController*) contentController
	inViewController:(UIViewController*) viewController
	permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections
	fromRect:(CGRect) rect
	animated:(BOOL) animated
	isModal:(BOOL) isModal
{
	GtModalPopoverController* modalController = GtReturnAutoreleased([[GtModalPopoverController alloc] initWithContentViewController:contentController isModal:isModal]);
	if(arrowDirections == 0)
	{
		rect = GtRectCenterRectInRect(viewController.view.bounds, CGRectMake(0,0,20,20));
	}
	if(isModal)
	{
		[modalController showShieldForViewController:viewController];
		contentController.modalInPopover = YES;
	}
	
	[modalController presentPopoverFromRect:rect inView:viewController.view permittedArrowDirections:arrowDirections animated:animated];
	
	return modalController;
}

+ (GtModalPopoverController*) modalPopoverControllerForViewController:(UIViewController*) aController
{
	for(GtModalPopoverController* popover in s_stack)
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


@end
