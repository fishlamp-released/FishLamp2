//
//	FLBannerTableCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/10/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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