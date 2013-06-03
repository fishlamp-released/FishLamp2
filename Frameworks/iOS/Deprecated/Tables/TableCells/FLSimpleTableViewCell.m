//
//	FLContentViewTableViewCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/3/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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

	_subview = FLRetain(view);
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
	FLSuperDealloc();
}

@end
