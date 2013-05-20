//
//	GtTextEditCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/15/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#if DEBUG
#define DEBUG 1
#endif

#import "GtTwoLineLabelAndValueCell.h"
#import "GtTextEditCellData.h"

@protocol GtTextEditCellDelegate;

@interface GtTextEditCell : GtTwoLineLabelAndValueCell {
@private
	UIImageView* m_warningIcon;
	UILabel* m_warningLabel;
	UILabel* m_helpTextLabel;
	UILabel* m_countDownLabel;
	
	id<GtTextEditCellDelegate> m_textEditingCellDelegate;
	NSUInteger m_maxLength;
}

@property (readwrite, assign, nonatomic) id<GtTextEditCellDelegate> textEditingCellDelegate; 

@property (readonly, retain, nonatomic) GtTextEditCell* nextCellToEdit;
@property (readonly, retain, nonatomic) GtTextEditCell* prevCellToEdit;

@property (readwrite, assign, nonatomic) NSUInteger maxLength;
@property (readonly, assign, nonatomic) NSInteger remainingSize;

@property (readonly, assign, nonatomic) BOOL isEditing;

- (void) clear;

- (void) showCountdownLabel;
- (void) hideCountdownLabel;
- (void) updateCountdownLabel;

- (void) showWarningLabel;
- (void) hideWarningLabel;
- (void) hideWarningIcon;
- (void) showWarningIcon;

- (void) allowResponderToResign;

@end

@interface GtTextEditCell (Internal)
//- (void) setTextInputTraitsForControl:(id<UITextInputTraits>) control;
- (void) beginEditing;
- (void) endEditing;
- (void) cancelEditing;

- (void) didStopEditing;
- (void) showHelpText;

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
- (BOOL) updateText:(NSString*) text;

@end

@protocol GtTextEditCellDelegate <NSObject>
- (UIView*) textEditCellGetInputAccessoryView:(GtTextEditCell *)textField;
- (BOOL)textEditCellDoStartEditing:(GtTextEditCell *)textField;
- (void)textEditCellDidBeginEditingText:(GtTextEditCell *)textField;
- (void)textEditCellDidEndEditingText:(GtTextEditCell *)textField withDoneButtonPress:(BOOL) donePress;
- (void)textEditCellNeedsToBeginEditingText:(GtTextEditCell *)textField;
- (GtTextEditCell*) textEditCellGetNextEditableCell:(GtTextEditCell*) cell;
- (GtTextEditCell*) textEditCellGetPreviousEditableCell:(GtTextEditCell*) cell;

@end
