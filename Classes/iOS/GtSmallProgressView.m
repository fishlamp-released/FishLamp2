//
//  GtSmallProgressView.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/11/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSmallProgressView.h"
#import "GtGradientButton.h"

@implementation GtSmallProgressView

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
	if((self = [super initWithFrame:CGRectMake(0,0,320, 64)]))
	{
// FIXME
//#if VIEW_AUTOLAYOUT
//        self.autoLayoutMode = GtRectLayoutMake(GtRectLayoutHorizontalFill, GtRectLayoutVerticalBottom);
//#endif        
		self.modal = YES;
		self.autoresizesSubviews = NO;
		self.autoresizingMask = UIViewAutoresizingNone;
		self.backgroundColor = [UIColor clearColor];
	
		m_gradientView = [[GtGradientView alloc] initWithFrame:CGRectZero];
		m_gradientView.themeAction = nil;
		m_gradientView.alpha = 0.7;
		[m_gradientView setGradientColors:[UIColor darkGrayColor] endColor:[UIColor blackColor]];
		
		[self addSubview:m_gradientView];
		
		self.titleLabel = GtReturnAutoreleased([[UILabel alloc] initWithFrame:CGRectZero]);
		self.progressBarLabel = GtReturnAutoreleased([[UILabel alloc] initWithFrame:CGRectZero]);
		
		self.progressBar = GtReturnAutoreleased([[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault]);
		self.progressBarSpinner = GtReturnAutoreleased([[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite]);
		self.progressBarSpinner.hidesWhenStopped = YES;
		
		self.button = GtReturnAutoreleased([[GtToolbarButton alloc] initWithColor:GtButtonBlack title:NSLocalizedString(@"Cancel", nil) target:nil action:nil]);
		
		[self _configureLabel:self.titleLabel];
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

+ (GtSmallProgressView*) smallProgressView
{
	return GtReturnAutoreleased([[GtSmallProgressView alloc] initWithFrame:CGRectZero]);
}

- (void) layoutSubviews
{
	[super layoutSubviews];

	CGRect frame = self.bounds;
	m_gradientView.frame = frame;
	self.button.frameOptimizedForSize = 
		GtRectCenterRectInRectVertically(frame, GtRectSetLeft(self.button.frame, self.bounds.size.width - self.button.frame.size.width - 10));

	frame.size.width = self.button.frame.origin.x;

	self.titleLabel.frameOptimizedForSize = GtRectSetTop(GtRectSetHeight(CGRectInset(frame, 10, 0), 20), 4);
	
	self.progressBar.frameOptimizedForSize = GtRectCenterRectInRectVertically(frame, GtRectSetHeight(CGRectInset(frame, 10, 0), 9));
	
	self.progressBarLabel.frameOptimizedForSize = GtRectSetTop(GtRectSetHeight(CGRectInset(frame, 10, 0), 20), frame.size.height - 22.0f);
		
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

