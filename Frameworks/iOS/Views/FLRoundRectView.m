//
//	FLRoundRectView.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/25/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLRoundRectView.h"
#import "FLPathUtilities.h"
#import "FLGeometry.h"

#define RECT_PADDING 2.0

@implementation FLRoundRectView

@synthesize borderAlpha = _borderAlpha;
@synthesize highlightedBorderColor = _highlightedBorderColor;
@synthesize highlightedFillColor = _highlightedFillColor;

@synthesize borderLineWidth = _borderLineWidth;
@synthesize fillAlpha = _fillAlpha;
@synthesize cornerRadius = _cornerRadius;

@synthesize fillColor = _fillColor;
@synthesize borderColor = _borderColor;

- (void) _update
{
//	  self.backgroundColor = self.highlighted ? _highlightedFillColor : _fillColor;
//	  self.layer.borderColor = self.highlighted ? _highlightedBorderColor.CGColor : _borderColor.CGColor;
	self.layer.cornerRadius = _cornerRadius;
//	  self.layer.borderWidth = self.borderLineWidth;
	[self setNeedsLayout];
}

- (BOOL) highlighted
{
	return _roundRectFlags.highlighted;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
	_roundRectFlags.highlighted = highlighted;
	[self _update];
}

- (void) setHighlighted:(BOOL) highlighted
{
	[self setHighlighted:highlighted animated:YES];
}

- (void) dealloc
{
	FLRelease(_highlightedFillColor);
	FLRelease(_highlightedBorderColor);
	FLRelease(_fillColor);
	FLRelease(_borderColor);
	super_dealloc_();
}

- (void) setDefaults
{
	self.opaque = NO;
	self.autoresizingMask = UIViewAutoresizingNone;
	self.cornerRadius = FLRoundRectViewCornerRadiusDefault; 
	self.borderLineWidth = FLRoundRectViewBorderLineWidthDefault;
	self.multipleTouchEnabled = NO;
	self.userInteractionEnabled = NO;

	_fillAlpha = 1.0;
	_borderAlpha = 1.0;
	self.fillColor = [UIColor blackColor];
	self.borderColor = [UIColor whiteColor];
	self.highlightedFillColor = [UIColor iPhoneBlueColor];
	self.highlightedBorderColor = [UIColor whiteColor];
	self.layer.masksToBounds = YES;
	
	[self _update];
}

- (void) setFillColor:(UIColor*) color
{
	FLAssignObjectWithRetain(_fillColor, color);
	[self _update];
}

- (void) setHighlightedFillColor:(UIColor*) color
{
	FLAssignObjectWithRetain(_highlightedFillColor, color);
    [self _update];
}

- (void) setHighlightedBorderColor:(UIColor*) color
{
	FLAssignObjectWithRetain(_highlightedBorderColor, color);
    [self _update];
}

- (void) setBorderColor:(UIColor*) color
{
	FLAssignObjectWithRetain(_borderColor, color);
    [self _update];
}

- (void) setBorderAlpha:(CGFloat) alpha
{
	_borderAlpha = alpha;
	[self _update];
}

- (void) setFillAlpha:(CGFloat) alpha
{
	_fillAlpha = alpha;
	[self _update];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	[self setDefaults];
	
	if ((self = [super initWithCoder:aDecoder])) 
	{
	}
	
	return self;
}

- (id)initWithFrame:(CGRect)frame 
{
	if ((self = [super initWithFrame:frame])) 
	{
		[self setDefaults];
	}
	
	return self;
}

- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);

	rect = CGRectInset(self.bounds, self.borderLineWidth/2.0f, self.borderLineWidth/2.0f);
	
	CGMutablePathRef roundRectPath = CGPathCreateMutable();
	FLCreateRectPath(roundRectPath, rect, self.cornerRadius);
	
	FLColor_t fillColor = self.highlighted ? _highlightedFillColor.color_t : _fillColor.color_t;
	CGContextSetRGBFillColor(context, fillColor.red, fillColor.green, fillColor.blue, self.fillAlpha);
	CGContextAddPath(context, roundRectPath);
	CGContextFillPath(context);

	FLColor_t borderColor = self.highlighted ? _highlightedBorderColor.color_t : _borderColor.color_t;
	CGContextAddPath(context, roundRectPath);
	CGContextSetRGBStrokeColor(context, borderColor.red, borderColor.green, borderColor.blue, self.borderAlpha);
	CGContextSetLineWidth(context, self.borderLineWidth);
	CGContextStrokePath(context);

	CGContextAddPath(context, roundRectPath);
	CGContextClip(context);
	[super drawRect:rect];

	CGPathRelease(roundRectPath);
	CGContextRestoreGState(context);
}

- (void) layoutSubviews
{
	[self setNeedsDisplay];
	
	[super layoutSubviews];
}

@end
