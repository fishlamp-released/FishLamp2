//
//  FLHorizonalDragBarWidget.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/18/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLHorizonalDragBarWidget.h"

@implementation FLHorizonalDragBarWidget

@synthesize padding = _padding;
@synthesize lineThickness = _lineThickness;
@synthesize lineColor = _lineColor;
@synthesize style = _style;

- (id) initWithStyle:(FLHorizontalDragBarWidgetStyle) style
{
    if((self = [super init]))
    {
        self.padding = UIEdgeInsetsMake(4,4,4,4);
        self.style = style;
        self.lineThickness = 1.0;
        self.lineColor = [UIColor darkGrayColor];
    }
    
    return self;
}

+ (FLHorizonalDragBarWidget*) horizonalDragBarWidget:(FLHorizontalDragBarWidgetStyle)style
{
    return FLAutorelease([[FLHorizonalDragBarWidget alloc] initWithStyle:style]);
}

- (void) dealloc
{
    FLRelease(_lineColor);
    FLSuperDealloc();
}

- (void) drawRect:(CGRect) rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    CGRect frame = self.frame;
    FLColorValues rgb = [self.lineColor rgbColorValues];
    
    CGContextSetRGBStrokeColor(ctx, rgb.red, rgb.green, rgb.blue, 1.0); 
    CGContextSetLineWidth(ctx, self.lineThickness);

// TODO: round the end caps
    CGFloat top = (self.style == FLHorizontalDragBarWidgetStyleTop) ? 
            frame.origin.y + _padding.top :
            FLRectGetBottom(frame) - _padding.bottom - (self.lineThickness * 3.0f);
    
    CGFloat left = self.frame.origin.x + self.padding.left;
    CGFloat right = FLRectGetRight(self.frame) - self.padding.right;
    
    if(self.lineThickness < 2)
    {
        left -= 0.5;
        right += 0.5;
        top += 0.5;
    }
    
    CGContextMoveToPoint(ctx, left, top);
    CGContextAddLineToPoint(ctx , right, top);
    CGContextStrokePath(ctx);

    top += (self.lineThickness + 2.0f);

    CGContextMoveToPoint(ctx, left, top);
    CGContextAddLineToPoint(ctx , right, top);
    CGContextStrokePath(ctx);

    [super drawRect:rect];
}

@end
