//
//  FLFramedView.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLFramedView.h"
#import "SDKColor+FLMoreColors.h"

@implementation FLFramedView

@synthesize frameColor = _frameColor;
@synthesize backgroundColor = _backgroundColor;


- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.frameColor = [SDKColor gray85Color];
        self.backgroundColor = [SDKColor whiteColor];
    }
    return self;
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frameColor = [SDKColor gray85Color];
        self.backgroundColor = [SDKColor whiteColor];
    }
    
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_backgroundColor release];
    [_frameColor release];
    [super dealloc];
}
#endif

- (void)drawRect:(NSRect)dirtyRect {

    CGContextRef context = UIGraphicsGetCurrentContext();

    [_backgroundColor setFill];
    NSRectFill(dirtyRect);

    CGRect bounds = self.bounds;
    bounds.origin.x += 0.5f;
    bounds.origin.y += 0.5f;
    bounds.size.width -= 1.0f;
    bounds.size.height -= 1.0f;
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, bounds.origin.x, bounds.origin.y); //start point
    CGContextAddLineToPoint(context, FLRectGetRight(bounds), bounds.origin.y);
    CGContextAddLineToPoint(context, FLRectGetRight(bounds), FLRectGetBottom(bounds));
    CGContextAddLineToPoint(context, bounds.origin.x, FLRectGetBottom(bounds)); // end path
    CGContextClosePath(context); // close path

    [_frameColor set];
    CGContextSetLineWidth(context,1.0f);
    CGContextStrokePath(context);
    
}

@end
