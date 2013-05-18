//
//  GtRoundRectView.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/25/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import "GtRoundRectView.h"
#import "GtViewUtilities.h"
#import "GtGeometry.h"
#import "GtColors.h"

@implementation GtRoundRectView

@synthesize optionalBackgroundColor = m_backgroundColor;
@synthesize outlineColor = m_outlineColor;
@synthesize borderOpacity = m_borderOpacity;
@synthesize backgroundOpacity = m_backgroundOpacity;

#define ROUND_RECT_CORNER_RADIUS 5.0
#define BACKGROUND_OPACITY 0.70
#define STROKE_OPACITY 0.90
#define RECT_PADDING 2.0

- (void) dealloc
{
	GtRelease(m_backgroundColor);
	GtRelease(m_outlineColor);
	[super dealloc];
}

- (void) setDefaults
{
	self.opaque = NO;
	self.autoresizingMask = UIViewAutoresizingNone;
		
	m_backgroundOpacity = BACKGROUND_OPACITY;
	m_borderOpacity = STROKE_OPACITY;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder]) {
		[self setDefaults];
	}
	
	return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		[self setDefaults];
	}
	
    return self;
}

- (void)drawRect:(CGRect)rect
{
	rect.size.height -= 1;
	rect.size.width -= 1;
	
	rect = CGRectInset(rect, RECT_PADDING, RECT_PADDING);
	
	CGPathRef roundRectPath = nil;
	[GtViewUtilities createRoundRectPath:rect cornerRadius:ROUND_RECT_CORNER_RADIUS outPath:&roundRectPath];
	
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetLineWidth(context, 1.5);
    
	if(m_backgroundColor)
	{
		CGFloat r = 0;
		CGFloat g = 0;
		CGFloat b = 0;
		[m_backgroundColor rgbValues:&r green:&g blue:&b];
		CGContextSetRGBFillColor(context, r, g, b, m_backgroundOpacity);
	}
	else
	{
		CGContextSetRGBFillColor(context, 0, 0, 0, m_backgroundOpacity);
	}
	CGContextAddPath(context, roundRectPath);
	CGContextFillPath(context);

	if(m_outlineColor)
	{
		CGFloat r = 0;
		CGFloat g = 0;
		CGFloat b = 0;
		[m_outlineColor rgbValues:&r green:&g blue:&b];
		CGContextSetRGBStrokeColor(context, r, g, b, m_backgroundOpacity);
	}
	else
	{
		CGContextSetRGBStrokeColor(context, 1, 1, 1, m_borderOpacity);
	}
	CGContextAddPath(context, roundRectPath);
	CGContextStrokePath(context);
	
	CGPathRelease(roundRectPath);
}



@end
