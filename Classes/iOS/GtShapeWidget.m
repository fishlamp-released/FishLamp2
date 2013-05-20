//
//	GtShapeWidget.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/20/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtShapeWidget.h"


@implementation GtShapeWidget
@synthesize borderColor = m_borderColor;
@synthesize cornerRadius = m_cornerRadius;
@synthesize borderLineWidth = m_lineWidth;
@synthesize borderGradient = m_gradientWidget;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.borderLineWidth = 1.0f;
		
		m_gradientWidget = [[GtGradientWidget alloc] initWithFrame:frame];
		[m_gradientWidget setGradientColors:[UIColor blackColor] endColor:[UIColor grayColor]];
	}
	
	return self;
}

- (void) dealloc
{
	GtRelease(m_gradientWidget);
	GtRelease(m_borderColor);
	GtSuperDealloc();
}

-(void) createPathForShapeInRect:(CGMutablePathRef) path rect:(CGRect) rect
{
}

- (void) drawOuterPath:(CGContextRef) context rect:(CGRect) rect
{
	m_gradientWidget.frame = self.frame;
	CGMutablePathRef path = CGPathCreateMutable();
	[self createPathForShapeInRect:path rect:rect];
	CGContextAddPath(context, path);
	CGContextClip(context);
	[m_gradientWidget drawRect:self.frame];
	CGPathRelease(path);
}

- (void) drawRect:(CGRect) rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();

	rect = CGRectInset(self.frame, 1, 1);
	[self drawOuterPath:context rect:rect];
	
	CGMutablePathRef innerPath = CGPathCreateMutable();
	CGRect innerRect = CGRectInset(self.frame, m_lineWidth + 1.0f, m_lineWidth + 1.0f);
	[self createPathForShapeInRect:innerPath rect:innerRect];
	CGContextAddPath(context, innerPath);
	CGContextClip(context);
	CGContextClearRect(context, innerRect);
	CGContextAddPath(context, innerPath);
	
	[super drawRect:rect];
	
	if(self.borderColor)
	{
		GtColorStruct borderColor = self.borderColor.colorStruct;
		CGContextSetRGBStrokeColor(context, borderColor.red, borderColor.green, borderColor.blue, borderColor.alpha);
		CGContextSetLineWidth(context, m_lineWidth);
		CGContextAddPath(context, innerPath);
		CGContextStrokePath(context);
	}
	
	CGPathRelease(innerPath);
}
@end
