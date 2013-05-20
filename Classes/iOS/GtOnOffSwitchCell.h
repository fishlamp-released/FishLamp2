//
//	GtOnOffSwitchCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/26/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <UIKit/UIKit.h>

#import "GtEditObjectTableViewCell.h"

@interface GtOnOffSwitchCell : GtEditObjectTableViewCell {
@private
	UISwitch* m_switch;
	GtCallback m_callback;
	BOOL m_doUpdateDataSource;
}

@property (readonly, retain, nonatomic) UISwitch* switchControl;
@property (readwrite, assign, nonatomic) GtCallback switchChangedCallback;

@property (readwrite, assign, nonatomic,getter=isOn) BOOL on;

+ (GtOnOffSwitchCell*) onOffSwitchTableViewCell:(NSString*) titleOrNil;
+ (GtOnOffSwitchCell*) onOffSwitchTableViewCell:(NSString*) title 
	setOn:(BOOL) setOn 
	target:(id) target 
	action:(SEL) action;

@end

@interface GtLeftAlignedOnOffSwitchCell : GtOnOffSwitchCell {
}

@end