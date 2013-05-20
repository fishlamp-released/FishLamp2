//
//  GtTextEditView.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/4/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtRoundRectView.h"
#import "GtTextView.h" 
#import "GtLabel.h"

@class GtTextEditView;

@protocol GtTextEditViewTheme <NSObject>
- (void) applyThemeToTextEditView:(GtTextEditView*) view;
@end

@protocol GtTextEditViewDelegate;

@interface GtTextEditView : UIView<UITextViewDelegate> {
@private
    id<GtTextEditViewDelegate> m_delegate;
	GtRoundRectView* m_roundRectView;
    
    GtTextView* m_textView;
    GtLabel* m_countdownView;
	
	NSInteger m_maxSize;
	UIColor* m_countdownColor;
	NSInteger m_remaining;
    BOOL m_dissallowReturnKey;
}

@property (readwrite, assign, nonatomic) id<GtTextEditViewDelegate> delegate;

@property (readwrite, retain, nonatomic) NSString* placeholderText;
@property (readwrite, copy, nonatomic) NSString* text;
@property (readwrite, copy, nonatomic) GtTextDescriptor* textDescriptor;
@property (readwrite, assign, nonatomic) NSInteger maxSize;
@property (readonly, retain, nonatomic) GtLabel* countdownView;
@property (readonly, retain, nonatomic) GtRoundRectView* textViewFrameView;
@property (readwrite, assign, nonatomic) BOOL dissallowReturnKey;

- (void) handleTextDidChange;
- (void) startEditing;
- (void) stopEditing;

@end

@protocol GtTextEditViewDelegate <NSObject>
- (void) textEditView:(GtTextEditView*) textEditView textDidChange:(NSString*) text;
- (void) textEditView:(GtTextEditView*) textEditView userTappedReturnKey:(NSString*) text; // only if dissallowReturnKey == YES
@end

