//
//  GtBannerTableCell.h
//  MyZen
//
//  Created by Mike Fullerton on 1/10/10.
//  Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "GtTableViewCell.h"

@interface GtBannerTableCell : GtTableViewCell {
    NSString* m_banner;
    UILabel* m_label;
}

@property (readwrite, assign, nonatomic) NSString* banner;

@end
