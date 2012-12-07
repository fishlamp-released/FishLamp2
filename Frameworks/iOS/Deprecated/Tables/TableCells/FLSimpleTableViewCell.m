//
//	FLContentViewTableViewCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/3/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLSimpleTableViewCell.h"

@implementation FLSimpleTableViewCell

@synthesize subview = _subview;

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
	if(_subview)
	{
		[_subview removeFromSuperview];
	}

	_subview = retain_(view);
	if(_subview)
	{
		[self addSubview:_subview];
	}
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	_subview.newFrame = self.bounds;
}


- (void) dealloc
{
	FLRelease(_subview);
	super_dealloc_();
}

@end
