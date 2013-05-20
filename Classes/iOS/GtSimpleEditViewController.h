//
//  GtSimpleEditViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/6/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtViewController.h"

@class GtToolbarButton;

@interface GtSimpleEditViewController : GtViewController {
@private
    GtCallback m_beginSaveCallback;
    GtCallback m_beginCancelCallback;
    
    GtToolbarButton* m_saveButton;
	GtToolbarButton* m_cancelButton;
	NSString* m_saveButtonTitle;
    NSString* m_cancelButtonTitle;
    BOOL m_saveButtonEnabled;
    BOOL m_cancelButtonEnabled;
    BOOL m_saveButtonHidden;
    BOOL m_cancelButtonHidden;
    
	UIView* m_contentView;
}

@property (readwrite, retain, nonatomic) NSString* saveButtonTitle;
@property (readwrite, retain, nonatomic) NSString* cancelButtonTitle;

@property (readwrite, assign, nonatomic) BOOL saveButtonEnabled;
@property (readwrite, assign, nonatomic) BOOL saveButtonHidden;
@property (readwrite, assign, nonatomic) BOOL cancelButtonEnabled;
@property (readwrite, assign, nonatomic) BOOL cancelButtonHidden;

@property (readonly, retain, nonatomic) UIView* contentView;

@property (readwrite, assign, nonatomic) GtCallback beginSaveCallback;
@property (readwrite, assign, nonatomic) GtCallback beginCancelCallback;

- (UIView*) createBackgroundView; //GtGradientView by default

- (void) configureContentView;

- (void) stopEditing;

- (void) willBeginSaving;
- (void) beginSaving;
- (void) saveComplete;

- (void) beginCancel;
- (void) cancelComplete;

@end
