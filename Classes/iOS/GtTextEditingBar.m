//
//	GtTextEditingBar.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/6/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTextEditingBar.h"

@implementation GtTextEditingBar

#define GtTextEditCellEditingBarHeight 40

@synthesize delegate = m_delegate;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:CGRectMake(0,0,320, GtTextEditCellEditingBarHeight)]))
	{
		self.autoresizingMask = UIViewAutoresizingNone;
		self.autoresizesSubviews = NO;
		self.barStyle = UIBarStyleBlack; 
		self.translucent = NO;
		self.alpha = 0.8f;
		
		m_next = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"23-circle-south.png"] style:UIBarButtonItemStylePlain target:self action:@selector(onNext:)];
		m_prev = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"27-circle-north.png"] style:UIBarButtonItemStylePlain target:self action:@selector(onPrevious:)];
		m_stop = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"31-circle-x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(onStopEditing:)];

		UIBarButtonItem* space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
		space.width = 40;
		
		NSArray* array = [[NSArray alloc] initWithObjects:
			m_prev, 
			space, 
			m_next, 
			GtReturnAutoreleased([[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]), 
			m_stop, 
			nil];

		[self setItems:array animated:NO];

		GtReleaseWithNil(array);

		GtReleaseWithNil(space);
	}
	
	return self;
}

- (void) dealloc
{	
	GtReleaseWithNil(m_next);
	GtReleaseWithNil(m_prev);
	GtReleaseWithNil(m_stop);
	GtSuperDealloc();
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	[self update];
}

- (void) showWithKeyboardRect:(CGRect) keyboardRect
{
	if(self.superview)
	{
		CGRect newFrame = CGRectMake(	0, 
										self.superview.bounds.size.height - keyboardRect.size.height - self.frame.size.height,
										keyboardRect.size.width,
										GtTextEditCellEditingBarHeight);
		if(self.hidden)
		{
			self.hidden = NO;
			self.newFrame = CGRectMake(
				0, 
				self.superview.bounds.size.height - keyboardRect.size.height,
				keyboardRect.size.width,
				GtTextEditCellEditingBarHeight);
		}
		
		[UIView beginAnimations:@"viewin" context:nil];
	//	[UIView setAnimationDelegate:GtRetain(self)];
	//	[UIView setAnimationDidStopSelector:callback];
		[UIView setAnimationDuration:0.2];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		self.newFrame = newFrame;
		[UIView commitAnimations];
	}
}

- (void) slideOffscreen
{
	if(self.superview)
	{
		[UIView beginAnimations:@"viewin" context:nil];
	//	[UIView setAnimationDelegate:GtRetain(self)];
	//	[UIView setAnimationDidStopSelector:callback];
		[UIView setAnimationDuration:0.3];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		self.newFrame = GtRectSetOrigin(self.frame, 0, self.superview.bounds.size.height) ;
		[UIView commitAnimations];
	}
}

- (void) onNext:(id) sender
{
	[self.delegate textEditingBarNextButtonPressed:self];
}

- (void) onPrevious:(id) sender
{
	[self.delegate textEditingBarPreviousButtonPressed:self];
}

- (void) onStopEditing:(id) sender
{
	[self.delegate textEditingBarCancelButtonPressed:self];
}

- (void) update
{
	m_next.enabled = [self.delegate textEditingBarNextButtonEnabled:self];
	m_prev.enabled = [self.delegate textEditingBarPreviousButtonEnabled:self];
}



@end
