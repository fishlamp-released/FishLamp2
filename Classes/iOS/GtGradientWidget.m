//
//	GtGradientWidget.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/8/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtGradientWidget.h"
#import "UIColor+More.h"

@implementation GtGradientWidget

@synthesize colors = m_colors;
@synthesize highlightedColors = m_highlightedColors;
@synthesize alpha = m_alpha;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		m_alpha = 1.0f;
		m_highlightedColors = [GtGradientWidget gradientColorsForColor:[UIColor iPhoneBlueColor]];
		self.themeAction = @selector(applyThemeToGradientWidget:);
	}
	return self;
}

- (void) setColors:(GtGradientColors) colors
{
	m_colors = colors;
	[self setNeedsDisplay];
}

- (void) setHighlightedColors:(GtGradientColors) colors
{
	m_highlightedColors = colors;
	[self setNeedsDisplay];
}

- (void) setGradientColors:(UIColor*) startColor endColor:(UIColor*) endColor
{
	m_colors.startColor = startColor.colorStruct;
	m_colors.endColor = endColor.colorStruct;
	[self setNeedsDisplay];
}

- (void) setHighlightedGradientColors:(UIColor*) startColor endColor:(UIColor*) endColor
{
	m_highlightedColors.startColor = startColor.colorStruct;
	m_highlightedColors.endColor = endColor.colorStruct;
	[self setNeedsDisplay];
}

+ (GtGradientColors) gradientColorsForColor:(UIColor*) color
{
	GtGradientColors colors;
	colors.startColor = color.colorStruct;
	colors.endColor = colors.startColor;
	colors.startColor = GtColorStructLighten(colors.startColor, .7);
	colors.endColor = GtColorStructDarken(colors.endColor, .7);
	return colors;
}	

- (void) drawRect:(CGRect) rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);

	GtGradientColors colors = 
		self.isHighlighted || self.isSelected ? m_highlightedColors : m_colors;
	
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	CGFloat colorArray[] =
	{
		colors.startColor.red, colors.startColor.green, colors.startColor.blue, m_alpha,
		colors.endColor.red, colors.endColor.green, colors.endColor.blue, m_alpha,
	};
	CGGradientRef	gradient = CGGradientCreateWithColorComponents(rgb, colorArray, NULL, sizeof(colorArray)/(sizeof(colorArray[0])*4));
	CGColorSpaceRelease(rgb);	 
	
    CGContextClipToRect(context, self.frame);
	CGContextDrawLinearGradient(context, gradient, 
		self.frame.origin, 
		CGPointMake(self.frame.origin.x, GtRectGetBottom(self.frame)),
		0);
	CGGradientRelease(gradient);
	CGContextRestoreGState(context);
   
	[super drawRect:rect];
}

@end
