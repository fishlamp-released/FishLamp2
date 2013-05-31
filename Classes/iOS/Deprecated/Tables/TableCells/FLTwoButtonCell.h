//
//	FLTwoButtonCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/19/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
