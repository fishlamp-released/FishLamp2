//
//	GtTableViewCellBackgroundView.m
//	FishLamp
//
//	Created by Mike Fullerton on 1/25/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTableViewCellBackgroundView.h"

@implementation GtTableViewCellBackgroundView

@synthesize drawMode = m_mode;

GtSynthesizeStructProperty(drawMode, setDrawMode, GtTableViewCellBackgroundViewDrawMode, m_bgFlags);
GtSynthesizeStructProperty(separatorLine, setSeparatorLine, GtTableViewCellBackgroundViewSeparatorLine, m_bgFlags);

- (BOOL) drawDisclosureArrow
{
	return m_bgFlags.drawDisclosureArrow;
}

- (void) setDrawDisclosureArrow:(BOOL) doDraw
{
	m_bgFlags.drawDisclosureArrow = doDraw;
	[self setNeedsDisplay];
}

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.fillColor = [UIColor whiteColor];
		self.borderColor = [UIColor grayColor];
		self.borderLineWidth = 1.0;
		self.cornerRadius = 4.0;
		
		self.themeAction = @selector(applyThemeToTableViewCellBackgroundView:);
	}
	
	return self;
}

//- (CGRect) rectForPath
//{
//	  CGRect rect = [super rectForPath];
//
//	  switch(self.drawMode)
//	  {
//		  case GtTableViewCellBackgroundViewDrawModeTop:
//			  rect.size.height += 4;
//		  break;
//		  
//		  case GtTableViewCellBackgroundViewDrawModeMiddle:
//			  rect.origin.y -= 4;
//			  rect.size.height += 8;
//		  break;
//		  
//		  case GtTableViewCellBackgroundViewDrawModeBottom:
//			  rect.origin.y -= 4;
//			  rect.size.height += 4;
//		  break;
//		  
//		  case GtTableViewCellBackgroundViewDrawModeAll:
//		  break;
//	  }
//	  
//	  return rect;
//}



- (void)drawRect:(CGRect)rect
{
	[super drawRect:rect];
	
	CGContextRef ctx = UIGraphicsGetCurrentContext(); //get the graphics context
	UIGraphicsPushContext(ctx);
	
	if(	   (self.drawMode == GtTableViewCellBackgroundViewDrawModeTop || 
			self.drawMode == GtTableViewCellBackgroundViewDrawModeMiddle) &&
		self.separatorLine == GtTableViewCellBackgroundViewSeparatorLineSingleLine)
	{
		float pt = GtRectGetBottom(self.bounds);
		
		CGContextSetLineWidth(ctx, 2.0);
		
		CGFloat r = 0;
		CGFloat g = 0;
		CGFloat b = 0;
        CGFloat alpha = 0;
		[self.borderColor rgbValues:&r green:&g blue:&b alpha:&alpha];
		
		CGContextSetRGBStrokeColor(ctx, r, g, b, self.borderAlpha); 
		CGContextMoveToPoint(ctx, 0, pt);
		CGContextAddLineToPoint(ctx , self.bounds.size.width, pt);
		CGContextStrokePath(ctx);
	}
	
	if(self.drawDisclosureArrow)
	{
		[UITableViewCell drawDisclosureArrowInRect:self.bounds color:self.borderColor alpha:1.0f context:ctx];
	}
	
	UIGraphicsPopContext();
}

@end
