//
//	FLNonGroupedBannerTableCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/27/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FLEditObjectTableViewCell.h"

#define FL_BANNER_CELL_HEIGHT 28

@interface FLNonGroupedBannerTableCell : FLEditObjectTableViewCell {
	NSString* _banner;
}

@property (readwrite, retain, nonatomic) NSString* banner;

@end
