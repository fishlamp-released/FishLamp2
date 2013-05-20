//
//	GtBannerTableCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 1/10/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtBannerTableViewCell.h"

#import "GtGeometry.h"


@implementation GtBannerTableViewCell

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

+ (GtBannerTableViewCell*) bannerTableCell:(NSString*) banner
{
   GtBannerTableViewCell* cell = GtReturnAutoreleased([[[self class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GtBannerTableCell"]);
   cell.textLabelText = banner;
   return cell;
}

@end

@implementation GtButtonBannerTableViewCell

- (void) calculateCellHeightInTable:(UITableView *)tableView
{
    [super calculateCellHeightInTable:tableView];
    
    self.cellHeight = MAX(50, self.cellHeight);
}

@end

@implementation GtCenteredBannerTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
		self.label.textAlignment = UITextAlignmentCenter;
	}
	
	return self;
}

+ (GtCenteredBannerTableViewCell*) centeredBannerTableCell:(NSString*) banner
{
   GtCenteredBannerTableViewCell* cell = GtReturnAutoreleased([[GtCenteredBannerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GtCenteredBannerCell"]);
   cell.textLabelText = banner;
   return cell;
}


@end

@implementation GtTextAndImageBannerCell

@end
