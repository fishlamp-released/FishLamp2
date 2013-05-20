//
//  FLTextEditView.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/4/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLRoundRectView.h"
#import "FLTextView.h" 
#import "FLLabel.h"

@protocol FLTextEditViewDelegate;

@interface FLTextEditView : UIView<UITextViewDelegate> {
@private
    __unsafe_unretained id<FLTextEditViewDelegate> _delegate;
	FLRoundRectView* _roundRectView;
    
    FLTextView* _textView;
    FLLabel* _countdownView;
	
	NSInteger _maxSize;
	UIColor* _countdownColor;
	NSInteger _remaining;
    BOOL _dissallowReturnKey;
}

@property (readwrite, assign, nonatomic) id<FLTextEditViewDelegate> delegate;

@property (readwrite, retain, nonatomic) NSString* placeholderText;
@property (readwrite, copy, nonatomic) NSString* text;
@property (readwrite, copy, nonatomic) FLTextDescriptor* textDescriptor;
@property (readwrite, assign, nonatomic) NSInteger maxSize;
@property (readonly, retain, nonatomic) FLLabel* countdownView;
@property (readonly, retain, nonatomic) FLRoundRectView* textViewFrameView;
@property (readwrite, assign, nonatomic) BOOL dissallowReturnKey;

- (void) handleTextDidChange;
- (void) startEditing;
- (void) stopEditing;

@end

@protocol FLTextEditViewDelegate <NSObject>
- (void) textEditView:(FLTextEditView*) textEditView textDidChange:(NSString*) text;
- (void) textEditView:(FLTextEditView*) textEditView userTappedReturnKey:(NSString*) text; // only if dissallowReturnKey == YES
@end

