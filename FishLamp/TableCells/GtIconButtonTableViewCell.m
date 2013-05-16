//
//  GtIconButtonTableCell.m
//  MyZen
//
//  Created by Mike Fullerton on 12/27/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtIconButtonTableViewCell.h"
#import "GtGeometry.h"
#import "GtColors.h"

@implementation GtIconButtonTableViewCell

@synthesize icon = m_icon;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
	{
		m_imageView = [GtAlloc(UIImageView) initWithFrame:CGRectZero];
		[self.contentView addSubview:m_imageView];
				
		self.contentView.backgroundColor = [UIColor almostWhiteGrayColor];
	}
	
	return self;
}

- (void) setCallback:(id) target action:(SEL) action
{
}

- (void) setIcon:(UIImage*) icon
{
	if(m_icon != icon)
	{
		GtRelease(m_icon);
		m_icon = [icon retain];
	
		m_imageView.image = m_icon;
		
		CGRect rect = CGRectZero;
		rect.size = m_icon.size;
		m_imageView.frame = rect;
		
		[self setNeedsLayout];
	}
}

- (void) dealloc
{
	GtRelease(m_imageView);
	GtRelease(m_icon);
	GtRelease(m_callback);
	[super dealloc];
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	m_imageView.frame = GtCenterRectInRect(self.contentView.bounds, m_imageView.frame);
}

- (CGFloat) cellHeight
{
	return m_icon.size.height + 20;
}

#define LINE_VERT_COORD 63

- (void)drawRect:(CGRect)rect
{
	[super drawRect:rect];
	
	CGContextRef ctx = UIGraphicsGetCurrentContext(); //get the graphics context
	CGContextSetLineWidth(ctx, 1.0);
	CGContextSetRGBStrokeColor(ctx, 0.5, 0.5, 0.5, 1); 
	
	CGContextMoveToPoint(ctx, 0.5, 0.5);
	CGContextAddLineToPoint(ctx , self.bounds.size.width, 0.5);
	
	
	CGContextMoveToPoint(ctx, 0, self.bounds.size.height);
	CGContextAddLineToPoint(ctx , self.bounds.size.width, self.bounds.size.height);
	CGContextStrokePath(ctx);

}

@end
