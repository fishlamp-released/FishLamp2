//
//  GtButtonCell.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/28/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtDisplayDataRow.h"
#import "GtTableViewCell.h"
#import "GtCustomButton.h"

@interface GtButtonCell : GtTableViewCell {
	GtCustomButton* m_button;
}

@property (readonly, assign, nonatomic) GtCustomButton* button;

@end
