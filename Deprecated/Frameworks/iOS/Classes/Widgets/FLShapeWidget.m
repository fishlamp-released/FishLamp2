//
//	FLShapeWidget.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/20/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLShapeWidget.h"
#import "FLColorRange.h"


@implementation FLShapeWidget
@synthesize innerBorderColor = _innerBorderColor;
@synthesize cornerRadius = _cornerRadius;
@synthesize borderLineWidth = _lineWidth;
@synthesize borderGradient = _borderGradient;


- (id) initWithFrame:(CGRect) frame {
	if((self = [super initWithFrame:frame])) {
		self.borderLineWidth = 1.0f;
		
        // the border gradient is NOT a subwidget because we don't want it to be drawn
        // when we call [super drawRect], we're rendering it ourselves for the fram
		_borderGradient = [[FLGradientWidget alloc] initWithFrame:frame];
		[_borderGradient setColorRange:[FLColorRange colorRange:[UIColor blackColor] endColor:[UIColor grayColor]] forControlState:UIControlStateNormal];
        _borderGradient.parent = self;
    }
	
	return self;
}

- (void) dealloc {
	FLRelease(_borderGradient);
	FLRelease(_innerBorderColor);
	FLSuperDealloc();
}

-(void) createPathForShapeInRect:(CGMutablePathRef) path rect:(CGRect) rect {
}

- (void) layoutSubWidgets {
    
    [super layoutSubWidgets];
    
    _borderGradient.frame = self.frame;
}

- (void) drawRect:(CGRect) rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);

	rect = CGRectInset(self.frame, 1, 1);
    CGRect innerRect = CGRectInset(self.frame, _lineWidth + 1.0f, _lineWidth + 1.0f);
    
    // draw gradient for border
    CGMutablePathRef borderPath = CGPathCreateMutable();
	[self createPathForShapeInRect:borderPath rect:rect];
	CGContextAddPath(context, borderPath);
	CGContextClip(context);
	[_borderGradient drawWidget:self.frame];
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
	[super drawRect:rect]; // draw subWidgets in clip area

    // reset gstate 
	CGContextRestoreGState(context);
	
    // now draw inner border around subWidgets if we have a border color
    
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
}
@end
