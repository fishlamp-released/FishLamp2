//
//  GtBackgroundProgressView.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/16/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTinyProgressView.h"
#import "UIColor+GtMoreColors.h"

@implementation GtTinyProgressView

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:CGRectMake(0,0,200.0, 26)]))
	{
		self.autoresizingMask = UIViewAutoresizingNone;
		self.autoresizesSubviews = NO;
		self.backgroundColor = [UIColor clearColor];
	
		self.layer.borderColor = [UIColor darkGrayColor].CGColor;
		self.layer.borderWidth = 1.0f;
		
		m_backgroundView = [[UIView alloc] initWithFrame:self.bounds];
		m_backgroundView.alpha = 0.75;
		m_backgroundView.backgroundColor = [UIColor blackColor];
		[self addSubview:m_backgroundView];

		m_progressView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 0, 22)];
		m_progressView.alpha = 0.6;
		m_progressView.backgroundColor = [UIColor iPhoneBlueColor];
//        [UIColor gray25Color];
		[self addSubview:m_progressView];
		
		self.progressBarSpinner = GtReturnAutoreleased([[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite]);
		[self.progressBarSpinner startAnimating];
		[self addSubview:self.progressBarSpinner];
		
		UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 120, 18)];
		titleLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
		titleLabel.textColor = [UIColor whiteColor];
		titleLabel.backgroundColor = [UIColor clearColor];
		self.titleLabel = titleLabel;
		[self addSubview:titleLabel];
		GtRelease(titleLabel);
	}
	
	return self;
}

- (id) init
{
	return [self initWithFrame:CGRectZero];
}

+ (GtTinyProgressView*) tinyProgressView
{
	return GtReturnAutoreleased([[GtTinyProgressView alloc] init]);
}

- (void) dealloc
{
	GtRelease(m_backgroundView);
	GtRelease(m_progressView);
	GtSuperDealloc();
}	

- (void) _updateProgressFrame
{
	m_progressView.frameOptimizedForSize = CGRectMake(0,0, m_totalAmount == 0 ? 0 : (self.bounds.size.width * ((m_amountWritten / m_totalAmount))), self.bounds.size.height);
	m_backgroundView.frameOptimizedForSize = CGRectMake(GtRectGetRight(m_progressView.frame), 0, self.bounds.size.width - GtRectGetRight(m_progressView.frame), self.bounds.size.height);
}

- (void) _updateLayout
{
	[self _updateProgressFrame];
	
	self.progressBarSpinner.newFrame = GtRectSetLeft(GtRectCenterRectInRectVertically(self.bounds, self.progressBarSpinner.frame), 8);
	
	self.titleLabel.frameOptimizedForSize = GtRectSetLeft(
		GtRectCenterRectInRectVertically(self.bounds, GtRectSetWidth(self.titleLabel.frame, self.bounds.size.width - GtRectGetRight(self.progressBarSpinner.frame) - 16)), 
		GtRectGetRight(self.progressBarSpinner.frame) + 8);
}

- (void) layoutSubviews
{
	[super layoutSubviews];
    [self _updateLayout];
}

- (void) didMoveToSuperview
{
    [super didMoveToSuperview];
    if(self.superview)
    {
        [self _updateLayout];
    }
}

- (void) updateProgress:(unsigned long long) amountWritten 
            totalAmount:(unsigned long long) totalAmount;
{
	m_totalAmount = totalAmount;
	m_amountWritten = amountWritten;
	[self _updateProgressFrame];
}



@end
