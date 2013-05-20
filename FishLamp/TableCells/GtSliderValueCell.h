//
//  GtOnOffSwitchCell.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/26/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GtDisplayDataRow.h"
#import "GtWideSingleLineLabelAndValueCell.h"

@interface GtSliderValueCell : GtWideSingleLineLabelAndValueCell {
	UISlider* m_slider;
}

@property (readonly, assign, nonatomic) UISlider* slider;

@end
