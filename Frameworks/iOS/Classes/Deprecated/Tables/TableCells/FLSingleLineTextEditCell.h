//
//	FLSingleLineTextEditCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/28/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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