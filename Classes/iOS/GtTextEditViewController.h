//
//  GtTextEditViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/4/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtTextEditView.h"

#import "GtSimpleEditViewController.h"

@interface GtTextEditViewController : GtSimpleEditViewController<GtTextEditViewDelegate> {
@private
	GtTextEditView* m_textEditView;
    NSInteger m_maxSize;
    NSString* m_text;
    NSString* m_placeholderText;
    BOOL m_returnKeyBeginsSave;
}

+ (GtTextEditViewController*) textEditViewController;

@property (readwrite, assign, nonatomic) NSInteger maxSize;

@property (readonly, assign, nonatomic) BOOL textIsTooLong;
@property (readonly, assign, nonatomic) NSUInteger textLength;

@property (readwrite, retain, nonatomic) NSString* text;
@property (readwrite, retain, nonatomic) NSString* placeholderText;

@property (readonly, retain, nonatomic) GtTextEditView* textEditView;

@property (readwrite, assign, nonatomic) BOOL returnKeyBeginsSave;

- (BOOL) canUpdateSaveButtonEnabledState;

- (void) startEditing;
- (void) stopEditing;

- (void) presentTextIsTooLongMessage;
- (void) truncateText;

- (NSString*) truncatedText;

@end
