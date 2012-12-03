//
//	FLButtonCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/14/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLLegacyButton.h"
#import "FLEditObjectTableViewCell.h"

#define FLButtonCellDefaultButtonHeight 40.0f
#define FLButtonCellDefaultCellHeight	50.0f

typedef enum {
	FLButtonCellButtonModeCenter,
	FLButtonCellButtonModeFill
} FLButtonCellButtonMode;

@interface FLButtonCell : FLEditObjectTableViewCell {
@private
	FLLegacyButton* _button;
	FLButtonCellButtonMode _mode;
}

@property (readwrite, assign, nonatomic) FLButtonCellButtonMode buttonMode;
@property (readwrite, retain, nonatomic) FLLegacyButton* button;

- (id) initWithButton:(FLLegacyButton*) button buttonMode :(FLButtonCellButtonMode) buttonMode;

+ (FLButtonCell*) buttonCell:(FLLegacyButton*) button buttonMode :(FLButtonCellButtonMode) buttonMode;


@end
