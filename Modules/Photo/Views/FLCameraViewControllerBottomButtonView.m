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

@synthesize leftButton = m_leftButton;
@synthesize rightButton = m_rightButton;
@synthesize centerButton = m_centerButton;

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

- (id)initWithFrame:(CGRect)frame 
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
	button.titleLabel.shadowOffset = CGSizeMake(0, 1.0);
	[button setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
}

- (void) setLeftButton:(id) button
{
	if(m_leftButton != button)
	{
		[m_leftButton removeFromSuperview];
		FLReleaseWithNil(m_leftButton);
	}
	m_leftButton = FLReturnRetained(button);
	
	[self addSubview:m_leftButton];
}

- (void) setRightButton:(id) button
{
	if(m_rightButton != button)
	{
		[m_rightButton removeFromSuperview];
		FLReleaseWithNil(m_rightButton);
	}
	m_rightButton = FLReturnRetained(button);
	
	[self addSubview:m_rightButton];
}

- (void) setCenterButton:(id) button
{
	if(m_centerButton != button)
	{
		[m_centerButton removeFromSuperview];
		FLReleaseWithNil(m_centerButton);
	}
	m_centerButton = FLReturnRetained(button);
	
	[self addSubview:m_centerButton];
}

- (void) dealloc
{
	FLReleaseWithNil(m_leftButton);
	FLReleaseWithNil(m_rightButton);
	FLReleaseWithNil(m_centerButton);
	
	FLSuperDealloc();
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	[self setFrameIfChanged:FLRectJustifyRectInRectBottom(self.superview.bounds, self.frame)];
}

//- (void) layoutSubviews
//{
//	[super layoutSubviews];
//	[m_leftButton positionInSuperview];
//	[m_rightButton positionInSuperview];
//	[m_centerButton positionInSuperview];
//}

@end
