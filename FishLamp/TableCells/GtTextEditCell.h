//
//  GtTextEditCell.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/15/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#if DEBUG
#define DEBUG 1
#endif

#import "GtDisplayDataRow.h"
#import "GtTwoLineLabelAndValueCell.h"
#import "GtTextEditCellData.h"
#import "GtViewAnimator.h"

@interface GtTextEditCell : GtTwoLineLabelAndValueCell {
@private
    UIImageView* m_warningIcon;
    UILabel* m_warningLabel;
	NSString* m_helpText;
    UILabel* m_helpTextLabel;
    GtTextInputTraits* m_traits;
	GtTextEditCell* m_nextRowToEdit;
    GtTextEditCell* m_prevRowToEdit;
    UILabel* m_countDownLabel;
    GtViewAnimator* m_viewAnimator;
  //  UIView* m_editingBar;
    UIToolbar* m_editingBar;
    
    UIBarButtonItem* m_next;
    UIBarButtonItem* m_prev;
    UIBarButtonItem* m_stop;
    
	id m_delegate;
    NSUInteger m_maxLength;

    struct {
        unsigned int isEditing: 1;
        unsigned int wantsEditingBar: 1;
    } m_editFlags;
    
}

@property (readwrite, assign, nonatomic) id delegate;

@property (readwrite, assign, nonatomic) GtTextEditCell* nextRowToEdit;
@property (readwrite, assign, nonatomic) GtTextEditCell* prevRowToEdit;

@property (readwrite, assign, nonatomic) GtTextInputTraits* textInputTraits;

@property (readwrite, assign, nonatomic) NSUInteger maxLength;
@property (readonly, assign, nonatomic) NSInteger remainingSize;

@property (readonly, assign, nonatomic) BOOL wantsEditingBar;
@property (readonly, assign, nonatomic) BOOL isEditing;

@property (readwrite, assign, nonatomic) NSString* helpText;

- (void) clear;

- (void) showCountdownLabel;
- (void) hideCountdownLabel;
- (void) updateCountdownLabel;

- (void) showWarningLabel;
- (void) hideWarningLabel;
- (void) hideWarningIcon;
- (void) showWarningIcon;

@end

@interface GtTextEditCell (Internal)
- (void) setTextInputTraitsForControl:(id<UITextInputTraits>) control;
- (void) beginEditing;
- (void) endEditing;
- (void) cancelEditing;

- (void) onStopEditing:(id) sender;
- (void) onNext:(id) sender;
- (void) onPrevious:(id) sender;

+ (void) setGlobalEditingMode:(BOOL) editMode;
+ (BOOL) inGlobalEditingMode;
@end

@interface GtTextEditCell (Protected)
- (void)textDidBeginEditing;
- (void)textDidEndEditing:(NSString*) text;
- (void) positionCountdownView:(UILabel*) label;

@end

@protocol GtTextEditCellDelegate <NSObject>
- (void)textEditCellDidBeginEditing:(GtTextEditCell *)textField;
- (void)textEditCellDidEndEditing:(GtTextEditCell *)textField;
- (void)textEditCellBeginEditingCell:(GtTextEditCell *)textField;
@end

