//
//	GtTwoButtonCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/19/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtEditObjectTableViewCell.h"
#import "GtButton.h"

@interface GtTwoButtonCell : GtEditObjectTableViewCell {
@private
	GtButton* m_leftButton;
	GtButton* m_rightButton;
}

@property (readwrite, retain, nonatomic) GtButton* leftButton;
@property (readwrite, retain, nonatomic) GtButton* rightButton;

+ (GtTwoButtonCell*) twoButtonCell;
//+ (GtTwoButtonCell*) twoButtonCell:(NSString*) leftTitle
//	  rightTitle:(NSString*) rightTitle
//	  target:(id) target
//	  leftAction:(SEL) leftAction
//	  rightAction:(SEL) rightAction;

+ (GtTwoButtonCell*) twoButtonCell:(GtButton*) leftButton
	rightButton:(GtButton*) rightButton;

@end
