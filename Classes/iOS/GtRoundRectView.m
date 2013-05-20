//
//	GtRoundRectView.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/25/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtRoundRectView.h"
#import "GtPathUtilities.h"
#import "GtGeometry.h"

#define RECT_PADDING 2.0

@implementation GtRoundRectView

@synthesize borderAlpha = m_borderAlpha;
@synthesize highlightedBorderColor = m_highlightedBorderColor;
@synthesize highlightedFillColor = m_highlightedFillColor;

@synthesize borderLineWidth = m_borderLineWidth;
@synthesize fillAlpha = m_fillAlpha;
@synthesize cornerRadius = m_cornerRadius;

@synthesize fillColor = m_fillColor;
@synthesize borderColor = m_borderColor;

- (void) _update
{
//	  self.backgroundColor = self.highlighted ? m_highlightedFillColor : m_fillColor;
//	  self.layer.borderColor = self.highlighted ? m_highlightedBorderColor.CGColor : m_borderColor.CGColor;
	self.layer.cornerRadius = m_cornerRadius;
//	  self.layer.borderWidth = self.borderLineWidth;
	[self setNeedsLayout];
}

- (BOOL) highlighted
{
	return m_roundRectFlags.highlighted;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
	m_roundRectFlags.highlighted = highlighted;
	[self _update];
}

- (void) setHighlighted:(BOOL) highlighted
{
	[self setHighlighted:highlighted animated:YES];
}

- (void) dealloc
{
	GtRelease(m_highlightedFillColor);
	GtRelease(m_highlightedBorderColor);
	GtRelease(m_fillColor);
	GtRelease(m_borderColor);
	GtSuperDealloc();
}

- (void) setDefaults
{
	self.opaque = NO;
	self.autoresizingMask = UIViewAutoresizingNone;
	self.cornerRadius = GtRoundRectViewCornerRadiusDefault; 
	self.borderLineWidth = GtRoundRectViewBorderLineWidthDefault;
	self.multipleTouchEnabled = NO;
	self.userInteractionEnabled = NO;

	m_fillAlpha = 1.0;
	m_borderAlpha = 1.0;
	self.fillColor = [UIColor blackColor];
	self.borderColor = [UIColor whiteColor];
	self.highlightedFillColor = [UIColor iPhoneBlueColor];
	self.highlightedBorderColor = [UIColor whiteColor];
	self.layer.masksToBounds = YES;
	
//	  self.backgroundColor = [UIColor redColor];
	
	[self _update];
}

- (void) setFillColor:(UIColor*) color
{
	if(GtAssignObject(m_fillColor, color))
	{
		[self _update];
	}
}

- (void) setHighlightedFillColor:(UIColor*) color
{
	if(GtAssignObject(m_highlightedFillColor, color))
	{
		[self _update];
	}
}

- (void) setHighlightedBorderColor:(UIColor*) color
{
	if(GtAssignObject(m_highlightedBorderColor, color))
	{
		[self _update];
	}
}

- (void) setBorderColor:(UIColor*) color
{
	if(GtAssignObject(m_borderColor, color))
	{
		[self _update];
	}
}

- (void) setBorderAlpha:(CGFloat) alpha
{
	m_borderAlpha = alpha;
	[self _update];
}

- (void) setFillAlpha:(CGFloat) alpha
{
	m_fillAlpha = alpha;
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
	GtCreateRectPath(roundRectPath, rect, self.cornerRadius);
	
	GtColorStruct fillColor = self.highlighted ? m_highlightedFillColor.colorStruct : m_fillColor.colorStruct;
	CGContextSetRGBFillColor(context, fillColor.red, fillColor.green, fillColor.blue, self.fillAlpha);
	CGContextAddPath(context, roundRectPath);
	CGContextFillPath(context);

	GtColorStruct borderColor = self.highlighted ? m_highlightedBorderColor.colorStruct : m_borderColor.colorStruct;
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
