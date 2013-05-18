//
//  GtTwoButtonCell.h
//  MyZen
//
//  Created by Mike Fullerton on 12/19/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtTableViewCell.h"

@interface GtTwoButtonCell : GtTableViewCell {
    UIButton* m_leftButton;
    UIButton* m_rightButton;
}

@property (readonly, assign, nonatomic) UIButton* leftButton;
@property (readonly, assign, nonatomic) UIButton* rightButton;

@end
