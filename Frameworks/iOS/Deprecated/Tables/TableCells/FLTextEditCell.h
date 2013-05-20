//
//	FLTextEditCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/15/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#if DEBUG
#define DEBUG 1
#endif

#import "FLTwoLineLabelAndValueCell.h"
#import "FLTextEditCellData.h"

@protocol FLTextEditCellDelegate;

@interface FLTextEditCell : FLTwoLineLabelAndValueCell {
@private
//	UIImageView* _warningIcon;
//	UILabel* _warningLabel;
	UILabel* _helpTextLabel;
	UILabel* _countDownLabel;
	
	__unsafe_unretained id<FLTextEditCellDelegate> _textEditingCellDelegate;
	NSUInteger _maxLength;
}

@property (readwrite, assign, nonatomic) id<FLTextEditCellDelegate> textEditingCellDelegate; 

@property (readonly, retain, nonatomic) FLTextEditCell* nextCellToEdit;
@property (readonly, retain, nonatomic) FLTextEditCell* prevCellToEdit;

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

@interface FLTextEditCell (Internal)
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

@interface FLTextEditCell (Protected)
- (void)textDidBeginEditing;
- (void)textDidEndEditing:(NSString*) text;
- (void) positionCountdownView:(UILabel*) label;
- (BOOL) updateText:(NSString*) text;

@end

@protocol FLTextEditCellDelegate <NSObject>
- (UIView*) textEditCellGetInputAccessoryView:(FLTextEditCell *)textField;
- (BOOL)textEditCellDoStartEditing:(FLTextEditCell *)textField;
- (void)textEditCellDidBeginEditingText:(FLTextEditCell *)textField;
- (void)textEditCellDidEndEditingText:(FLTextEditCell *)textField withDoneButtonPress:(BOOL) donePress;
- (void)textEditCellNeedsToBeginEditingText:(FLTextEditCell *)textField;
- (FLTextEditCell*) textEditCellGetNextEditableCell:(FLTextEditCell*) cell;
- (FLTextEditCell*) textEditCellGetPreviousEditableCell:(FLTextEditCell*) cell;

@end
