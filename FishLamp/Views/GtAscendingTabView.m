//
//  GtAscendingTabView.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/4/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtAscendingTabView.h"

@implementation GtAscendingTabView

@synthesize line1 = m_line1;
@synthesize line2 = m_line2;
@synthesize topAdjust = m_topAdjust;

#define ROUND_RECT_CORNER_RADIUS 6.0
#define BACKGROUND_OPACITY 0.75
#define STROKE_OPACITY 0.20
#define RECT_PADDING 2.0


- (void) setDefaults
{
	self.opaque = NO;
	self.autoresizingMask = UIViewAutoresizingNone;
		
	m_backgroundOpacity = BACKGROUND_OPACITY;
	m_borderOpacity = STROKE_OPACITY;
}

- (void) dealloc
{
	GtRelease(m_line1);
	GtRelease(m_line2);
	[super dealloc];
}

- (void) layoutSubviews
{
	[super layoutSubviews];

	if(m_line1.text && m_line1.text.length > 0)
	{
		CGRect superBounds = self.superview.bounds;

		CGSize size1 = [m_line1.text sizeWithFont:m_line1.font
			constrainedToSize:CGSizeMake(superBounds.size.width, 20)
			lineBreakMode:UILineBreakModeTailTruncation];

		CGSize size2 = CGSizeZero;
		
		if(m_line2.text && m_line2.text.length > 0)
		{
			size2 = [m_line2.text sizeWithFont:m_line2.font
				constrainedToSize:CGSizeMake(superBounds.size.width, 20)
				lineBreakMode:UILineBreakModeTailTruncation];
		}

				CGRect frame = self.frame;
		
		frame.size.height = size1.height + size2.height + 6;
		frame.size.width = MAX(size1.width, size2.width) + 26;
		frame.origin.y = m_topAdjust;
		
	//	frame.origin.x = superBounds.size.width - frame.size.width;
		
	//	frame.origin.x += 3;
	//	frame.origin.y -= 1;
		
		frame = GtCenterRectHorizontallyInRect(superBounds, frame);
		frame = GtBottomJustifyRectInRect(superBounds, frame);
		self.frame = frame;
		
		m_line1.frame = CGRectMake(0,6, self.bounds.size.width - 4, size1.height);
		
		if(size2.height)
		{
			m_line2.frame = CGRectMake(0,size1.height, self.bounds.size.width - 4, size2.height);
		}
		
		[self setNeedsDisplay];
	}
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder]) {
		[self setDefaults];
	}
	
	return self;
}
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) 
	{
		[self setDefaults];
		
		m_line1 = [GtAlloc(UILabel) initWithFrame:CGRectZero];
		m_line1.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
//		m_line1.shadowColor = [UIColor blackColor];
		m_line1.textColor = [UIColor whiteColor];
		m_line1.backgroundColor = [UIColor clearColor];
		m_line1.textAlignment = UITextAlignmentCenter;
		[self addSubview:m_line1];
	
		m_line2 = [GtAlloc(UILabel) initWithFrame:CGRectZero];
		m_line2.font = m_line1.font;
//		m_line2.shadowColor = m_line1.shadowColor;
		m_line2.textColor = m_line1.textColor ;
		m_line2.backgroundColor = m_line1.backgroundColor;
		m_line2.textAlignment = UITextAlignmentCenter;
		[self addSubview:m_line2];
	}
	
    return self;
}



- (void) createTabRectPath:(CGPathRef*) outPath
{
	//
	// Create the boundary path
	//
/*	
	CGRect rect = self.bounds;
	rect.size.height -= 1;
	rect.size.width -= 1;
	
	rect = CGRectInset(rect, RECT_PADDING, RECT_PADDING);
	
	CGPoint startPt = rect.origin;
	
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, 
		NULL,
		startPt.x,
		startPt.y);

	startPt.y = (rect.size.height - ROUND_RECT_CORNER_RADIUS );

	CGPathAddLineToPoint(path, NULL, startPt.x, startPt.y);
	
	CGPoint endPt = startPt;
	endPt.x = ROUND_RECT_CORNER_RADIUS + rect.origin.x;
	endPt.y = rect.size.height - rect.origin.y;
	
	// Top left corner
	CGPathAddArcToPoint(path, NULL,
		startPt.x,
		endPt.x,
		startPt.y,
		endPt.y,
		ROUND_RECT_CORNER_RADIUS);
	
	startPt.x = rect.size.width - rect.origin.x;
				
	CGPathAddLineToPoint(path, NULL, startPt.x, startPt.y);	

	startPt.y = rect.origin.y;
	
	CGPathAddLineToPoint(path, NULL, startPt.x, startPt.y);		

	startPt = rect.origin;

	CGPathAddLineToPoint(path, NULL, startPt.x, startPt.y);		
				
	// Close the path at the rounded rect
	CGPathCloseSubpath(path);
*/

	CGFloat cornerRadius = ROUND_RECT_CORNER_RADIUS;

	CGRect rect = self.bounds;
	rect.size.height -= 1;
	rect.size.width -= 1;
	
	rect = CGRectInset(rect, RECT_PADDING, RECT_PADDING);
	
	CGMutablePathRef path = CGPathCreateMutable();
	
	// Bottom Left
	CGPathMoveToPoint(path, NULL,
		rect.origin.x,
		rect.origin.y + rect.size.height - cornerRadius);

	// Top left corner

	CGPathAddArcToPoint(path, NULL,
		rect.origin.x,
		rect.origin.y,
		rect.origin.x + rect.size.width,
		rect.origin.y,
		cornerRadius);

	// Top right corner

	CGPathAddArcToPoint(path, NULL,
		rect.origin.x + rect.size.width,
		rect.origin.y,
		rect.origin.x + rect.size.width,
		rect.origin.y + rect.size.height,
		cornerRadius);


//	CGPathAddLineToPoint(path, NULL, rect.origin.x + rect.size.width, rect.origin.y);	


	// Bottom right corner
/*
	CGPathAddArcToPoint(path, NULL,
		rect.origin.x + rect.size.width,
		rect.origin.y + rect.size.height,
		rect.origin.x,
		rect.origin.y + rect.size.height,
		cornerRadius);
*/
	CGPathAddLineToPoint(path, NULL, rect.origin.x + rect.size.width, rect.origin.y + rect.size.width);	

/*
	// Bottom left corner
	CGPathAddArcToPoint(path, NULL,
		rect.origin.x,
		rect.origin.y + rect.size.height,
		rect.origin.x,
		rect.origin.y,
		cornerRadius);
*/

	CGPathAddLineToPoint(path, NULL, rect.origin.x , rect.origin.y + rect.size.width);	


	// Close the path at the rounded rect
	CGPathCloseSubpath(path);
	
	*outPath = path;
}

- (void)drawRect:(CGRect)rect
{
//	rect.size.height -= 1;
//	rect.size.width -= 1;
	
//	rect = CGRectInset(rect, RECT_PADDING, RECT_PADDING);
	
	CGPathRef roundRectPath = nil;
	[self createTabRectPath:&roundRectPath];
	
	CGContextRef context = UIGraphicsGetCurrentContext();

	CGContextSetRGBFillColor(context, 0, 0, 0, m_backgroundOpacity);
	CGContextAddPath(context, roundRectPath);
	CGContextFillPath(context);

	CGContextSetRGBStrokeColor(context, 1, 1, 1, m_borderOpacity);
	CGContextAddPath(context, roundRectPath);
	CGContextStrokePath(context);
	
	CGPathRelease(roundRectPath);
}

@end
