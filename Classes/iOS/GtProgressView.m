//
//	GtProgressView.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/21/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtProgressView.h"
#import "GtButton.h"
#import "GtRoundRectView.h"
#import "GtErrorDisplayManager.h"

@implementation GtProgressView
GtSynthesizeStructProperty(isModal, setModal, BOOL, m_progressViewFlags);
@synthesize progressBarLabel = m_progressBarLabel;
@synthesize progressBar = m_progressBar;
@synthesize progressBarSpinner = m_progressBarSpinner;
@synthesize titleLabel = m_titleLabel;
@synthesize secondaryTextLabel = m_secondaryTextLabel;
@synthesize roundRectView = m_roundRectView;

@synthesize button = m_button;
@synthesize startDelay = m_startDelay;

- (void) dealloc
{
	GtRelease(m_progressBarLabel);
	GtRelease(m_progressBar);
	GtRelease(m_progressBarSpinner);
	GtRelease(m_titleLabel);
	GtRelease(m_secondaryTextLabel);
	GtRelease(m_button);
	GtRelease(m_roundRectView);
	GtSuperDealloc();
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	if(m_roundRectView)
	{
		m_roundRectView.newFrame = self.bounds;
	}
}

- (void) buttonPressed:(id)sender
{
	if(m_buttonTarget)
	{
		if([NSThread isMainThread])
		{
			if(m_progressViewFlags.buttonIsCancelButton)
			{
				m_button.enabled = NO;
				self.title = NSLocalizedString(@"Cancelling…", nil);
			}
		
			[m_buttonTarget performSelector:m_buttonWasPressedCallback withObject:self];
		}
		else
		{
			[self performSelectorOnMainThread:@selector(buttonPressed:) withObject:sender waitUntilDone:YES];
		}
	}
}

- (void) setButton:(GtButton*) button
{
	if(GtAssignObject(m_button, button))
	{
		[m_button setCallback:self action:@selector(buttonPressed:)];
	}
}

- (void) setButtonTarget:(id)target action:(SEL) action isCancel:(BOOL) isCancel
{
	m_progressViewFlags.buttonIsCancelButton = isCancel;
	m_buttonTarget = target;
	m_buttonWasPressedCallback = action;
}

- (void) willStartUpdatingProgressBar
{
	[m_progressBarSpinner stopAnimating];
}

- (void) updateProgress:(unsigned long long) amountWritten 
            totalAmount:(unsigned long long) totalAmount;
{
	if(m_progressBar)
	{	
		if(m_progressBar.hidden)
		{
			m_progressBar.hidden = NO;
			[self willStartUpdatingProgressBar];
		}
	
		GtAssert([NSThread isMainThread], @"not on main thread, use updateProgress:(GtProgressValue*) value");
   
		m_progressBar.progress = ((float) amountWritten) / ((float) totalAmount);
	}
}

- (NSString*) progressBarText
{
	return m_progressBarLabel.text;
}

- (void) setProgressBarText:(NSString*) text
{
	if([NSThread isMainThread])
	{	
		m_progressBarLabel.text = text;
	}
	else
	{
		[self performSelectorOnMainThread:@selector(setProgressBarText:) withObject:text waitUntilDone:YES];
	}
}

- (NSString*) title
{
	return m_titleLabel.text;
}

- (void) setTitle:(NSString*) text
{
	if([NSThread isMainThread])
	{
		m_titleLabel.text = text; 
	}
	else
	{
		[self performSelectorOnMainThread:@selector(setTitle:) withObject:text waitUntilDone:YES];
	}
}

- (NSString*) secondaryText
{
	return m_secondaryTextLabel.text;
}

- (void) setSecondaryText:(NSString*) text
{
	if([NSThread isMainThread])
	{	
		m_secondaryTextLabel.text = text;
	}
	else
	{
		 [self performSelectorOnMainThread:@selector(setSecondaryText:) withObject:text waitUntilDone:YES];
	}
}

- (NSString*) buttonTitle
{
	return	self.button.title;
}

- (void) setButtonTitle:(NSString*) text
{
	self.button.title = text;
}

- (void) setProgressViewAlpha:(float) alpha
{
	m_roundRectView.fillAlpha = alpha;
	m_roundRectView.borderAlpha = alpha;
}

- (void) showProgressInSuperview:(UIView*) superview
{
	[self showInSuperview:superview delay:self.startDelay];
}

- (void) showProgressInViewController:(UIViewController*) viewController
{	
	[self showInViewController:viewController isModal:self.modal delay:self.startDelay];
}

- (void) showProgress
{
//	[[GtNotificationDisplayManager defaultDisplayManager] showProgress:self];
}

- (void) hideProgress
{
	[self hideModalView]; 
}

@end


