//
//	FLShapeWidget.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/20/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLShapeWidget.h"
#import "FLColorRange.h"


@implementation FLShapeWidget
@synthesize innerBorderColor = _innerBorderColor;
@synthesize cornerRadius = _cornerRadius;
@synthesize borderLineWidth = _lineWidth;
@synthesize borderGradient = _borderGradient;


- (id) initWithFrame:(FLRect) frame {
	if((self = [super initWithFrame:frame])) {
		self.borderLineWidth = 1.0f;
		
        // the border gradient is NOT a subwidget because we don't want it to be drawn
        // when we call [super drawSelf], we're rendering it ourselves for the fram
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

-(void) createPathForShapeInRect:(CGMutablePathRef) path rect:(FLRect) rect {
}

- (void) layoutWidgets {
    
    [super layoutWidgets];
    
    _borderGradient.frame = self.frame;
}

- (void) drawSelf:(FLRect) rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);

	rect = CGRectInset(self.frame, 1, 1);
    FLRect innerRect = CGRectInset(self.frame, _lineWidth + 1.0f, _lineWidth + 1.0f);
    
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
	[super drawSelf:rect]; // draw subwidgets in clip area

    // reset gstate 
	CGContextRestoreGState(context);
	
    // now draw inner border around subwidgets if we have a border color
    
    if(_innerBorderColor) {
        CGContextSaveGState(context);
        
        // TODO: use color components instead of FLColor+t
		FLColor_t borderColor = _innerBorderColor.color_t;
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
