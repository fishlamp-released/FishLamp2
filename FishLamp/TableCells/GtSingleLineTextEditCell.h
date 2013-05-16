//
//  GtSingleLineTextEditCell.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/28/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtTextEditCell.h"

#define GtSingleLingTextEditCellHeight 50.0

@interface MyTextField : UITextField
{
    BOOL m_canResign;
}
- (void) setCanResignFirstResponder:(BOOL) canResign;

@end

@interface GtSingleLineTextEditCell : GtTextEditCell<UITextFieldDelegate> {
	MyTextField* m_textField;
    NSString* m_valueText;
}

//@property (readonly, retain, nonatomic) UITextField* textField;

- (CGFloat) cellHeight;

@end