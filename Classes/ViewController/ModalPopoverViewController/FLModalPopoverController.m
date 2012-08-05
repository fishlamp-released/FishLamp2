//
//	FLModalPopoverController.m
//	FishLamp
//
//	Created by Mike Fullerton on 11/23/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLModalPopoverController.h"
#import "FLViewController.h"
#import "FLNavigationControllerViewController.h"

@implementation FLModalPopoverController

static NSMutableArray* s_stack = nil;

@synthesize modal = _modal;
@synthesize wasDismissedCallback = _wasDismissedCallback;

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
		_isModal = isModal;	
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
	FLRelease(_shield);
	self.delegate = nil;
	FLSuperDealloc();
}

- (void) hideShieldView
{
	if(_shield)
	{
		[_shield hideShield];
		FLReleaseWithNil(_shield);
	}
}

- (void)dismissPopoverAnimated:(BOOL)animated
{
	FLReturnAutoreleased(FLReturnRetained(self));
	self.delegate = nil;
	[self hideShieldView];
	[s_stack removeObject:self];
	[super dismissPopoverAnimated:animated];
	
	FLInvokeCallback(_wasDismissedCallback, self);
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
	FLReturnAutoreleased(FLReturnRetained(self));
	self.delegate = nil;
	[self hideShieldView];
	[s_stack removeObject:self];

	FLInvokeCallback(_wasDismissedCallback, self);
}

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
	return YES;
}

- (UINavigationController*) navigationController
{
	if([self.contentViewController isKindOfClass:[FLNavigationControllerViewController class]])
	{
		return ((FLNavigationControllerViewController*) self.contentViewController).rootNavigationController;
	}
	
	return nil;
}

- (void) showShieldForViewController:(UIViewController*) viewController
{
	_shield = [[FLModalShield alloc] init];
	[_shield showShieldInViewController:viewController];
	self.passthroughViews = _shield.passThroughViewsForPopover;
}

+ (FLModalPopoverController*) presentViewController:(UIViewController*) contentController
	inViewController:(UIViewController*) viewController
	permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections
	fromRect:(CGRect) rect
	animated:(BOOL) animated
	isModal:(BOOL) isModal
{
	FLModalPopoverController* modalController = FLReturnAutoreleased([[FLModalPopoverController alloc] initWithContentViewController:contentController isModal:isModal]);
	if(arrowDirections == 0)
	{
		rect = FLRectCenterRectInRect(viewController.view.bounds, CGRectMake(0,0,20,20));
	}
	if(isModal)
	{
		[modalController showShieldForViewController:viewController];
		contentController.modalInPopover = YES;
	}
	
	[modalController presentPopoverFromRect:rect inView:viewController.view permittedArrowDirections:arrowDirections animated:animated];
	
	return modalController;
}

+ (FLModalPopoverController*) modalPopoverControllerForViewController:(UIViewController*) aController
{
	for(FLModalPopoverController* popover in s_stack)
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
		
		if([contentController isKindOfClass:[FLNavigationControllerViewController class]])
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
