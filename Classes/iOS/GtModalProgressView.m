//
//	GtModalProgressView.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/26/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtModalProgressView.h"

#import "GtRoundRectView.h"
#import "GtGradientButton.h"
#import "GtGradientView.h"

@implementation GtModalProgressView

- (void) _configureLabel:(UILabel*) label
{
	label.textColor = [UIColor whiteColor];
	label.shadowColor = [UIColor blackColor];
	label.shadowOffset	  = CGSizeMake (0.0, 0.0);
	label.backgroundColor = [UIColor clearColor];
	label.textAlignment = UITextAlignmentCenter;
	label.font = DeviceIsPad() ? [UIFont boldSystemFontOfSize:[UIFont systemFontSize]] : [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]]; 
	label.autoresizingMask = UIViewAutoresizingNone;
	label.lineBreakMode = UILineBreakModeMiddleTruncation;
	[self addSubview:label];
}

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.modal = YES;
		self.autoresizesSubviews = NO;
		self.autoresizingMask = UIViewAutoresizingNone;
		self.backgroundColor = [UIColor clearColor];
	
		self.roundRectView = GtReturnAutoreleased([[GtRoundRectView alloc] initWithFrame:self.bounds]);
		self.roundRectView.autoresizesSubviews = YES;
		[self addSubview:self.roundRectView];

		m_gradientView = [[GtGradientWidget alloc] init];
		m_gradientView.themeAction = nil;
		[m_gradientView setGradientColors:[UIColor darkGrayColor] endColor:[UIColor blackColor]];
		[self.roundRectView addWidget:m_gradientView];
		
		self.titleLabel = GtReturnAutoreleased([[UILabel alloc] initWithFrame:CGRectZero]);
		self.secondaryTextLabel = GtReturnAutoreleased([[UILabel alloc] initWithFrame:CGRectZero]);
		self.progressBarLabel = GtReturnAutoreleased([[UILabel alloc] initWithFrame:CGRectZero]);
		self.progressBar = GtReturnAutoreleased([[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault]);
		self.progressBarSpinner = GtReturnAutoreleased([[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite]);
		self.progressBarSpinner.hidesWhenStopped = YES;
		
		self.button = GtReturnAutoreleased([[GtSmallButton alloc] initWithColor:GtButtonBlack title:@"Cancel" target:nil action:nil]);
		
		UIActivityIndicatorView* spinner = GtReturnAutoreleased([[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite]);
		[self.button addSubview:spinner];
		
		spinner.frame = GtRectSetOrigin(spinner.frame, 14, 6);
		[spinner startAnimating];
		
		[self _configureLabel:self.titleLabel];
		[self _configureLabel:self.secondaryTextLabel];
		[self _configureLabel:self.progressBarLabel];
		
		[self addSubview:self.progressBar];
		[self addSubview:self.progressBarSpinner];
		[self addSubview:self.button];

		self.progressBarLabel.textColor = [UIColor lightGrayColor];
		
		[self.progressBarSpinner startAnimating];
		self.progressBar.hidden = YES;
		
		self.layer.shadowColor = [UIColor grayColor].CGColor;
		self.layer.shadowOpacity = .8;
		self.layer.shadowRadius = 10.0;
		self.layer.shadowOffset = CGSizeMake(0,3);
	}
	
	return self;
}

- (void) dealloc
{
	GtRelease(m_gradientView);
	GtSuperDealloc();
}

+ (GtModalProgressView*) modalProgressView
{
	return GtReturnAutoreleased([[GtModalProgressView alloc] initWithFrame:CGRectZero]);
}
- (BOOL) updateSize
{	
	CGRect frame = CGRectZero;
	frame.size.width = MIN(400.0f, self.superview.bounds.size.width - 20);
	frame.size.height = 150.0f;
//	  frame = GtRectSetHeight(frame, GtRectGetBottom(self.button.frame) + 20);

	return [self setFrameIfChanged:GtRectGrowRectToOptimizedSizeIfNeeded(GtRectSetSize(self.frame, frame.size.width, frame.size.height))];
}
- (void) layoutSubviews
{
	if([self updateSize])
	{
#if VIEW_AUTOLAYOUT
		[self setPositionInSuperview];
#endif        
	}
	[super layoutSubviews];
	

	CGRect frame = self.bounds;
	m_gradientView.frame = self.bounds;
	self.titleLabel.frameOptimizedForSize = CGRectMake(0, 20, frame.size.width, 20);
	self.secondaryTextLabel.frameOptimizedForSize = CGRectMake(0, 36, frame.size.width, 20);
	self.progressBar.frameOptimizedForSize = GtRectCenterRectInRectHorizontally(frame, CGRectMake(0, 70, frame.size.width - 40, 20));
	
	self.progressBarLabel.frameOptimizedForSize = CGRectMake(0, 80, frame.size.width, 20);
	[self.button setViewSizeToContentSize];
	self.button.frameOptimizedForSize = GtRectSetTop(
		GtRectCenterRectInRectHorizontally(frame, self.button.frame),
		110);
		
	if(self.progressBar.hidden)
	{
		self.progressBarSpinner.frameOptimizedForSize = GtRectCenterRectInRect(self.progressBar.frame, self.progressBarSpinner.frame);
	}
	else
	{
		self.progressBarSpinner.frameOptimizedForSize = GtRectCenterRectInRectVertically(self.progressBarLabel.frame, 
			GtRectSetLeft(self.progressBarSpinner.frame, self.progressBarLabel.frame.origin.x - self.progressBarSpinner.frame.size.width));
	}
}

@end

