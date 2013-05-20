//
//  GtNonGroupedBannerTableCell.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtNonGroupedBannerTableCell.h"


@implementation GtNonGroupedBannerTableCell

@synthesize banner = m_banner;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	RunOnlyOnSdkVersion3
	{
		if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
		{
			
		
			self.textLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
			self.textLabel.textAlignment = UITextAlignmentCenter;
			self.textLabel.backgroundColor = [UIColor whiteColor];
			self.textLabel.textColor = [UIColor darkGrayColor];
			
			self.alpha = 0.8;
			self.contentView.backgroundColor = [UIColor whiteColor];
			self.backgroundColor = [UIColor whiteColor];
		}
	}
#if FISHLAMP_IPHONE_2_SDK			
	RunOnlyOnSdkVersion2
	{
		if(self = [super initWithFrame:CGRectZero reuseIdentifier:reuseIdentifier])
		{
		}
	}
#endif
	
	return self;
}


- (void)dealloc 
{
	GtRelease(m_banner);
    [super dealloc];
}
- (CGFloat) cellHeight
{
	return GT_BANNER_CELL_HEIGHT;
}

@end
