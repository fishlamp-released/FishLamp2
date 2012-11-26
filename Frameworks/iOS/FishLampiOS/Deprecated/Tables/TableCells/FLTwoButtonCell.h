//
//	FLTwoButtonCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/19/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLEditObjectTableViewCell.h"
#import "FLLegacyButton.h"

@interface FLTwoButtonCell : FLEditObjectTableViewCell {
@private
	FLLegacyButton* _leftButton;
	FLLegacyButton* _rightButton;
}

@property (readwrite, retain, nonatomic) FLLegacyButton* leftButton;
@property (readwrite, retain, nonatomic) FLLegacyButton* rightButton;

+ (FLTwoButtonCell*) twoButtonCell;
//+ (FLTwoButtonCell*) twoButtonCell:(NSString*) leftTitle
//	  rightTitle:(NSString*) rightTitle
//	  target:(id) target
//	  leftAction:(SEL) leftAction
//	  rightAction:(SEL) rightAction;

+ (FLTwoButtonCell*) twoButtonCell:(FLLegacyButton*) leftButton
	rightButton:(FLLegacyButton*) rightButton;

@end
