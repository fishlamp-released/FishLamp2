//
//  FLSmallProgressView.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/11/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLSmallProgressView.h"
#import "FLGradientButton.h"

@implementation FLSmallProgressView

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

- (void) applyTheme:(FLTheme*) theme {
}

- (id) initWithFrame:(CGRect) frame
{
    if(CGRectEqualToRect(CGRectZero, frame))
    {
        frame = CGRectMake(0,0, 320.0f, 64.0f);
    }

	if((self = [super initWithFrame:frame]))
	{
#if VIEW_AUTOLAYOUT
        self.autoLayoutMode = FLRectLayoutMake(FLRectLayoutHorizontalFill, FLRectLayoutVerticalBottom);
#endif        
        self.wantsApplyTheme = YES;

		self.autoresizesSubviews = NO;
		self.autoresizingMask = UIViewAutoresizingNone;
		self.backgroundColor = [UIColor clearColor];
	
		_gradientView = [[FLGradientView alloc] initWithFrame:CGRectZero];
		_gradientView.wantsApplyTheme = NO;
		_gradientView.alpha = 0.7;
		[_gradientView.gradient setColorRange:[FLColorRange colorRange:[UIColor darkGrayColor] endColor:[UIColor blackColor]] forControlState:UIControlStateNormal];
		
		[self addSubview:_gradientView];
		
		self.titleLabel = FLAutorelease([[UILabel alloc] initWithFrame:CGRectZero]);
		self.progressBarLabel = FLAutorelease([[UILabel alloc] initWithFrame:CGRectZero]);
		
		self.progressBar = FLAutorelease([[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault]);
		self.progressBarSpinner = FLAutorelease([[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite]);
		self.progressBarSpinner.hidesWhenStopped = YES;
		
		self.button = FLAutorelease([[FLToolbarButtonDeprecated alloc] initWithColor:FLGradientButtonBlack title:NSLocalizedString(@"Cancel", nil) target:nil action:nil]);
		
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
	FLRelease(_gradientView);
	FLSuperDealloc();
}

+ (FLSmallProgressView*) smallProgressView
{
	return FLAutorelease([[FLSmallProgressView alloc] initWithFrame:CGRectZero]);
}

- (void) layoutSubviews
{
	[super layoutSubviews];

	CGRect frame = self.bounds;
	_gradientView.frame = frame;
	self.button.frameOptimizedForSize = 
		FLRectCenterRectInRectVertically(frame, FLRectSetLeft(self.button.frame, self.bounds.size.width - self.button.frame.size.width - 10));

	frame.size.width = self.button.frame.origin.x;

	self.titleLabel.frameOptimizedForSize = FLRectSetTop(FLRectSetHeight(CGRectInset(frame, 10, 0), 20), 4);
	
	self.progressBar.frameOptimizedForSize = FLRectCenterRectInRectVertically(frame, FLRectSetHeight(CGRectInset(frame, 10, 0), 9));
	
	self.progressBarLabel.frameOptimizedForSize = FLRectSetTop(FLRectSetHeight(CGRectInset(frame, 10, 0), 20), frame.size.height - 22.0f);
		
	if(self.progressBar.hidden)
	{
		self.progressBarSpinner.frameOptimizedForSize = FLRectCenterRectInRect(self.progressBar.frame, self.progressBarSpinner.frame);
	}
	else
	{
		self.progressBarSpinner.frameOptimizedForSize = FLRectCenterRectInRectVertically(self.progressBarLabel.frame, 
			FLRectSetLeft(self.progressBarSpinner.frame, self.progressBarLabel.frame.origin.x - self.progressBarSpinner.frame.size.width));
	}
}

@end

