//
//	GtCameraViewControllerButtomButtomView.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/31/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtCameraViewControllerBottomButtonView.h"

#define PADDING 4

//#define ButtonFrame(left) CGRectMake(left, PADDING, (self.bounds.size.width / 2) - (PADDING*2), self.bounds.size.height - (PADDING*2))

@implementation GtCameraViewControllerBottomButtonView

@synthesize leftButton = m_leftButton;
@synthesize rightButton = m_rightButton;
@synthesize centerButton = m_centerButton;

- (void) initSelf
{

	self.frame = GtRectSetHeight(self.frame, 54);
	self.backgroundColor = [UIColor blackColor];
//	  self.viewContentsDescriptor = GtViewContentsDescriptorMakeWithItemsAndPadding(GtViewContentItemNone, GtViewContentItemNone, UIEdgeInsetsMake(PADDING,PADDING,PADDING,PADDING));


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
		GtReleaseWithNil(m_leftButton);
	}
	m_leftButton = GtRetain(button);
	
	[self addSubview:m_leftButton];
}

- (void) setRightButton:(id) button
{
	if(m_rightButton != button)
	{
		[m_rightButton removeFromSuperview];
		GtReleaseWithNil(m_rightButton);
	}
	m_rightButton = GtRetain(button);
	
	[self addSubview:m_rightButton];
}

- (void) setCenterButton:(id) button
{
	if(m_centerButton != button)
	{
		[m_centerButton removeFromSuperview];
		GtReleaseWithNil(m_centerButton);
	}
	m_centerButton = GtRetain(button);
	
	[self addSubview:m_centerButton];
}

- (void) dealloc
{
	GtReleaseWithNil(m_leftButton);
	GtReleaseWithNil(m_rightButton);
	GtReleaseWithNil(m_centerButton);
	
	GtSuperDealloc();
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	[self setFrameIfChanged:GtRectJustifyRectInRectBottom(self.superview.bounds, self.frame)];
}

//- (void) layoutSubviews
//{
//	[super layoutSubviews];
//	[m_leftButton positionInSuperview];
//	[m_rightButton positionInSuperview];
//	[m_centerButton positionInSuperview];
//}

@end
