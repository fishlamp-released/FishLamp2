//
//	FLNonGroupedBannerTableCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/27/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLNonGroupedBannerTableCell.h"


@implementation FLNonGroupedBannerTableCell

@synthesize banner = _banner;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
		self.label.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
		self.label.textAlignment = UITextAlignmentCenter;
		self.label.backgroundColor = [UIColor whiteColor];
		self.label.textColor = [UIColor darkGrayColor];
		
		self.alpha = 0.8;
		self.backgroundColor = [UIColor whiteColor];
		self.cellHeight = FL_BANNER_CELL_HEIGHT;
	}

	return self;
}

- (void)dealloc 
{
	FLReleaseWithNil(_banner);
	FLSuperDealloc();
}


@end
