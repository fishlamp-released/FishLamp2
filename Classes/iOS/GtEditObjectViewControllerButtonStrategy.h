//
//	GtEditObjectViewControllerButtonStrategy.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/24/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if 0
#import <Foundation/Foundation.h>
#import "GtDefaultProperty.h"

@class GtEditObjectViewController;
@class GtTableViewLayoutBuilder;

@interface GtEditObjectViewControllerButtonStrategy : NSObject {
}

GtDefaultProperty(GtEditObjectViewControllerButtonStrategy, Strategy);

- (void) constructInlineButtons:(GtEditObjectViewController*) controller builder:(GtTableViewLayoutBuilder*) builder;
- (void) updateSaveAndCancelButtons:(GtEditObjectViewController*) controller animate:(BOOL) animate;

@end

@interface GtEditObjectViewControllerTwoButtonStrategy : GtEditObjectViewControllerButtonStrategy {
@private
	struct {
// construction
		unsigned int wantsEditButton:1;
		unsigned int wantsSaveButton:1;
		unsigned int wantsDoneButton:1;
		unsigned int delayShowingButtons:1;
		unsigned int unsetModalFlag: 1;
	} m_editFlags;
}

@end

@interface GtEditObjectViewControllerSaveButtonStrategy : GtEditObjectViewControllerButtonStrategy

+ (GtEditObjectViewControllerSaveButtonStrategy*) editObjectViewControllerSaveButtonStrategy:(BOOL) delayShowingButtons;

@end

@interface GtEditObjectViewControllerDoneButtonStrategy : GtEditObjectViewControllerTwoButtonStrategy

+ (GtEditObjectViewControllerDoneButtonStrategy*) editObjectViewControllerDoneButtonStrategy:(BOOL) delayShowingButtons;

@end

@interface GtEditObjectViewControllerCancelButtonStrategy : GtEditObjectViewControllerButtonStrategy {
@private
	NSString* m_buttonTitle;
}
@property (readwrite, retain, nonatomic) NSString* buttonTitle;

+ (GtEditObjectViewControllerCancelButtonStrategy*) editObjectViewControllerCancelButtonStrategy;
+ (GtEditObjectViewControllerCancelButtonStrategy*) editObjectViewControllerCancelButtonStrategy:(NSString*) buttonTitle;

@end

@interface GtEditObjectViewControllerInlineSaveAndCancelButtonStrategy : GtEditObjectViewControllerButtonStrategy {
	NSString* m_cancelTitle;
	NSString* m_saveTitle;
}
@property (readwrite, retain, nonatomic) NSString* saveButtonTitle;
@property (readwrite, retain, nonatomic) NSString* cancelButtonTitle;

+ (GtEditObjectViewControllerInlineSaveAndCancelButtonStrategy*) editObjectViewControllerInlineSaveAndCancelButtonStrategy:(NSString*) cancelTitle
	saveButtonTitle:(NSString*) saveTitle;

@end
#endif