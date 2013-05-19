//
//	FLProgressView.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/21/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLLegacyProgressView.h"
#import "FLLegacyButton.h"
#import "FLRoundRectView.h"

#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"

@implementation FLLegacyProgressView

@synthesize progressBarLabel = _progressBarLabel;
@synthesize progressBar = _progressBar;
@synthesize progressBarSpinner = _progressBarSpinner;
@synthesize titleLabel = _titleLabel;
@synthesize secondaryTextLabel = _secondaryTextLabel;
@synthesize roundRectView = _roundRectView;
@synthesize button = _button;

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
	FLRelease(_progressBarLabel);
	FLRelease(_progressBar);
	FLRelease(_progressBarSpinner);
	FLRelease(_titleLabel);
	FLRelease(_secondaryTextLabel);
	FLRelease(_button);
	FLRelease(_roundRectView);
	FLSuperDealloc();
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	if(_roundRectView)
	{
		_roundRectView.newFrame = self.bounds;
	}
}

- (void) buttonPressed:(id)sender
{
	if(_buttonTarget)
	{
		if([NSThread isMainThread])
		{
			if(_progressViewFlags.buttonIsCancelButton)
			{
				_button.enabled = NO;
				self.title = NSLocalizedString(@"Cancelling…", nil);
			}
		
			[_buttonTarget performSelector:_buttonWasPressedCallback withObject:self];
		}
		else
		{
			[self performSelectorOnMainThread:@selector(buttonPressed:) withObject:sender waitUntilDone:YES];
		}
	}
}

- (void) setButton:(FLLegacyButton*) button
{
	FLSetObjectWithRetain(_button, button);
    [_button setCallback:self action:@selector(buttonPressed:)];
}

- (void) setButtonTarget:(id)target action:(SEL) action isCancel:(BOOL) isCancel
{
	_progressViewFlags.buttonIsCancelButton = isCancel;
	_buttonTarget = target;
	_buttonWasPressedCallback = action;
}

- (void) willStartUpdatingProgressBar
{
	[_progressBarSpinner stopAnimating];
}

- (void) updateProgress:(unsigned long long) amountWritten 
            totalAmount:(unsigned long long) totalAmount {
	if(_progressBar)
	{	
		if(_progressBar.hidden)
		{
			_progressBar.hidden = NO;
			[self willStartUpdatingProgressBar];
		}
	
		FLAssertWithComment([NSThread isMainThread], @"not on main thread, use updateProgress:(FLProgressValue*) value");
   
		_progressBar.progress = ((float) amountWritten) / ((float) totalAmount);
	}
}

- (NSString*) progressBarText
{
	return _progressBarLabel.text;
}

- (void) setProgressBarText:(NSString*) text
{
	if([NSThread isMainThread])
	{	
		_progressBarLabel.text = text;
	}
	else
	{
		[self performSelectorOnMainThread:@selector(setProgressBarText:) withObject:text waitUntilDone:YES];
	}
}

- (NSString*) title
{
	return _titleLabel.text;
}

- (void) setTitle:(NSString*) text
{
	if([NSThread isMainThread])
	{
		_titleLabel.text = text; 
	}
	else
	{
		[self performSelectorOnMainThread:@selector(setTitle:) withObject:text waitUntilDone:YES];
	}
}

- (NSString*) secondaryText
{
	return _secondaryTextLabel.text;
}

- (void) setSecondaryText:(NSString*) text
{
	if([NSThread isMainThread])
	{	
		_secondaryTextLabel.text = text;
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
	_roundRectView.fillAlpha = alpha;
	_roundRectView.borderAlpha = alpha;
}

@end


