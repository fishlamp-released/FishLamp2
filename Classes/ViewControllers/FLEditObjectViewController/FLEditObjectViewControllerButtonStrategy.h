//
//	FLEditObjectViewControllerButtonStrategy.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/24/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//
#if 0
#import <Foundation/Foundation.h>
#import "FLDefaultProperty.h"

@class FLEditObjectViewController;
@class FLTableViewLayoutBuilder;

@interface FLEditObjectViewControllerButtonStrategy : NSObject {
}

FLDefaultProperty(FLEditObjectViewControllerButtonStrategy, Strategy);

- (void) constructInlineButtons:(FLEditObjectViewController*) controller builder:(FLTableViewLayoutBuilder*) builder;
- (void) updateSaveAndCancelButtons:(FLEditObjectViewController*) controller animate:(BOOL) animate;

@end

@interface FLEditObjectViewControllerTwoButtonStrategy : FLEditObjectViewControllerButtonStrategy {
@private
	struct {
// construction
		unsigned int wantsEditButton:1;
		unsigned int wantsSaveButton:1;
		unsigned int wantsDoneButton:1;
		unsigned int delayShowingButtons:1;
		unsigned int unsetModalFlag: 1;
	} _editFlags;
}

@end

@interface FLEditObjectViewControllerSaveButtonStrategy : FLEditObjectViewControllerButtonStrategy

+ (FLEditObjectViewControllerSaveButtonStrategy*) editObjectViewControllerSaveButtonStrategy:(BOOL) delayShowingButtons;

@end

@interface FLEditObjectViewControllerDoneButtonStrategy : FLEditObjectViewControllerTwoButtonStrategy

+ (FLEditObjectViewControllerDoneButtonStrategy*) editObjectViewControllerDoneButtonStrategy:(BOOL) delayShowingButtons;

@end

@interface FLEditObjectViewControllerCancelButtonStrategy : FLEditObjectViewControllerButtonStrategy {
@private
	NSString* _buttonTitle;
}
@property (readwrite, retain, nonatomic) NSString* buttonTitle;

+ (FLEditObjectViewControllerCancelButtonStrategy*) editObjectViewControllerCancelButtonStrategy;
+ (FLEditObjectViewControllerCancelButtonStrategy*) editObjectViewControllerCancelButtonStrategy:(NSString*) buttonTitle;

@end

@interface FLEditObjectViewControllerInlineSaveAndCancelButtonStrategy : FLEditObjectViewControllerButtonStrategy {
	NSString* _cancelTitle;
	NSString* _saveTitle;
}
@property (readwrite, retain, nonatomic) NSString* saveButtonTitle;
@property (readwrite, retain, nonatomic) NSString* cancelButtonTitle;

+ (FLEditObjectViewControllerInlineSaveAndCancelButtonStrategy*) editObjectViewControllerInlineSaveAndCancelButtonStrategy:(NSString*) cancelTitle
	saveButtonTitle:(NSString*) saveTitle;

@end
#endif