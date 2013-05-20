//
//	GtTableViewCellSectionWidget.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/15/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTableViewCellSectionWidget.h"
#import "UIColor+More.h"
#import "GtPathUtilities.h"

@implementation GtTableViewCellSectionWidget

GtSynthesizeStructProperty(positionInSection, setPositionInSection, GtTableViewCellSectionWidgetPositionInSection, m_bgFlags);
GtSynthesizeStructProperty(separatorLine, setSeparatorLine, GtTableViewCellSeparatorLine, m_bgFlags);
GtSynthesizeStructProperty(drawMode, setDrawMode, GtTableViewCellSectionDrawMode, m_bgFlags);

@synthesize borderAlpha = m_borderAlpha;
@synthesize highlightedBorderColor = m_highlightedBorderColor;
@synthesize highlightedFillColor = m_highlightedFillColor;

@synthesize borderLineWidth = m_borderLineWidth;
@synthesize fillAlpha = m_fillAlpha;
@synthesize cornerRadius = m_cornerRadius;

@synthesize fillColor = m_fillColor;
@synthesize borderColor = m_borderColor;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.fillColor = [UIColor clearColor];
		self.borderColor = [UIColor whiteColor];
		self.borderLineWidth = 2.0;
		self.cornerRadius = 4.0;
		self.borderAlpha = 1.0;
		self.fillAlpha = 1.0;
		self.drawMode = GtTableViewCellSectionDrawModeAll;
		self.highlightedFillColor = [UIColor iPhoneBlueColor];
		
		self.themeAction = @selector(applyThemeToTableViewCellBackgroundWidget:);
	}
	
	return self;
}

- (void) dealloc
{
	GtRelease(m_highlightedFillColor);
	GtRelease(m_highlightedBorderColor);
	GtRelease(m_fillColor);
	GtRelease(m_borderColor);
	GtSuperDealloc();
}

- (void) _update
{
//	  self.backgroundColor = self.highlighted ? m_highlightedFillColor : m_fillColor;
//	  self.layer.borderColor = self.highlighted ? m_highlightedBorderColor.CGColor : m_borderColor.CGColor;
//	  self.layer.cornerRadius = m_cornerRadius;
//	  self.layer.borderWidth = self.borderLineWidth;
	[self setNeedsDisplay];
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

- (void)drawInRect:(CGRect)rect
{
//	  GtRgbColor borderColor = self.isHighlighted ? 
//		  self.highlightedBorderColor.colorStruct :
//		  self.borderColor.colorStruct;

	CGFloat lineWidth = 2.0f;

	GtColorStruct borderColor = self.borderColor.colorStruct;

	GtColorStruct fillColor = self.isHighlighted ? 
		self.highlightedFillColor.colorStruct :
		self.fillColor.colorStruct;

	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	CGContextSetAllowsAntialiasing(context, YES);

	CGFloat inset = lineWidth; ///2.0f; // 3.0f + (lineWidth/2.0f);
	rect = CGRectInset(self.frame, inset, inset);
			
	if(self.positionInSection != GtTableViewCellSectionWidgetPositionInSectionNone)
	{
		if(GtBitTestAny(self.drawMode, GtTableViewCellSectionDrawModeBorder|GtTableViewCellSectionDrawModeFill))
		{
			CGContextSetLineWidth(context, lineWidth);
			CGContextSetRGBFillColor(context, fillColor.red, fillColor.green, fillColor.blue, self.fillAlpha);
			CGContextSetRGBStrokeColor(context, borderColor.red, borderColor.green, borderColor.blue, self.borderAlpha);
			
			switch(self.positionInSection)
			{
				case GtTableViewCellSectionWidgetPositionInSectionAll:
				{
				
					CGMutablePathRef borderPath = CGPathCreateMutable();
					GtCreateRectPath(borderPath, /*CGRectInset(rect, 1, 1)*/ rect, self.cornerRadius);
					
					if(GtBitMaskTest(self.drawMode, GtTableViewCellSectionDrawModeFill))
					{
						CGContextAddPath(context, borderPath);
						CGContextFillPath(context);
					}
					if(GtBitMaskTest(self.drawMode, GtTableViewCellSectionDrawModeBorder))
					{
						CGContextAddPath(context, borderPath);
						CGContextStrokePath(context);
					}
					
					CGPathRelease(borderPath);
				}
				break;

				case GtTableViewCellSectionWidgetPositionInSectionTop:
				{
					rect.size.height += inset;

					if(GtBitMaskTest(self.drawMode, GtTableViewCellSectionDrawModeFill))
					{
						CGMutablePathRef fillPath = CGPathCreateMutable();
						GtCreateRectPathWithCornerRadii(fillPath, rect, self.cornerRadius, self.cornerRadius, 0, 0);
						CGContextAddPath(context, fillPath);
						CGContextFillPath(context);
						CGPathRelease(fillPath);
					}
					if(GtBitMaskTest(self.drawMode, GtTableViewCellSectionDrawModeBorder))
					{
						CGMutablePathRef borderPath = CGPathCreateMutable();
						GtCreatePartialRectPathTop(borderPath, rect, self.cornerRadius);
						CGContextAddPath(context, borderPath);
						CGContextStrokePath(context);
						CGPathRelease(borderPath);
					}
				}
				break;
				 
				case GtTableViewCellSectionWidgetPositionInSectionMiddle:
				{
					rect = CGRectInset(rect, 0, -inset);

					if(GtBitMaskTest(self.drawMode, GtTableViewCellSectionDrawModeFill))
					{
						CGMutablePathRef fillPath = CGPathCreateMutable();
						GtCreateRectPathWithCornerRadii(fillPath, rect, 0, 0, 0, 0);
						CGContextAddPath(context, fillPath);
						CGContextFillPath(context);
						CGPathRelease(fillPath);
					}
					if(GtBitMaskTest(self.drawMode, GtTableViewCellSectionDrawModeBorder))
					{
						CGMutablePathRef leftSide = CGPathCreateMutable();
						GtCreatePartialRectPathLeft(leftSide, rect, 0);
						CGContextAddPath(context, leftSide);
						CGContextStrokePath(context);
						CGPathRelease(leftSide);
						
						CGMutablePathRef rightSide = CGPathCreateMutable();
						GtCreatePartialRectPathRight(rightSide, rect, 0);
						CGContextAddPath(context, rightSide);
						CGContextStrokePath(context);
						CGPathRelease(rightSide);
					}
				}
				break; 
							   
				case GtTableViewCellSectionWidgetPositionInSectionBottom:
				{
					rect.origin.y -= inset; 
					rect.size.height += inset; 

					if(GtBitMaskTest(self.drawMode, GtTableViewCellSectionDrawModeFill))
					{
						CGMutablePathRef fillPath = CGPathCreateMutable();
						GtCreateRectPathWithCornerRadii(fillPath, rect, 0, 0, self.cornerRadius, self.cornerRadius);
						CGContextAddPath(context, fillPath);
						CGContextFillPath(context);
						CGPathRelease(fillPath);
					}
					if(GtBitMaskTest(self.drawMode, GtTableViewCellSectionDrawModeBorder))
					{
						CGMutablePathRef borderPath = CGPathCreateMutable();
						GtCreatePartialRectPathBottom(borderPath, rect, self.cornerRadius);
						CGContextAddPath(context, borderPath);
						CGContextStrokePath(context);
						CGPathRelease(borderPath);
					}

				}
				break;			  
						
				case GtTableViewCellSectionWidgetPositionInSectionNone:
				break;		
			}
		}
	}
	
	if( GtBitMaskTest(self.drawMode, GtTableViewCellSectionDrawModeSeperatorLine) &&
		self.separatorLine != GtTableViewCellSeparatorLineNone &&
		(	self.positionInSection == GtTableViewCellSectionWidgetPositionInSectionNone ||
			self.positionInSection == GtTableViewCellSectionWidgetPositionInSectionTop || 
			self.positionInSection == GtTableViewCellSectionWidgetPositionInSectionMiddle))
	{
		CGContextSetLineWidth(context, lineWidth);

		CGContextSetRGBStrokeColor(context, borderColor.red, borderColor.green, borderColor.blue, self.borderAlpha); 
		float bottom = GtRectGetBottom(rect) - lineWidth;
		CGContextMoveToPoint(context, rect.origin.x, bottom);
		CGContextAddLineToPoint(context , GtRectGetRight(rect), bottom);
		CGContextStrokePath(context);
	}
	
	CGContextRestoreGState(context);
	[super drawInRect:rect];
}

@end
