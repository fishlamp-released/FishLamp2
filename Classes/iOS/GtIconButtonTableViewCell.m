//
//	GtIconButtonTableCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/27/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtIconButtonTableViewCell.h"
#import "GtGeometry.h"


@implementation GtIconButtonTableViewCell

@synthesize icon = m_icon;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
		m_imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		[self addSubview:m_imageView];
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
		GtReleaseWithNil(m_icon);
		m_icon = GtRetain(icon);
	
		m_imageView.image = m_icon;
		
		CGRect rect = CGRectZero;
		rect.size = m_icon.size;
		m_imageView.frameOptimizedForSize = rect;
		self.cellHeight = m_icon.size.height + 20;

		[self setNeedsLayout];
	}
}

- (void) dealloc
{
	GtReleaseWithNil(m_imageView);
	GtReleaseWithNil(m_icon);
	GtSuperDealloc();
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	m_imageView.frameOptimizedForSize = GtRectCenterRectInRect(self.bounds, m_imageView.frame);
}

#define LINE_VERT_COORD 63
#if DEBUG
//#warning use layer
#endif
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
