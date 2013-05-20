//
//	GtContentViewTableViewCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/3/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSimpleTableViewCell.h"

@implementation GtSimpleTableViewCell

@synthesize subview = m_subview;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
		self.alpha = 1.0;
		self.opaque = YES;
	}

	return self;
}

- (void) setSubview:(UIView*) view
{
	if(m_subview)
	{
		[m_subview removeFromSuperview];
	}

	m_subview = GtRetain(view);
	if(m_subview)
	{
		[self addSubview:m_subview];
	}
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	m_subview.newFrame = self.bounds;
}


- (void) dealloc
{
	GtRelease(m_subview);
	GtSuperDealloc();
}

@end
