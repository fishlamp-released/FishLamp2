//
//  FLSimpleEditViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/6/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLViewController.h"

@class FLToolbarButtonDeprecated;

@interface FLSimpleEditViewController : FLViewController {
@private
    FLCallback _beginSaveCallback;
    FLCallback _beginCancelCallback;
    
    FLToolbarButtonDeprecated* _saveButton;
	FLToolbarButtonDeprecated* _cancelButton;
	NSString* _saveButtonTitle;
    NSString* _cancelButtonTitle;
    BOOL _saveButtonEnabled;
    BOOL _cancelButtonEnabled;
    BOOL _saveButtonHidden;
    BOOL _cancelButtonHidden;
    
	UIView* _contentView;
}

@property (readwrite, retain, nonatomic) NSString* saveButtonTitle;
@property (readwrite, retain, nonatomic) NSString* cancelButtonTitle;

@property (readwrite, assign, nonatomic) BOOL saveButtonEnabled;
@property (readwrite, assign, nonatomic) BOOL saveButtonHidden;
@property (readwrite, assign, nonatomic) BOOL cancelButtonEnabled;
@property (readwrite, assign, nonatomic) BOOL cancelButtonHidden;

@property (readonly, retain, nonatomic) UIView* contentView;

@property (readwrite, assign, nonatomic) FLCallback beginSaveCallback;
@property (readwrite, assign, nonatomic) FLCallback beginCancelCallback;

- (UIView*) createBackgroundView; //FLGradientView by default

- (void) configureContentView;

- (void) stopEditing;

- (void) willBeginSaving;
- (void) beginSaving;
- (void) saveComplete;

- (void) beginCancel;
- (void) cancelComplete;

@end
