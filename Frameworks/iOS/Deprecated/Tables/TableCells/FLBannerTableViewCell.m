//
//	FLBannerTableCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 1/10/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLBannerTableViewCell.h"

#import "FLGeometry.h"


@implementation FLBannerTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
		self.label.backgroundColor = [UIColor clearColor];
		self.label.lineBreakMode = UILineBreakModeWordWrap;
		self.label.numberOfLines = 0;
		self.label.autoresizingMask = UIViewAutoresizingFlexibleEverything;
		self.label.textAlignment = UITextAlignmentLeft;
		self.label.highlightedTextColor = [UIColor whiteColor];
	}
	return self;
}

+ (FLBannerTableViewCell*) bannerTableCell:(NSString*) banner
{
   FLBannerTableViewCell* cell = FLAutorelease([[[self class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FLBannerTableCell"]);
   cell.textLabelText = banner;
   return cell;
}

@end

@implementation FLButtonBannerTableViewCell

- (void) calculateCellHeightInTable:(UITableView *)tableView
{
    [super calculateCellHeightInTable:tableView];
    
    self.cellHeight = MAX(50, self.cellHeight);
}

@end

@implementation FLCenteredBannerTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
		self.label.textAlignment = UITextAlignmentCenter;
	}
	
	return self;
}

+ (FLCenteredBannerTableViewCell*) centeredBannerTableCell:(NSString*) banner
{
   FLCenteredBannerTableViewCell* cell = FLAutorelease([[FLCenteredBannerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FLCenteredBannerCell"]);
   cell.textLabelText = banner;
   return cell;
}


@end

@implementation FLTextAndImageBannerCell

@end
