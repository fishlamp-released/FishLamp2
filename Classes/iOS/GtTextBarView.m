//
//	GtTextBarView.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/11/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTextBarView.h"


@implementation GtTextBarView

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.backgroundColor = [UIColor blackColor];
		self.alpha = 0.70;
		self.autoresizesSubviews = NO;
		self.autoresizingMask = UIViewAutoresizingFlexibleEverything;
	}

	return self;
}

- (void) createTitleLabel:(UILabel**) outLabel
{
	UILabel* label = [[UILabel alloc] initWithFrame:CGRectZero];
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor whiteColor];
	label.textAlignment = UITextAlignmentLeft;
	if(DeviceIsPad())
	{
		label.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
	}
	else
	{
		label.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
	}
	label.lineBreakMode = UILineBreakModeWordWrap;
	label.autoresizingMask = UIViewAutoresizingNone;
	label.numberOfLines = 0;
	[self addSubview:label];
	*outLabel = label;
}

- (UILabel*) label 
{
	if(!m_label)
	{
		[self createTitleLabel:&m_label];
	}
	
	return m_label;
}

- (UILabel*) textLabel
{
	if(!m_text)
	{
		[self createTitleLabel:&m_text];
		m_text.lineBreakMode = UILineBreakModeWordWrap;
	}
	
	return m_text;
}

#define SpaceBetween 4
#define Padding 10

- (CGRect) adjustViewsInRect
{
	CGRect superviewBounds = self.superview.bounds;
	CGRect insetBounds = CGRectInset(superviewBounds, 10, 0);
	
	CGRect myFrame = self.frame;
	myFrame.size.width = superviewBounds.size.width;
	
	CGRect labelFrame = insetBounds;
	labelFrame.size = [self.label sizeToFitText:CGSizeMake(labelFrame.size.width, 2048.0f)];
	
	CGSize textSize = m_text ? [self.textLabel sizeToFitText:insetBounds.size] : CGSizeZero;
	
	if(!m_text)
	{
		m_label.textAlignment = UITextAlignmentCenter;
		myFrame.size.height = labelFrame.size.height + Padding;
		m_label.frameOptimizedForSize = GtRectCenterRectInRect(self.bounds,labelFrame);
	}
	else if ((labelFrame.size.width + textSize.width + SpaceBetween) < insetBounds.size.width)
	{
		// one line
		CGRect bounds = CGRectMake(0,0, labelFrame.size.width + textSize.width + SpaceBetween, labelFrame.size.height + Padding);
		bounds = GtRectCenterRectInRectHorizontally(myFrame, bounds);
		[m_label moveTo:bounds.origin];
		
		m_text.frameOptimizedForSize = GtRectAlignRectsHorizonally(m_label.frame, m_text.frame);
		[m_text moveBy:SpaceBetween y:0];

		m_text.frameOptimizedForSize =GtRectSetHeight(m_text.frame, m_label.frame.size.height);
		m_text.frameOptimizedForSize =GtRectSetTop(m_text.frame, m_label.frame.origin.y);
		
		myFrame.size.height = bounds.size.height;
	}
	else
	{
		myFrame.size.height = m_label.frame.size.height + m_text.frame.size.height + Padding;
		m_label.frameOptimizedForSize = GtRectCenterRectInRectHorizontally(myFrame, m_label.frame);
		m_text.frameOptimizedForSize = GtRectCenterRectInRectHorizontally(myFrame, GtRectAlignRectVertically(m_label.frame, m_text.frame));
	}
	
	return myFrame;
}

#if VIEW_AUTOLAYOUT
- (void) setPositionInSuperview
{
	self.newFrame = [self adjustViewsInRect];
	[super setPositionInSuperview];
}
#endif

- (void)drawRect:(CGRect)rect
{
	[super drawRect:rect];
	
	CGFloat lineY = self.bounds.size.height - 0.5;
	
	CGContextRef ctx = UIGraphicsGetCurrentContext(); //get the graphics context
//	CGContextSetLineWidth(ctx, 0.25);
	CGContextSetRGBStrokeColor(ctx, 0.7, 0.7, 0.7, 1); 
	CGContextMoveToPoint(ctx, 0, lineY);
	CGContextAddLineToPoint(ctx , self.bounds.size.width, lineY);
	CGContextStrokePath(ctx);

}


@end
