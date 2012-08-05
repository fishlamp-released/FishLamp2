//
//	FLSingleLineTextEditCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/28/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLTextEditCell.h"
#import "FLTextField.h"

#define FLSingleLingTextEditCellHeight 50.0

@interface FLSingleLineTextEditCell : FLTextEditCell<UITextFieldDelegate> {
}

@property (readonly, retain, nonatomic) FLTextField* textField;

+ (FLSingleLineTextEditCell*) singleLineTextEditCell:(NSString*) titleLabelOrNil; // can also be set with tableRow

@end


@interface FLPasswordTextEditCell : FLSingleLineTextEditCell {
}

+ (FLPasswordTextEditCell*) passwordTextEditCell:(NSString*) titleLabelOrNil; // can also be set with tableRow

@end