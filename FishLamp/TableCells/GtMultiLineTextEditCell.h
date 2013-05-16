//
//  GtMultiLineTextEditCell.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/28/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtTextEditCell.h"
#import "GtRoundRectView.h"

#define GT_TEXT_EDITING_SIZE 125
#define GT_EDITING_ROW_HEIGHT GT_TEXT_EDITING_SIZE + 26 

@interface MyTextView : UITextView {
    BOOL m_canResign;
}
- (void) setCanResignFirstResponder:(BOOL) canResign;
@end

@interface GtMultiLineTextEditCell : GtTextEditCell<UITextViewDelegate> {
	MyTextView* m_textView;
}

- (CGFloat) cellHeight;
@end

