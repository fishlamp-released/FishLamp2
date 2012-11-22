//
//	UITableView+FLExtras.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "UITableView+FLExtras.h"


@implementation UITableView (FLTableView)

- (CGFloat) calculateTotalHeight
{
    FLRect lastSectionRect = [self rectForSection:self.numberOfSections - 1];
    
    CGFloat height = FLRectGetBottom(lastSectionRect);
    
    return height;
}
@end


@implementation UITableViewCell (FLExtras)

#define ArrowSize 6
#define ArrowThickness 2.5

+ (void) drawDisclosureArrowInRect:(FLRect) rect 
	color:(UIColor*) color 
	alpha:(CGFloat) alpha
	context:(CGContextRef) ctx
{
	FLAssertIsNotNil_(color);
	FLAssertIsNotNil_(ctx);

	CGFloat r = 0;
	CGFloat g = 0;
	CGFloat b = 0;
    CGFloat ignore = 0;
	[color rgbValues:&r green:&g blue:&b  alpha:&ignore];
	CGContextSetRGBStrokeColor(ctx, r, g, b, alpha); 
	CGContextSetLineWidth(ctx, ArrowThickness);
	FLPoint pointOfArrow = CGPointMake(rect.size.width - 10.0f, (rect.size.height*0.5f));
	CGContextMoveToPoint(ctx, pointOfArrow.x - ArrowSize, pointOfArrow.y - ArrowSize);
	CGContextAddLineToPoint(ctx , pointOfArrow.x, pointOfArrow.y);
	CGContextAddLineToPoint(ctx , pointOfArrow.x - ArrowSize, pointOfArrow.y + ArrowSize);
	CGContextStrokePath(ctx);
}



@end