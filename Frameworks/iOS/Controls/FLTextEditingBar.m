//
//	FLTextEditingBar.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/6/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLTextEditingBar.h"

@implementation FLTextEditingBar

#define FLTextEditCellEditingBarHeight 40

@synthesize delegate = _textEditingBarDelegate;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:CGRectMake(0,0,320, FLTextEditCellEditingBarHeight)]))
	{
		self.autoresizingMask = UIViewAutoresizingNone;
		self.autoresizesSubviews = NO;
		self.barStyle = UIBarStyleBlack; 
		self.translucent = NO;
		self.alpha = 0.8f;
		
		_next = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"23-circle-south.png"] style:UIBarButtonItemStylePlain target:self action:@selector(onNext:)];
		_prev = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"27-circle-north.png"] style:UIBarButtonItemStylePlain target:self action:@selector(onPrevious:)];
		_stop = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"31-circle-x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(onStopEditing:)];

		UIBarButtonItem* space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
		space.width = 40;
		
		NSArray* array = [[NSArray alloc] initWithObjects:
			_prev, 
			space, 
			_next, 
			FLAutorelease([[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]), 
			_stop, 
			nil];

		[self setItems:array animated:NO];

		FLReleaseWithNil(array);

		FLReleaseWithNil(space);
	}
	
	return self;
}

- (void) dealloc
{	
	FLReleaseWithNil(_next);
	FLReleaseWithNil(_prev);
	FLReleaseWithNil(_stop);
	FLSuperDealloc();
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
										FLTextEditCellEditingBarHeight);
		if(self.hidden)
		{
			self.hidden = NO;
			self.newFrame = CGRectMake(
				0, 
				self.superview.bounds.size.height - keyboardRect.size.height,
				keyboardRect.size.width,
				FLTextEditCellEditingBarHeight);
		}
		
		[UIView beginAnimations:@"viewin" context:nil];
	//	[UIView setAnimationDelegate:FLRetain(self)];
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
	//	[UIView setAnimationDelegate:FLRetain(self)];
	//	[UIView setAnimationDidStopSelector:callback];
		[UIView setAnimationDuration:0.3];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		self.newFrame = FLRectSetOrigin(self.frame, 0, self.superview.bounds.size.height) ;
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
	_next.enabled = [self.delegate textEditingBarNextButtonEnabled:self];
	_prev.enabled = [self.delegate textEditingBarPreviousButtonEnabled:self];
}



@end
