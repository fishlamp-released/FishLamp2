//
//	FLOnOffSwitchCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/26/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FLEditObjectTableViewCell.h"

@interface FLOnOffSwitchCell : FLEditObjectTableViewCell {
@private
	UISwitch* _switch;
	FLCallback_t _callback;
	BOOL _doUpdateDataSource;
}

@property (readonly, retain, nonatomic) UISwitch* switchControl;
@property (readwrite, assign, nonatomic) FLCallback_t switchChangedCallback;

@property (readwrite, assign, nonatomic,getter=isOn) BOOL on;

+ (FLOnOffSwitchCell*) onOffSwitchTableViewCell:(NSString*) titleOrNil;
+ (FLOnOffSwitchCell*) onOffSwitchTableViewCell:(NSString*) title 
	setOn:(BOOL) setOn 
	target:(id) target 
	action:(SEL) action;

@end

@interface FLLeftAlignedOnOffSwitchCell : FLOnOffSwitchCell {
}

@end