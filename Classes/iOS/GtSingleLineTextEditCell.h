//
//	GtSingleLineTextEditCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/28/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTextEditCell.h"
#import "GtTextField.h"

#define GtSingleLingTextEditCellHeight 50.0

@interface GtSingleLineTextEditCell : GtTextEditCell<UITextFieldDelegate> {
}

@property (readonly, retain, nonatomic) GtTextField* textField;

+ (GtSingleLineTextEditCell*) singleLineTextEditCell:(NSString*) titleLabelOrNil; // can also be set with tableRow

@end


@interface GtPasswordTextEditCell : GtSingleLineTextEditCell {
}

+ (GtPasswordTextEditCell*) passwordTextEditCell:(NSString*) titleLabelOrNil; // can also be set with tableRow

@end