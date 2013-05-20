//
//	GtButtonCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/14/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtButton.h"
#import "GtEditObjectTableViewCell.h"

#define GtButtonCellDefaultButtonHeight 40.0f
#define GtButtonCellDefaultCellHeight	50.0f

typedef enum {
	GtButtonCellButtonModeCenter,
	GtButtonCellButtonModeFill
} GtButtonCellButtonMode;

@interface GtButtonCell : GtEditObjectTableViewCell {
@private
	GtButton* m_button;
	GtButtonCellButtonMode m_mode;
}

@property (readwrite, assign, nonatomic) GtButtonCellButtonMode buttonMode;
@property (readwrite, retain, nonatomic) GtButton* button;

- (id) initWithButton:(GtButton*) button buttonMode :(GtButtonCellButtonMode) buttonMode;

+ (GtButtonCell*) buttonCell:(GtButton*) button buttonMode :(GtButtonCellButtonMode) buttonMode;


@end
