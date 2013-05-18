//
//  GtWideSingleLineLabelAndValueCell.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/28/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtWideSingleLineLabelAndValueCell.h"

#define HEIGHT 35.0

@implementation GtWideSingleLineLabelAndValueCell 

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier 	
{
	if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
	{
		self.value.textAlignment = UITextAlignmentRight;
	}
	return self;
}

- (CGFloat) cellHeight
{
	return HEIGHT;
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	CGRect superBounds = self.contentView.bounds;
	
	CGRect frame = superBounds;
	frame.size.height = HEIGHT;
	frame = CGRectInset(frame, 10, 0);
	self.label.frame = frame;
	self.value.frame = frame;
}

@end