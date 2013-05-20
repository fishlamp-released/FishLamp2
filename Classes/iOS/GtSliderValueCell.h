//
//	GtOnOffSwitchCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/26/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <UIKit/UIKit.h>

#import "GtWideSingleLineLabelAndValueCell.h"
#import "GtCallbackObject.h"

@interface GtSliderValueCell : GtWideSingleLineLabelAndValueCell {
@private
	GtCallbackObject* m_callback;
	UISlider* m_slider;
}

@property (readonly, retain, nonatomic) UISlider* slider;
@property (readwrite, retain, nonatomic) GtCallbackObject* sliderValueChangedCallback;

+ (GtSliderValueCell*) sliderCell:(NSString*) labelOrNil;
+ (GtSliderValueCell*) sliderCell:(NSString*) label 
	minValue:(CGFloat) minValue 
	maxValue:(CGFloat) maxValue
	currentValue:(CGFloat) currentValue
	target:(id) target
	action:(SEL) action;

@end
