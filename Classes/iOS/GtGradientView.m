//
//	GtGradientView.m
//	ShadowedTableView
//
//	Created by Matt Gallagher on 2009/08/21.
//	Copyright (c) 2013 Matt Gallagher. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtGradientView.h"
#import <QuartzCore/QuartzCore.h>

#import "UIColor+GtMoreColors.h"
#import "UIColor+More.h"

void GtGradientViewColorDeleteRed(GtGradientView* gradient)
{
	[gradient setGradientColors:GtRgbColor(236,19,20,1.0)  endColor:[UIColor fireEngineRed]];
}
void GtGradientViewColorPaleBlue(GtGradientView* gradient)
{
	[gradient setGradientColors:GtRgbColor(74,108,155,1.0) endColor:GtRgbColor(72,106,154,1.0)];
}
void GtGradientViewColorBrightBlue(GtGradientView* gradient)
{
	[gradient setGradientColors:GtRgbColor(36,99,222,1.0) endColor:GtRgbColor(34,96,221,1.0)];
}
void GtGradientViewColorDarkGray(GtGradientView* gradient)
{
	[gradient setGradientColors:GtRgbColor(71,71,73,1.0) endColor:GtRgbColor(33,33,35,1.0)];
}

void GtGradientViewColorDarkGrayWithBlueTint(GtGradientView* gradient)
{
	[gradient setGradientColors:GtRgbColor(65,71,80,1.0) endColor:GtRgbColor(43,50,59,1.0)];
}
void GtGradientViewColorBlack(GtGradientView* gradient)
{
	[gradient setGradientColors:[UIColor darkGrayColor] endColor:[UIColor blackColor]];
}

void GtGradientViewColorGray(GtGradientView* gradient)
{
	[gradient setGradientColors:GtRgbColor(71,71,73,1.0) endColor:GtRgbColor(33,33,35,1.0)];
}

void GtGradientViewColorLightGray(GtGradientView* gradient)
{
	[gradient setGradientColors:GtRgbColor(71,71,73,1.0)  endColor:GtRgbColor(33,33,35,1.0)];
}

@interface GtGradientView ()
@property (readwrite, retain, nonatomic) UIColor* gradientStartColor;
@property (readwrite, retain, nonatomic) UIColor* gradientEndColor;

@end

@implementation GtGradientView

//+ (Class)layerClass
//{
//	return [CAGradientLayer class];
//}

@synthesize gradientStartAlpha = m_gradientStartAlpha;
@synthesize gradientEndAlpha = m_gradientEndAlpha;

@synthesize gradientStartColor = m_gradientStartColor;
@synthesize gradientEndColor = m_gradientEndColor;

- (void) updateGradientColors
{
//	CAGradientLayer *gradientLayer = (CAGradientLayer *)self.layer;
//	gradientLayer.colors =
//		[NSArray arrayWithObjects:
//			(id)self.gradientStartColor.CGColor,
//			(id)self.gradientEndColor.CGColor,
//		nil];

	[self setNeedsDisplay];
}

- (void) dealloc
{
	GtRelease(m_gradientStartColor);
	GtRelease(m_gradientEndColor);
	GtSuperDealloc();
}

- (void) setGradientToLightLightGray
{
	self.backgroundColor = [UIColor whiteColor];

	self.gradientStartColor = [UIColor whiteColor];
	self.gradientEndColor = [UIColor gray85Color];
		[self updateGradientColors];
}

- (void) setGradientToDarkDarkGray
{
	self.backgroundColor = [UIColor darkGrayColor];

	self.gradientStartColor = [UIColor darkGrayColor];
	self.gradientEndColor = [UIColor gray10Color];
	 [self updateGradientColors];
}

- (void) setGradientToDarkGray
{
	self.backgroundColor = [UIColor grayColor];

	self.gradientStartColor = [UIColor grayColor];
	self.gradientEndColor = [UIColor darkGrayColor];
	[self updateGradientColors];
}

- (void) setGradientColors:(UIColor*) startColor endColor:(UIColor*) endColor
{
	self.backgroundColor = [UIColor clearColor];

	self.gradientStartColor = startColor;
	self.gradientEndColor = endColor;
	[self updateGradientColors];
}

- (void) setGradientColors:(GtGradientColorPair*) colors
{
    self.gradientStartColor = colors.startColor;
	self.gradientEndColor = colors.endColor;
	[self updateGradientColors];
}

- (id)initWithFrame:(CGRect)frame
{
	if ((self = [super initWithFrame:frame]))
	{	
		m_gradientEndAlpha = 1.0;
		m_gradientStartAlpha = 1.0;
		self.backgroundColor = [UIColor clearColor];

		self.themeAction = @selector(applyThemeToGradientView:);
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	m_gradientEndAlpha = 1.0;
	m_gradientStartAlpha = 1.0;
	self.backgroundColor = [UIColor clearColor];

	if ((self = [super initWithCoder:aDecoder]))
	{
		self.themeAction = @selector(applyThemeToGradientView:);
	}
	return self;
}

- (void) drawRect:(CGRect) rect
{
	[super drawRect:rect];
	CGContextRef context = UIGraphicsGetCurrentContext();

	GtColorStruct startColor = m_gradientStartColor.colorStruct;
	GtColorStruct endColor = m_gradientEndColor.colorStruct;

//	  CGFloat endr,endg,endb;
//	  CGFloat startr,startg,startb;
//	  
//	  [m_gradientStartColor rgbValues:&startr green:&startg blue:&startb];
//	  [m_gradientEndColor rgbValues:&endr green:&endg blue:&endb];
	
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	CGFloat colors[] =
	{
		startColor.red, startColor.green, startColor.blue, m_gradientStartAlpha,
		endColor.red, endColor.green, endColor.blue, m_gradientEndAlpha,
	};
	CGGradientRef	gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
	CGColorSpaceRelease(rgb);	 
	
	CGContextClipToRect(context, rect);
	CGContextDrawLinearGradient(context, gradient, 
		CGPointMake(0,0), 
		CGPointMake(0, self.bounds.size.height),
		0);
	CGGradientRelease(gradient);
}

+ (GtGradientView*) gradientViewWithColor:(UIColor*) color
{
	GtGradientView* view = GtReturnAutoreleased([[GtGradientView alloc] initWithFrame:CGRectZero]);
	view.themeAction = nil;
	
	GtColorStruct startColor = color.colorStruct;
	GtColorStruct endColor = color.colorStruct;
	
	startColor = GtColorStructLighten(startColor, .7);
	endColor = GtColorStructDarken(endColor, .7);
	
	[view setGradientColors:[UIColor colorWithRgbValues:startColor] endColor:[UIColor colorWithRgbValues:endColor]];
	
	return view;
}

@end

@implementation GtBlackGradientView

//+ (Class)layerClass
//{
//	return [CALayer class];
//}

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.backgroundColor = [UIColor darkDarkBlueTintedGrayColor];
	}
	
	return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
	if((self = [super initWithCoder:aDecoder]))
	{
		self.backgroundColor = [UIColor darkDarkBlueTintedGrayColor];
	}
	
	return self;
}

void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor) {
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGFloat locations[] = { 0.0, 1.0 };
	
	NSArray *colors = [NSArray arrayWithObjects:(id)startColor, (id)endColor, nil];
	
	CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef) colors, locations);
	
	CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
	CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
	
	CGContextSaveGState(context);
	CGContextAddRect(context, rect);
	CGContextClip(context);
	CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
	CGContextRestoreGState(context);
	
	CGGradientRelease(gradient);
	CGColorSpaceRelease(colorSpace);
}
CGRect rectFor1PxStroke(CGRect rect) {
	return CGRectMake(rect.origin.x + 0.5, rect.origin.y + 0.5, rect.size.width - 1, rect.size.height - 1);
}

void draw1PxStroke(CGContextRef context, CGPoint startPoint, CGPoint endPoint, CGColorRef color) {
	
	CGContextSaveGState(context);
	CGContextSetLineCap(context, kCGLineCapSquare);
	CGContextSetStrokeColorWithColor(context, color);
	CGContextSetLineWidth(context, 1.0);
	CGContextMoveToPoint(context, startPoint.x + 0.5, startPoint.y + 0.5);
	CGContextAddLineToPoint(context, endPoint.x + 0.5, endPoint.y + 0.5);
	CGContextStrokePath(context);
	CGContextRestoreGState(context);		
	
}
//- (void) drawRect:(CGRect) rect
//{
////	self.backgroundColor = [UIColor clearColor];
////	[super drawRect:rect];
//
//	  CGContextRef context = UIGraphicsGetCurrentContext();
//	  
//	  
//
//	  CGColorRef whiteColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor; 
//	  CGColorRef lightGrayColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0].CGColor;
//	  CGColorRef redColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0].CGColor;
//	  CGColorRef separatorColor = [UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1.0].CGColor;
//	  
//	  CGRect paperRect = self.bounds;
//
//	  // Fill with gradient
//	  drawLinearGradient(context, paperRect, whiteColor, lightGrayColor);
//	  
//	  // Add white 1 px stroke
//	  CGRect strokeRect = paperRect;
//	  strokeRect.size.height -= 1;
//	  strokeRect = rectFor1PxStroke(strokeRect);
//
//	  CGContextSetStrokeColorWithColor(context, whiteColor);
//	  CGContextSetLineWidth(context, 1.0);
//	  CGContextStrokeRect(context, strokeRect);
//	  
//	  // Add separator
//	  CGPoint startPoint = CGPointMake(paperRect.origin.x, paperRect.origin.y + paperRect.size.height - 1);
//	  CGPoint endPoint = CGPointMake(paperRect.origin.x + paperRect.size.width - 1, paperRect.origin.y + paperRect.size.height - 1);
//	  draw1PxStroke(context, startPoint, endPoint, separatorColor);
//
//}
//

//- (void)drawRect:(CGRect)rect
//{
//	  [super drawRect:rect];
//
////	rect.size.height -= 1;
////	rect.size.width -= 1;
//	CGFloat m_borderLineWidth = 1.0;
//	  
//	rect = CGRectInset(rect, m_borderLineWidth-0.5, m_borderLineWidth-0.5);
//	
//	CGPathRef roundRectPath = nil;
//	[GtViewUtilities createRoundRectPath:rect cornerRadius:4.0 outPath:&roundRectPath];
//	
//	CGContextRef context = UIGraphicsGetCurrentContext();
//	CGContextSetLineWidth(context, 1.0);
//	  
//	  UIColor* m_fillColor = [UIColor blackColor];
//	  UIColor* m_borderColor = [UIColor whiteColor];
//	  
//	if(m_fillColor)
//	{
//		CGFloat r = 0;
//		CGFloat g = 0;
//		CGFloat b = 0;
//		[m_fillColor rgbValues:&r green:&g blue:&b];
//		CGContextSetRGBFillColor(context, r, g, b, 1.0);
//	}
//	else
//	{
//		CGContextSetRGBFillColor(context, 0, 0, 0, 1.0);
//	}
//	CGContextAddPath(context, roundRectPath);
//	CGContextFillPath(context);
//
////	if(m_borderColor)
////	{
////		CGFloat r = 0;
////		CGFloat g = 0;
////		CGFloat b = 0;
////		[m_borderColor rgbValues:&r green:&g blue:&b];
////		CGContextSetRGBStrokeColor(context, r, g, b, 1.0);
////	}
////	else
////	{
////		CGContextSetRGBStrokeColor(context, 1, 1, 1, 1.0);
////	}
//	
//	  CGContextAddPath(context, roundRectPath);
//	CGContextStrokePath(context);
//	
//	CGPathRelease(roundRectPath);
//}

//- (void) onSetGradientColorProperties
//{
//	self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1.0f];
//	  self.gradientStartColor = [UIColor	colorWithWhite:0.1 alpha:1.0f];
//	  self.gradientEndColor = [UIColor	colorWithWhite:0.0 alpha:1.0f];
//	
//}
@end
