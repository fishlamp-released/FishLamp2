//
//	FLTextBarView.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/11/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLTextBarView.h"


@implementation FLTextBarView

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
	if(!_label)
	{
        UILabel* label = nil;
		[self createTitleLabel:&label];
        
        _label = label;
	}
	
	return _label;
}

- (UILabel*) textLabel
{
	if(!_text)
	{
        UILabel* label = nil;
		[self createTitleLabel:&label];
        _text = label;
		_text.lineBreakMode = UILineBreakModeWordWrap;
	}
	
	return _text;
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
	
	CGSize textSize = _text ? [self.textLabel sizeToFitText:insetBounds.size] : CGSizeZero;
	
	if(!_text)
	{
		_label.textAlignment = UITextAlignmentCenter;
		myFrame.size.height = labelFrame.size.height + Padding;
		_label.frameOptimizedForSize = FLRectCenterRectInRect(self.bounds,labelFrame);
	}
	else if ((labelFrame.size.width + textSize.width + SpaceBetween) < insetBounds.size.width)
	{
		// one line
		CGRect bounds = CGRectMake(0,0, labelFrame.size.width + textSize.width + SpaceBetween, labelFrame.size.height + Padding);
		bounds = FLRectCenterRectInRectHorizontally(myFrame, bounds);
		[_label moveTo:bounds.origin];
		
		_text.frameOptimizedForSize = FLRectAlignRectsHorizonally(_label.frame, _text.frame);
		[_text moveBy:SpaceBetween y:0];

		_text.frameOptimizedForSize =FLRectSetHeight(_text.frame, _label.frame.size.height);
		_text.frameOptimizedForSize =FLRectSetTop(_text.frame, _label.frame.origin.y);
		
		myFrame.size.height = bounds.size.height;
	}
	else
	{
		myFrame.size.height = _label.frame.size.height + _text.frame.size.height + Padding;
		_label.frameOptimizedForSize = FLRectCenterRectInRectHorizontally(myFrame, _label.frame);
		_text.frameOptimizedForSize = FLRectCenterRectInRectHorizontally(myFrame, FLRectAlignRectVertically(_label.frame, _text.frame));
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
