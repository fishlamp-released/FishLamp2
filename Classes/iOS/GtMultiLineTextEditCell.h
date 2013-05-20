//
//	GtMultiLineTextEditCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/28/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTextEditCell.h"
#import "GtRoundRectView.h"
#import "GtTextView.h"

#define GT_TEXT_EDITING_SIZE 125
#define GT_EDITING_ROW_HEIGHT 150	

@interface GtMultiLineTextEditCell : GtTextEditCell<UITextViewDelegate> {
@private
	GtTextView* m_textView;
	GtTextInputTraits* m_traits;
	NSUInteger m_numberOfLines;
	BOOL m_resizeOnEdit;
    BOOL m_disallowReturnKey;
}

@property (readwrite, assign, nonatomic) BOOL disallowReturnKey;
@property (readwrite, assign, nonatomic) BOOL resizeOnEdit; // defaults to YES
@property (readwrite, assign, nonatomic) NSUInteger numberOfLines;
@property (readwrite, retain, nonatomic) GtTextInputTraits* textInputTraits;

+ (GtMultiLineTextEditCell*) multiLineTextEditCell:(NSString*) titleLabelOrNil;

@end

