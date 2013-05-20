//
//	GtProgressViewBaseClass.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/26/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtModalView.h"

@implementation GtModalView

@synthesize modal = m_modal;
@synthesize showDelay = m_showDelay;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.userInteractionEnabled = YES;
		self.multipleTouchEnabled = YES;
		self.autoresizesSubviews = NO;
		self.autoresizingMask = UIViewAutoresizingNone;
		self.exclusiveTouch = YES;
	}

	return self;
}

- (void) dealloc
{
	GtRelease(m_shield);
	GtSuperDealloc();
}

- (void) _addToView:(UIView*) superview
{
	[superview addSubview:self];
	[self setHidden:NO];
}

- (void) _showInSuperview:(UIView*) inSuperview
{
	if(m_showDelay)
	{
		NSTimeInterval delay = m_showDelay;
		m_showDelay = 0;
		[self performSelector:@selector(_showInSuperview:) withObject:inSuperview afterDelay:delay];
	}
	
	[self _addToView:inSuperview];
}

- (void) showInSuperview:(UIView*) inSuperview	delay:(NSTimeInterval) delay
{
	m_showDelay = delay;
	m_modal = NO;
	
	if([NSThread isMainThread])
	{
		[self _showInSuperview:inSuperview];
	}
	else
	{
		[self performSelectorOnMainThread:@selector(_showInSuperview:) withObject:inSuperview waitUntilDone:YES];
	}
}

- (void) _showInViewController:(UIViewController*) viewController
{
	if(m_showDelay)
	{
	
	
		NSTimeInterval delay = m_showDelay;
		m_showDelay = 0;
		[self performSelector:@selector(_showInViewController:) withObject:viewController afterDelay:delay];
	}
		
	UIView* superview = viewController.view;
	if(m_modal)
	{
		if(m_shield)
		{
			GtRelease(m_shield);
		}
	
		m_shield = [[GtModalShield alloc] init];
		[m_shield showShieldInViewController:viewController];
		
 //		  [[GtWindow topWindow] openShieldView:YES];
		
//		  if(DeviceIsPad())
//		  {
//			  GtModalPopoverController* popover = [GtModalPopoverController modalPopoverControllerForViewController:viewController];
//			  if(popover)
//			  {
//				  m_progressViewBaseClassFlags.inPopover = YES;
//				  
//				  UINavigationController* controller = popover.navigationController;
//				  if(controller)
//				  {
//					  [self _shieldNavigationBar:controller];
//				  }
//				  
//				  [self _shieldView:superview];
//			  }
//		  }
//		  else
//		  {
//			  superview = [GtWindow topWindow].shieldView.rotatingView;
//		  }
	}
		
	[self _addToView:superview]; 
}

- (void) showInViewController:(UIViewController*) viewController   isModal:(BOOL) isModal delay:(NSTimeInterval) delay
{
	m_showDelay = delay;
	m_modal = isModal;

	if([NSThread isMainThread])
	{
		[self _showInViewController:viewController];
	}
	else
	{
		[self performSelectorOnMainThread:@selector(_showInViewController:) withObject:viewController waitUntilDone:YES];
	}

}

- (void) hideModalView
{
   [NSObject cancelPreviousPerformRequestsWithTarget:self];

	if([NSThread isMainThread])
	{
		if(self.superview)
		{
			[self setHidden:YES];
			[self removeFromSuperview];

//			  if(self.isModal)
//			  {
//				  [[GtWindow topWindow] closeShieldView:YES];
//			  }
			
			if(m_shield)
			{
				[m_shield hideShield];
				GtReleaseWithNil(m_shield);
			}
		}
	}
	else
	{
		[self performSelectorOnMainThread:@selector(hideModalView) withObject:nil waitUntilDone:YES];
	}
}


@end
