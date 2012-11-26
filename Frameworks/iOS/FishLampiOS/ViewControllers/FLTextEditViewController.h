//
//  FLTextEditViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/4/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLTextEditView.h"

#import "FLSimpleEditViewController.h"

@interface FLTextEditViewController : FLSimpleEditViewController<FLTextEditViewDelegate> {
@private
	FLTextEditView* _textEditView;
    NSInteger _maxSize;
    NSString* _text;
    NSString* _placeholderText;
    BOOL _returnKeyBeginsSave;
}

+ (FLTextEditViewController*) textEditViewController;

@property (readwrite, assign, nonatomic) NSInteger maxSize;

@property (readonly, assign, nonatomic) BOOL textIsTooLong;
@property (readonly, assign, nonatomic) NSUInteger textLength;

@property (readwrite, retain, nonatomic) NSString* text;
@property (readwrite, retain, nonatomic) NSString* placeholderText;

@property (readonly, retain, nonatomic) FLTextEditView* textEditView;

@property (readwrite, assign, nonatomic) BOOL returnKeyBeginsSave;

- (BOOL) canUpdateSaveButtonEnabledState;

- (void) startEditing;
- (void) stopEditing;

- (void) presentTextIsTooLongMessage;
- (void) truncateText;

- (NSString*) truncatedText;

@end
