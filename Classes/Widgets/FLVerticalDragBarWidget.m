//
//  FLVerticalDragBarWidget.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/18/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLVerticalDragBarWidget.h"

#define kThickness 2


@implementation FLVerticalDragBarWidget

@synthesize padding = _padding;
@synthesize lineThickness = _lineThickness;
@synthesize lineColor = _lineColor;
@synthesize style = _style;

- (id) initWithStyle:(FLVerticalDragBarWidgetStyle) style
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

+ (FLVerticalDragBarWidget*) verticalDragBarWidget:(FLVerticalDragBarWidgetStyle) style
{
    return FLReturnAutoreleased([[FLVerticalDragBarWidget alloc] initWithStyle:style]);
}

- (void) dealloc
{
    FLRelease(_lineColor);
    FLSuperDealloc();
}

- (void) drawSelf:(FLRect) rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    FLRect frame = self.frame;
    FLColor_t rgb = [self.lineColor color_t];
    
    CGContextSetRGBStrokeColor(ctx, rgb.red, rgb.green, rgb.blue, 1.0); 
    CGContextSetLineWidth(ctx, self.lineThickness);

// TODO: round the end caps
    CGFloat left = (self.style == FLVerticalDragBarWidgetStyleLeft) ? 
            frame.origin.x + _padding.left :
            FLRectGetRight(frame) - _padding.right - (self.lineThickness * 3.0f);
    
    if(self.lineThickness < 2)
    {
        left -= 0.5;
    }
    
    CGContextMoveToPoint(ctx, left, frame.origin.y + _padding.top);
    CGContextAddLineToPoint(ctx , left, FLRectGetBottom(frame) - _padding.bottom);
    CGContextStrokePath(ctx);

    CGContextMoveToPoint(ctx, left + (self.lineThickness + 2.0f), frame.origin.y + + _padding.top);
    CGContextAddLineToPoint(ctx , left + (self.lineThickness + 2.0f), FLRectGetBottom(frame) - _padding.bottom);
    CGContextStrokePath(ctx);

    [super drawSelf:rect];
}

@end
