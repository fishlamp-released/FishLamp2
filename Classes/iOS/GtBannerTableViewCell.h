//
//	GtBannerTableCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/10/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtEditObjectTableViewCell.h"

@interface GtBannerTableViewCell : GtEditObjectTableViewCell {
@private
}
+ (id) bannerTableCell:(NSString*) banner;

@end


@interface GtCenteredBannerTableViewCell : GtBannerTableViewCell {
}
+ (GtCenteredBannerTableViewCell*) centeredBannerTableCell:(NSString*) banner;
@end

@interface GtTextAndImageBannerCell : GtEditObjectTableViewCell {
}
@end

@interface GtButtonBannerTableViewCell : GtBannerTableViewCell {
@private
}
@end