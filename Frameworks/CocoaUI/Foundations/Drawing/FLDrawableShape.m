//
//  FLDrawableShape.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 12/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDrawableShape.h"
#import "FLPathUtilities.h"

@implementation FLDrawableShape

@synthesize innerBorderColor = _innerBorderColor;
@synthesize cornerRadius = _cornerRadius;
@synthesize borderLineWidth = _lineWidth;
@synthesize borderGradient = _borderGradient;

-(void) createPathForShapeInRect:(CGMutablePathRef) path rect:(CGRect) rect {

}

- (id) init {
    self = [super init];
    if(self) {
        self.borderLineWidth = 1.0f;
		
        // the border gradient is NOT a subwidget because we don't want it to be drawn
        // when we call [super drawSelf], we're rendering it ourselves for the fram
		_borderGradient = [[FLDrawableGradient alloc] init];
		[_borderGradient setColorRange:[FLColorRange colorRange:[UIColor blackColor] endColor:[UIColor grayColor]]];

    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_borderGradient release];
    [super dealloc];
}
#endif


- (void) drawRect:(CGRect) drawRect  {

	CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);

    CGRect frame = self.frame;

	CGRect rect = CGRectInset(frame, 1, 1);
    CGRect innerRect = CGRectInset(frame, _lineWidth + 1.0f, _lineWidth + 1.0f);
    
    // draw gradient for border
    CGMutablePathRef borderPath = CGPathCreateMutable();
	[self createPathForShapeInRect:borderPath rect:rect];
	CGContextAddPath(context, borderPath);
	CGContextClip(context);
    
    [_borderGradient drawRect:drawRect frame:frame superBounds:self.superBounds];
    CGPathRelease(borderPath);
    
    // clip out contents
    CGMutablePathRef innerPath = CGPathCreateMutable();
    [self createPathForShapeInRect:innerPath rect:innerRect];
	CGContextAddPath(context, innerPath);
	CGContextClip(context);
	CGContextClearRect(context, innerRect);
    
    // Now all we have is our nice gradient border, now we need to draw contents
    
    CGContextAddPath(context, innerPath);
	CGContextClip(context);

    self.finishDrawingBlock = ^{
        // reset gstate 
        CGContextRestoreGState(context);
        
        // now draw inner border around subwidgets if we have a border color
        
        if(_innerBorderColor) {
            CGContextSaveGState(context);
            
            // TODO: use color components instead of UIColor+t
            FLColorValues borderColor = _innerBorderColor.rgbColorValues;
            CGContextSetRGBStrokeColor(context, borderColor.red, borderColor.green, borderColor.blue, borderColor.alpha);
            CGContextSetLineWidth(context, _lineWidth);
            CGContextAddPath(context, innerPath);
            CGContextClip(context);
            CGContextStrokePath(context);

            CGContextRestoreGState(context);
        }
        
        CGPathRelease(innerPath);
    };
}      

@end

@implementation FLDrawableBackButtonShape

@synthesize pointSize = _pointSize;

- (id) initWithPointSize:(CGFloat) pointSize {
    self = [super init];
    if(self) {
        self.pointSize = pointSize;
    }
    
    return self;
}

-(void) createPathForShapeInRect:(CGMutablePathRef) path rect:(CGRect) rect {
	FLCreateRectPathBackButtonShape(path, rect, self.cornerRadius, _pointSize);
}

@end
