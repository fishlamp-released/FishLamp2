//
//	FLMultiLineTextEditCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/28/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLTextEditCell.h"
#import "FLRoundRectView.h"
#import "FLTextView.h"

#define FL_TEXT_EDITING_SIZE 125
#define FL_EDITING_ROW_HEIGHT 150	

@interface FLMultiLineTextEditCell : FLTextEditCell<UITextViewDelegate> {
@private
	FLTextView* _textView;
	FLTextInputTraits* _traits;
	NSUInteger _numberOfLines;
	BOOL _resizeOnEdit;
    BOOL _disallowReturnKey;
}

@property (readwrite, assign, nonatomic) BOOL disallowReturnKey;
@property (readwrite, assign, nonatomic) BOOL resizeOnEdit; // defaults to YES
@property (readwrite, assign, nonatomic) NSUInteger numberOfLines;
@property (readwrite, retain, nonatomic) FLTextInputTraits* textInputTraits;

+ (FLMultiLineTextEditCell*) multiLineTextEditCell:(NSString*) titleLabelOrNil;

@end

