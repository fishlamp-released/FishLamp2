//
//	FLButtonBackgroundWidget.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/20/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLButtonBackgroundWidget.h"


@implementation FLButtonBackgroundWidget

@synthesize topGradient = _topGradient;
@synthesize bottomGradient = _bottomGradient;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		_topGradient = [[FLGradientWidget alloc] initWithFrame:frame];
		[self addWidget:_topGradient];

		_bottomGradient = [[FLGradientWidget alloc] initWithFrame:frame];
		[self addWidget:_bottomGradient];
	}
	
	return self;
}	

+ (FLButtonBackgroundWidget*) buttonBackgroundWidget
{
	return FLAutorelease([[FLButtonBackgroundWidget alloc] initWithFrame:CGRectZero]);
}

- (CGFloat) alpha
{
	return _topGradient.alpha;
}

- (void) setAlpha:(CGFloat) alpha
{
	_topGradient.alpha = alpha;
	_bottomGradient.alpha = alpha;
}

- (void) layoutWidgets
{
	CGRect frame = self.frame;
	frame.size.height *= 0.5;
//	  frame.size.height += 0.5;
	_topGradient.frameOptimizedForSize = frame;

	frame.origin.y = FLRectGetBottom(_topGradient.frame);
	frame.size.height = self.frame.size.height - frame.origin.y;
	_bottomGradient.frameOptimizedForSize = frame;
	
	[super layoutWidgets];
}

- (void) dealloc
{
	FLRelease(_topGradient);
	FLRelease(_bottomGradient);
	super_dealloc_();
}

@end
