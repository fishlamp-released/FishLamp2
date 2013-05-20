//
//	FLModalProgressView.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/26/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLModalProgressView.h"

#import "FLRoundRectView.h"
#import "FLGradientButton.h"
#import "FLGradientView.h"

@implementation FLModalProgressView

+ (CGSize) defaultProgressViewSize
{
    return DeviceIsPad() ? 
        CGSizeMake(420.0f,150.0f) :
        CGSizeMake(300.0f,150.0f);
}

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
    if(CGRectEqualToRect(CGRectZero, frame))
    {
        frame = CGRectMake(0,0, DeviceIsPad() ? 420.0f: 300.0f, 150.0f);
    }

	if((self = [super initWithFrame:frame]))
	{
		self.autoresizesSubviews = NO;
		self.autoresizingMask = UIViewAutoresizingNone;
		self.backgroundColor = [UIColor clearColor];
	
		self.roundRectView = FLAutorelease([[FLRoundRectView alloc] initWithFrame:self.bounds]);
		self.roundRectView.autoresizesSubviews = YES;
		[self addSubview:self.roundRectView];

		_gradientView = [[FLGradientWidget alloc] init];
		[_gradientView setColorRange:[FLColorRange colorRange:[UIColor darkGrayColor] endColor:[UIColor blackColor]] forControlState:UIControlStateNormal];
		[self.roundRectView addWidget:_gradientView];
		
		self.titleLabel = FLAutorelease([[UILabel alloc] initWithFrame:CGRectZero]);
		self.secondaryTextLabel = FLAutorelease([[UILabel alloc] initWithFrame:CGRectZero]);
		self.progressBarLabel = FLAutorelease([[UILabel alloc] initWithFrame:CGRectZero]);
		self.progressBar = FLAutorelease([[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault]);
		self.progressBarSpinner = FLAutorelease([[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite]);
		self.progressBarSpinner.hidesWhenStopped = YES;
		
		self.button = FLAutorelease([[FLSmallButtonDeprecated alloc] initWithColor:FLGradientButtonBlack title:NSLocalizedString(@"Cancel", @"progress cancel button") target:nil action:nil]);
		
		UIActivityIndicatorView* spinner = FLAutorelease([[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite]);
		[self.button addSubview:spinner];
		
		spinner.frame = FLRectSetOrigin(spinner.frame, 14, 6);
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
	FLRelease(_gradientView);
	FLSuperDealloc();
}

+ (FLModalProgressView*) modalProgressView
{
	return FLAutorelease([[FLModalProgressView alloc] initWithFrame:CGRectMake(0,0,400,150)]);
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	CGRect frame = self.bounds;
	_gradientView.frame = self.bounds;
	self.titleLabel.frameOptimizedForSize = CGRectMake(0, 20, frame.size.width, 20);
	self.secondaryTextLabel.frameOptimizedForSize = CGRectMake(0, 36, frame.size.width, 20);
	self.progressBar.frameOptimizedForSize = FLRectCenterRectInRectHorizontally(frame, CGRectMake(0, 70, frame.size.width - 40, 20));
	
	self.progressBarLabel.frameOptimizedForSize = CGRectMake(0, 80, frame.size.width, 20);
	[self.button setViewSizeToContentSize];
	self.button.frameOptimizedForSize = FLRectSetTop(
		FLRectCenterRectInRectHorizontally(frame, self.button.frame),
		110);
		
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

