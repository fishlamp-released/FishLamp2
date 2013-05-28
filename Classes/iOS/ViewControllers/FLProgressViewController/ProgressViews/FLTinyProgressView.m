//
//  FLBackgroundProgressView.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/16/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLTinyProgressView.h"
#import "UIColor+FLMoreColors.h"

@implementation FLTinyProgressView

- (id) initWithFrame:(CGRect) frame
{
    if(CGRectEqualToRect(CGRectZero, frame))
    {
        frame = CGRectMake(0,0, 200.0f, 26.0f);
    }

	if((self = [super initWithFrame:frame]))
	{
		self.autoresizingMask = UIViewAutoresizingNone;
		self.autoresizesSubviews = NO;
		self.backgroundColor = [UIColor clearColor];
	
		self.layer.borderColor = [UIColor darkGrayColor].CGColor;
		self.layer.borderWidth = 1.0f;
		
		_backgroundView = [[UIView alloc] initWithFrame:self.bounds];
		_backgroundView.alpha = 0.75;
		_backgroundView.backgroundColor = [UIColor blackColor];
		[self addSubview:_backgroundView];

		_progressView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 0, 22)];
		_progressView.alpha = 0.6;
		_progressView.backgroundColor = [UIColor iPhoneBlueColor];
//        [UIColor gray25Color];
		[self addSubview:_progressView];
		
		self.progressBarSpinner = FLAutorelease([[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite]);
		[self.progressBarSpinner startAnimating];
		[self addSubview:self.progressBarSpinner];
		
		UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 120, 18)];
		titleLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
		titleLabel.textColor = [UIColor whiteColor];
		titleLabel.backgroundColor = [UIColor clearColor];
		self.titleLabel = titleLabel;
		[self addSubview:titleLabel];
		FLRelease(titleLabel);
	}
	
	return self;
}

- (id) init
{
	return [self initWithFrame:CGRectZero];
}

+ (FLTinyProgressView*) tinyProgressView
{
	return FLAutorelease([[FLTinyProgressView alloc] init]);
}

- (void) dealloc
{
	FLRelease(_backgroundView);
	FLRelease(_progressView);
	FLSuperDealloc();
}	

- (void) _updateProgressFrame
{
	_progressView.frameOptimizedForSize = CGRectMake(0,0, _totalAmount == 0.0f ? 0.0f : (self.bounds.size.width * ((_amountWritten / _totalAmount))), self.bounds.size.height);
	_backgroundView.frameOptimizedForSize = CGRectMake(FLRectGetRight(_progressView.frame), 0, self.bounds.size.width - FLRectGetRight(_progressView.frame), self.bounds.size.height);
}

- (void) _updateLayout
{
	[self _updateProgressFrame];
	
	self.progressBarSpinner.newFrame = FLRectSetLeft(FLRectCenterRectInRectVertically(self.bounds, self.progressBarSpinner.frame), 8);
	
	self.titleLabel.frameOptimizedForSize = FLRectSetLeft(
		FLRectCenterRectInRectVertically(self.bounds, FLRectSetWidth(self.titleLabel.frame, self.bounds.size.width - FLRectGetRight(self.progressBarSpinner.frame) - 16)), 
		FLRectGetRight(self.progressBarSpinner.frame) + 8);
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
            totalAmount:(unsigned long long) totalAmount {
	_totalAmount = totalAmount;
	_amountWritten = amountWritten;
	[self _updateProgressFrame];
}



@end
