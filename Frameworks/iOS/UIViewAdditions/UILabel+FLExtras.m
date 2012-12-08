//
//	UILabel+FLExtras.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "UILabel+FLExtras.h"
#import "FLColor+FLExtras.h"

@implementation UILabel (FLExtras)

- (CGSize) sizeThatFitsText:(CGSize) size
{
	return FLStringIsEmpty(self.text)? CGSizeZero : 
									[self.text sizeWithFont:self.font
									constrainedToSize:size
									lineBreakMode:self.lineBreakMode];
}
- (CGSize) sizeThatFitsText
{
	return [self sizeThatFitsText:FLSizeMake(2048.0, 2048.0)];
}
- (CGSize) sizeToFitText
{
	return [self sizeToFitText:FLSizeMake(2048.0, 2048.0)];

//	  return [self sizeToFitText:FLSizeMake(self.superview ? self.superview.bounds.size.width : 2048.0, 2048.0)];
}

- (CGSize) sizeToFitText:(CGSize) size
{
	CGSize outSize = FLSizeOptimizeForView([self sizeThatFitsText:size]);
	
	CGRect r = self.frame;
	r.size = outSize;
	r = FLRectOptimizedForViewSize(r);
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

	float top = FLRectGetBottom(inRect) - 0.5;

	// Draw a single line from left to right
	CGContextMoveToPoint(context, FLRectGetLeft(inRect), top);
	CGContextAddLineToPoint(context, FLRectGetRight(inRect), top);
	CGContextStrokePath(context);
}

- (CGSize)sizeThatFitsWidth:(CGFloat)fixedWidth
{   
    return [self sizeThatFitsText:FLSizeMake(fixedWidth, 2048)];
}

- (void)sizeToFitWidth:(CGFloat)fixedWidth
{
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, fixedWidth, 0);
	self.lineBreakMode = UILineBreakModeWordWrap;
	self.numberOfLines = 0;
	[self sizeToFit];
}

- (void) addGlow
{
    self.layer.shadowColor = [self.textColor CGColor];
    self.layer.shadowOffset = FLSizeMake(0.0, 0.0);
    self.layer.shadowRadius = 10.0;
    self.layer.shadowOpacity = 0.5;
    self.clipsToBounds = NO;
}

@end
