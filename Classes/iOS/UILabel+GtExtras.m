//
//	UILabel+GtExtras.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "UILabel+GtExtras.h"

@implementation UILabel (GtExtras)

- (CGSize) sizeThatFitsText:(CGSize) size
{
	return GtStringIsEmpty(self.text)? CGSizeZero : 
									[self.text sizeWithFont:self.font
									constrainedToSize:size
									lineBreakMode:self.lineBreakMode];
}
- (CGSize) sizeThatFitsText
{
	return [self sizeThatFitsText:CGSizeMake(2048.0, 2048.0)];
}
- (CGSize) sizeToFitText
{
	return [self sizeToFitText:CGSizeMake(2048.0, 2048.0)];

//	  return [self sizeToFitText:CGSizeMake(self.superview ? self.superview.bounds.size.width : 2048.0, 2048.0)];
}

- (CGSize) sizeToFitText:(CGSize) size
{
	CGSize outSize = GtSizeOptimizeForView([self sizeThatFitsText:size]);
	
	CGRect r = self.frame;
	r.size = outSize;
	r = GtRectGrowRectToOptimizedSizeIfNeeded(r);
	self.newFrame = r;

	return outSize;
}

- (void) drawUnderline:(CGRect) inRect 
	withColor:(UIColor*) color
	withLineWidth:(CGFloat) width
{
	CGContextRef context = UIGraphicsGetCurrentContext();

	float r,g,b,a;
	[color rgbValues:&r green:&g blue:&b alpha:&a];

	CGContextSetRGBStrokeColor(context, r, g, b, 1.0);

	// Draw them with a 1.0 stroke width.
	CGContextSetLineWidth(context, width);

	CGContextSetLineCap(context, kCGLineCapRound);

	float top = GtRectGetBottom(inRect) - 0.5;

	// Draw a single line from left to right
	CGContextMoveToPoint(context, GtRectGetLeft(inRect), top);
	CGContextAddLineToPoint(context, GtRectGetRight(inRect), top);
	CGContextStrokePath(context);
}

- (void)sizeToFitFixedWidth:(NSInteger)fixedWidth
{
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, fixedWidth, 0);
	self.lineBreakMode = UILineBreakModeWordWrap;
	self.numberOfLines = 0;
	[self sizeToFit];
}

- (void) addGlow
{
	if(OSVersionIsAtLeast3_2())
	{
		self.layer.shadowColor = [self.textColor CGColor];
		self.layer.shadowOffset = CGSizeMake(0.0, 0.0);
		self.layer.shadowRadius = 10.0;
		self.layer.shadowOpacity = 0.5;
		self.clipsToBounds = NO;
	}
}

@end
