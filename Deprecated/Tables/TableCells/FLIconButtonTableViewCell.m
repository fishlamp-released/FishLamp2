//
//	FLIconButtonTableCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/27/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLIconButtonTableViewCell.h"
#import "FLGeometry.h"


@implementation FLIconButtonTableViewCell

@synthesize icon = _icon;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
		_iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		[self addSubview:_iconImageView];
	}
	
	return self;
}

- (void) setCallback:(id) target action:(SEL) action
{
}

- (void) setIcon:(UIImage*) icon
{
	if(_icon != icon)
	{
		FLReleaseWithNil(_icon);
		_icon = FLReturnRetained(icon);
	
		_iconImageView.image = _icon;
		
		CGRect rect = CGRectZero;
		rect.size = _icon.size;
		_iconImageView.frameOptimizedForSize = rect;
		self.cellHeight = _icon.size.height + 20;

		[self setNeedsLayout];
	}
}

- (void) dealloc
{
	FLReleaseWithNil(_iconImageView);
	FLReleaseWithNil(_icon);
	FLSuperDealloc();
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	_iconImageView.frameOptimizedForSize = FLRectCenterRectInRect(self.bounds, _iconImageView.frame);
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
