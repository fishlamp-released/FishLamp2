//
//	FLBannerTableCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/10/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLEditObjectTableViewCell.h"

@interface FLBannerTableViewCell : FLEditObjectTableViewCell {
@private
}
+ (id) bannerTableCell:(NSString*) banner;

@end


@interface FLCenteredBannerTableViewCell : FLBannerTableViewCell {
}
+ (FLCenteredBannerTableViewCell*) centeredBannerTableCell:(NSString*) banner;
@end

@interface FLTextAndImageBannerCell : FLEditObjectTableViewCell {
}
@end

@interface FLButtonBannerTableViewCell : FLBannerTableViewCell {
@private
}
@end