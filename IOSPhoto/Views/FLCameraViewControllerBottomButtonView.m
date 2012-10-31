//
//	FLCameraViewControllerButtomButtomView.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/31/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLCameraViewControllerBottomButtonView.h"

#define PADDING 4

//#define ButtonFrame(left) CGRectMake(left, PADDING, (self.bounds.size.width / 2) - (PADDING*2), self.bounds.size.height - (PADDING*2))

@implementation FLCameraViewControllerBottomButtonView

@synthesize leftButton = _leftButton;
@synthesize rightButton = _rightButton;
@synthesize centerButton = _centerButton;

- (void) initSelf
{

	self.frame = FLRectSetHeight(self.frame, 54);
	self.backgroundColor = [UIColor blackColor];
//	  self.viewContentsDescriptor = FLViewContentsDescriptorMakeWithItemsAndPadding(FLViewContentItemNone, FLViewContentItemNone, UIEdgeInsetsMake(PADDING,PADDING,PADDING,PADDING));


	self.backgroundColor = [UIColor clearColor];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if ((self = [super initWithCoder:aDecoder])) 
	{
		[self initSelf];
		
	}
	
	return self;
}

- (id)initWithFrame:(FLRect)frame 
{
	if ((self = [super initWithFrame:frame])) 
	{
		[self initSelf];
	}
	
	return self;
}

- (void) setCommonTraitsForButtons:(UIButton*) button
{
	button.alpha = 0.6;
	button.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
	[button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
	[button setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
	button.titleLabel.shadowOffset = FLSizeMake(0, 1.0);
	[button setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
}

- (void) setLeftButton:(id) button
{
	if(_leftButton != button)
	{
		[_leftButton removeFromSuperview];
		FLReleaseWithNil_(_leftButton);
	}
	_leftButton = retain_(button);
	
	[self addSubview:_leftButton];
}

- (void) setRightButton:(id) button
{
	if(_rightButton != button)
	{
		[_rightButton removeFromSuperview];
		FLReleaseWithNil_(_rightButton);
	}
	_rightButton = retain_(button);
	
	[self addSubview:_rightButton];
}

- (void) setCenterButton:(id) button
{
	if(_centerButton != button)
	{
		[_centerButton removeFromSuperview];
		FLReleaseWithNil_(_centerButton);
	}
	_centerButton = retain_(button);
	
	[self addSubview:_centerButton];
}

- (void) dealloc
{
	FLReleaseWithNil_(_leftButton);
	FLReleaseWithNil_(_rightButton);
	FLReleaseWithNil_(_centerButton);
	
	mrc_super_dealloc_();
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	[self setFrameIfChanged:FLRectJustifyRectInRectBottom(self.superview.bounds, self.frame)];
}

//- (void) layoutSubviews
//{
//	[super layoutSubviews];
//	[_leftButton positionInSuperview];
//	[_rightButton positionInSuperview];
//	[_centerButton positionInSuperview];
//}

@end
