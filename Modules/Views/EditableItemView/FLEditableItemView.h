//
//  FLEditableItemView.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/12/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FLEditableItemView;

typedef void (^FLEditableItemViewBlock)(FLEditableItemView* item);
typedef void (^FLEditableItemViewValidateBlock)(FLEditableItemView* item, BOOL* isValid);

@interface FLEditableItemView : UIView<UITextFieldDelegate> {
@private
    FLEditableItemViewValidateBlock _onValidate;
    FLEditableItemViewBlock _onChange;
    
    UILabel* _label;
    UITextField* _value;
    
    BOOL _validated;
}

@property (readwrite, assign, nonatomic, getter = isValidated) BOOL validated;

@property (readonly, strong, nonatomic) UILabel* label;
@property (readonly, strong, nonatomic) UITextField* value;

@property (readwrite, strong, nonatomic) NSString* labelText;
@property (readwrite, strong, nonatomic) NSString* valueText;
@property (readwrite, strong, nonatomic) NSString* placeHolderText;

@property (readwrite, copy, nonatomic) FLEditableItemViewValidateBlock onValidate;
@property (readwrite, copy, nonatomic) FLEditableItemViewBlock onChanged;

- (void) validateSelf;

+ (FLEditableItemView*) editableItemView;

- (CGFloat) calculateLabelWidth;

+ (FLEditableItemViewValidateBlock) validateIsNumber;

@end