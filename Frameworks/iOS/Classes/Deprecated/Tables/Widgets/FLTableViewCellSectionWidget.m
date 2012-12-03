//
//	FLTableViewCellSectionWidget.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/15/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLTableViewCellSectionWidget.h"
#import "FLColor+FLExtras.h"
#import "FLPathUtilities.h"

@implementation FLTableViewCellSectionWidget

FLSynthesizeStructProperty(positionInSection, setPositionInSection, FLTableViewCellSectionWidgetPositionInSection, _bgFlags);
FLSynthesizeStructProperty(separatorLine, setSeparatorLine, FLTableViewCellSeparatorLine, _bgFlags);
FLSynthesizeStructProperty(drawMode, setDrawMode, FLTableViewCellSectionDrawMode, _bgFlags);

@synthesize borderAlpha = _borderAlpha;
@synthesize highlightedBorderColor = _highlightedBorderColor;
@synthesize highlightedFillColor = _highlightedFillColor;

@synthesize borderLineWidth = _borderLineWidth;
@synthesize fillAlpha = _fillAlpha;
@synthesize cornerRadius = _cornerRadius;

@synthesize fillColor = _fillColor;
@synthesize borderColor = _borderColor;

- (id) initWithFrame:(FLRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.fillColor = [UIColor clearColor];
		self.borderColor = [UIColor whiteColor];
		self.borderLineWidth = 2.0;
		self.cornerRadius = 4.0;
		self.borderAlpha = 1.0;
		self.fillAlpha = 1.0;
		self.drawMode = FLTableViewCellSectionDrawModeAll;
		self.highlightedFillColor = [UIColor iPhoneBlueColor];
		
//		self.themeAction = @selector(applyThemeToTableViewCellBackgroundWidget:);
	}
	
	return self;
}

- (void) dealloc
{
	release_(_highlightedFillColor);
	release_(_highlightedBorderColor);
	release_(_fillColor);
	release_(_borderColor);
	super_dealloc_();
}

- (void) _update
{
//	  self.backgroundColor = self.highlighted ? _highlightedFillColor : _fillColor;
//	  self.layer.borderColor = self.highlighted ? _highlightedBorderColor.CGColor : _borderColor.CGColor;
//	  self.layer.cornerRadius = _cornerRadius;
//	  self.layer.borderWidth = self.borderLineWidth;
	[self setNeedsDisplay];
}

- (void) setFillColor:(UIColor*) color
{
	FLRetainObject_(_fillColor, color);
    [self _update];
}

- (void) setHighlightedFillColor:(UIColor*) color
{
	FLRetainObject_(_highlightedFillColor, color);
    [self _update];
}

- (void) setHighlightedBorderColor:(UIColor*) color
{
	FLRetainObject_(_highlightedBorderColor, color);
    [self _update];
}

- (void) setBorderColor:(UIColor*) color
{
    FLRetainObject_(_borderColor, color);
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

- (void)drawSelf:(FLRect)rect
{
//	  FLRgbColor borderColor = self.isHighlighted ? 
//		  self.highlightedBorderColor.color_t :
//		  self.borderColor.color_t;

	CGFloat lineWidth = 2.0f;

	FLColor_t borderColor = self.borderColor.color_t;

	FLColor_t fillColor = self.isHighlighted ? 
		self.highlightedFillColor.color_t :
		self.fillColor.color_t;

	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	CGContextSetAllowsAntialiasing(context, YES);

	CGFloat inset = lineWidth; ///2.0f; // 3.0f + (lineWidth/2.0f);
	rect = CGRectInset(self.frame, inset, inset);
			
	if(self.positionInSection != FLTableViewCellSectionWidgetPositionInSectionNone)
	{
		if(FLTestAnyBit(self.drawMode, FLTableViewCellSectionDrawModeBorder|FLTableViewCellSectionDrawModeFill))
		{
			CGContextSetLineWidth(context, lineWidth);
			CGContextSetRGBFillColor(context, fillColor.red, fillColor.green, fillColor.blue, self.fillAlpha);
			CGContextSetRGBStrokeColor(context, borderColor.red, borderColor.green, borderColor.blue, self.borderAlpha);
			
			switch(self.positionInSection)
			{
				case FLTableViewCellSectionWidgetPositionInSectionAll:
				{
				
					CGMutablePathRef borderPath = CGPathCreateMutable();
					FLCreateRectPath(borderPath, /*CGRectInset(rect, 1, 1)*/ rect, self.cornerRadius);
					
					if(FLTestBits(self.drawMode, FLTableViewCellSectionDrawModeFill))
					{
						CGContextAddPath(context, borderPath);
						CGContextFillPath(context);
					}
					if(FLTestBits(self.drawMode, FLTableViewCellSectionDrawModeBorder))
					{
						CGContextAddPath(context, borderPath);
						CGContextStrokePath(context);
					}
					
					CGPathRelease(borderPath);
				}
				break;

				case FLTableViewCellSectionWidgetPositionInSectionTop:
				{
					rect.size.height += inset;

					if(FLTestBits(self.drawMode, FLTableViewCellSectionDrawModeFill))
					{
						CGMutablePathRef fillPath = CGPathCreateMutable();
						FLCreateRectPathWithCornerRadii(fillPath, rect, self.cornerRadius, self.cornerRadius, 0, 0);
						CGContextAddPath(context, fillPath);
						CGContextFillPath(context);
						CGPathRelease(fillPath);
					}
					if(FLTestBits(self.drawMode, FLTableViewCellSectionDrawModeBorder))
					{
						CGMutablePathRef borderPath = CGPathCreateMutable();
						FLCreatePartialRectPathTop(borderPath, rect, self.cornerRadius);
						CGContextAddPath(context, borderPath);
						CGContextStrokePath(context);
						CGPathRelease(borderPath);
					}
				}
				break;
				 
				case FLTableViewCellSectionWidgetPositionInSectionMiddle:
				{
					rect = CGRectInset(rect, 0, -inset);

					if(FLTestBits(self.drawMode, FLTableViewCellSectionDrawModeFill))
					{
						CGMutablePathRef fillPath = CGPathCreateMutable();
						FLCreateRectPathWithCornerRadii(fillPath, rect, 0, 0, 0, 0);
						CGContextAddPath(context, fillPath);
						CGContextFillPath(context);
						CGPathRelease(fillPath);
					}
					if(FLTestBits(self.drawMode, FLTableViewCellSectionDrawModeBorder))
					{
						CGMutablePathRef leftSide = CGPathCreateMutable();
						FLCreatePartialRectPathLeft(leftSide, rect, 0);
						CGContextAddPath(context, leftSide);
						CGContextStrokePath(context);
						CGPathRelease(leftSide);
						
						CGMutablePathRef rightSide = CGPathCreateMutable();
						FLCreatePartialRectPathRight(rightSide, rect, 0);
						CGContextAddPath(context, rightSide);
						CGContextStrokePath(context);
						CGPathRelease(rightSide);
					}
				}
				break; 
							   
				case FLTableViewCellSectionWidgetPositionInSectionBottom:
				{
					rect.origin.y -= inset; 
					rect.size.height += inset; 

					if(FLTestBits(self.drawMode, FLTableViewCellSectionDrawModeFill))
					{
						CGMutablePathRef fillPath = CGPathCreateMutable();
						FLCreateRectPathWithCornerRadii(fillPath, rect, 0, 0, self.cornerRadius, self.cornerRadius);
						CGContextAddPath(context, fillPath);
						CGContextFillPath(context);
						CGPathRelease(fillPath);
					}
					if(FLTestBits(self.drawMode, FLTableViewCellSectionDrawModeBorder))
					{
						CGMutablePathRef borderPath = CGPathCreateMutable();
						FLCreatePartialRectPathBottom(borderPath, rect, self.cornerRadius);
						CGContextAddPath(context, borderPath);
						CGContextStrokePath(context);
						CGPathRelease(borderPath);
					}

				}
				break;			  
						
				case FLTableViewCellSectionWidgetPositionInSectionNone:
				break;		
			}
		}
	}
	
	if( FLTestBits(self.drawMode, FLTableViewCellSectionDrawModeSeperatorLine) &&
		self.separatorLine != FLTableViewCellSeparatorLineNone &&
		(	self.positionInSection == FLTableViewCellSectionWidgetPositionInSectionNone ||
			self.positionInSection == FLTableViewCellSectionWidgetPositionInSectionTop || 
			self.positionInSection == FLTableViewCellSectionWidgetPositionInSectionMiddle))
	{
		CGContextSetLineWidth(context, lineWidth);

		CGContextSetRGBStrokeColor(context, borderColor.red, borderColor.green, borderColor.blue, self.borderAlpha); 
		float bottom = FLRectGetBottom(rect) - lineWidth;
		CGContextMoveToPoint(context, rect.origin.x, bottom);
		CGContextAddLineToPoint(context , FLRectGetRight(rect), bottom);
		CGContextStrokePath(context);
	}
	
	CGContextRestoreGState(context);
	[super drawSelf:rect];
}

@end
