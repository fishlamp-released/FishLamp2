//
//  GtNonGroupedBannerTableCell.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GtTableViewCell.h"

#define GT_BANNER_CELL_HEIGHT 28

@interface GtNonGroupedBannerTableCell : GtTableViewCell {
	NSString* m_banner;
}

@property (readwrite, retain, nonatomic) NSString* banner;

@end
