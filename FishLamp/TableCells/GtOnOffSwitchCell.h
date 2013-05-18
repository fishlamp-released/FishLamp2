//
//  GtOnOffSwitchCell.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/26/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GtDisplayDataRow.h"
#import "GtTableViewCell.h"

@interface GtOnOffSwitchCell : GtTableViewCell {
	UISwitch* m_switch;
}

@property (readwrite, copy, nonatomic) NSString* displayText;
@property (readwrite, assign, nonatomic) BOOL checked;

@end
