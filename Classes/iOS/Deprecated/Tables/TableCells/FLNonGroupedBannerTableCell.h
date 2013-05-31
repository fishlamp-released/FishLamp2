//
//	FLNonGroupedBannerTableCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/27/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <UIKit/UIKit.h>

#import "FLEditObjectTableViewCell.h"

#define FL_BANNER_CELL_HEIGHT 28

@interface FLNonGroupedBannerTableCell : FLEditObjectTableViewCell {
	NSString* _banner;
}

@property (readwrite, retain, nonatomic) NSString* banner;

@end
