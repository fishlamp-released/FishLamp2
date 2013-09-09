//
//	FLTableViewCellBackgroundView.m
//	FishLamp
//
//	Created by Mike Fullerton on 1/25/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLTableViewCellBackgroundView.h"

@implementation FLTableViewCellBackgroundView

@synthesize drawMode = _mode;

FLSynthesizeStructProperty(drawMode, setDrawMode, FLTableViewCellBackgroundViewDrawMode, _bgFlags);
FLSynthesizeStructProperty(separatorLine, setSeparatorLine, FLTableViewCellBackgroundViewSeparatorLine, _bgFlags);

- (BOOL) drawDisclosureArrow
{
	return _bgFlags.drawDisclosureArrow;
}

- (void) setDrawDisclosureArrow:(BOOL) doDraw
{
	_bgFlags.drawDisclosureArrow = doDraw;
	[self setNeedsDisplay];
}

- (void) applyTheme:(FLTheme*) theme {
//	[object setFillColor:self.cellBackgroundColor];		  
//	[object setBorderColor:[UIColor darkGrayColor]];

	self.fillColor = [UIColor whiteColor];
    self.borderColor = [UIColor grayColor];
    self.borderLineWidth = 1.0;
    self.cornerRadius = 4.0;
}

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame])) {
        self.wantsApplyTheme = YES;
	}
	
	return self;
}

//- (CGRect) rectForPath
//{
//	  CGRect rect = [super rectForPath];
//
//	  switch(self.drawMode)
//	  {
//		  case FLTableViewCellBackgroundViewDrawModeTop:
//			  rect.size.height += 4;
//		  break;
//		  
//		  case FLTableViewCellBackgroundViewDrawModeMiddle:
//			  rect.origin.y -= 4;
//			  rect.size.height += 8;
//		  break;
//		  
//		  case FLTableViewCellBackgroundViewDrawModeBottom:
//			  rect.origin.y -= 4;
//			  rect.size.height += 4;
//		  break;
//		  
//		  case FLTableViewCellBackgroundViewDrawModeAll:
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
	
	if(	   (self.drawMode == FLTableViewCellBackgroundViewDrawModeTop || 
			self.drawMode == FLTableViewCellBackgroundViewDrawModeMiddle) &&
		self.separatorLine == FLTableViewCellBackgroundViewSeparatorLineSingleLine)
	{
		float pt = FLRectGetBottom(self.bounds);
		
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
