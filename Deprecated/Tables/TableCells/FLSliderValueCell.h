//
//	FLOnOffSwitchCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/26/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FLWideSingleLineLabelAndValueCell.h"
#import "FLCallbackObject.h"

@interface FLSliderValueCell : FLWideSingleLineLabelAndValueCell {
@private
	FLCallbackObject* _callback;
	UISlider* _slider;
}

@property (readonly, retain, nonatomic) UISlider* slider;
@property (readwrite, retain, nonatomic) FLCallbackObject* sliderValueChangedCallback;

+ (FLSliderValueCell*) sliderCell:(NSString*) labelOrNil;
+ (FLSliderValueCell*) sliderCell:(NSString*) label 
	minValue:(CGFloat) minValue 
	maxValue:(CGFloat) maxValue
	currentValue:(CGFloat) currentValue
	target:(id) target
	action:(SEL) action;

@end
