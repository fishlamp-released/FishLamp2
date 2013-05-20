//
//	GtEditObjectViewControllerButtonStrategy.m
//	FishLamp
//
//	Created by Mike Fullerton on 1/24/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if 0
#import "GtEditObjectViewControllerButtonStrategy.h"

#import "GtEditObjectViewController.h"
#import "GtTableViewLayoutBuilder.h"
#import "GtTwoButtonCell.h"
#import "GtGradientButton.h"

@implementation GtEditObjectViewControllerButtonStrategy

GtSynthesizeDefault(GtEditObjectViewControllerButtonStrategy, Strategy);

- (void) updateSaveAndCancelButtons:(GtEditObjectViewController*) controller animate:(BOOL) animate
{
	controller.isModal = controller.objectWasEdited;
}

- (void) constructInlineButtons:(GtEditObjectViewController*) controller builder:(GtTableViewLayoutBuilder*) builder
{
}

@end

@interface GtEditObjectViewControllerTwoButtonStrategy (Private)
- (void) setSaveButton:(GtEditObjectViewController*) controller animate:(BOOL) animate;;
- (void) setCancelButton:(GtEditObjectViewController*) controller animate:(BOOL) animate;;
@end

@implementation GtEditObjectViewControllerTwoButtonStrategy 

GtSynthesizeStructProperty(wantsSaveButton, setWantsSaveButton, BOOL, m_editFlags);
GtSynthesizeStructProperty(wantsEditButton, setWantsEditButton, BOOL, m_editFlags);
GtSynthesizeStructProperty(wantsDoneButton, setWantsDoneButton, BOOL, m_editFlags);
GtSynthesizeStructProperty(delayShowingButtons, setDelayShowingButtons, BOOL, m_editFlags);

- (id) initWithOptions:(BOOL) delayShowingButtons
	wantsEditButton:(BOOL) wantsEditButton
	wantsDoneButton:(BOOL) wantsDoneButton
	wantsSaveButton:(BOOL) wantsSaveButton
{
	if((self = [super init]))
	{
		self.wantsEditButton = wantsEditButton;
		self.wantsSaveButton = wantsSaveButton;
		self.wantsDoneButton = wantsDoneButton;
		self.delayShowingButtons = delayShowingButtons;
	}
	
	return self;
}

- (void) setCancelButton:(GtEditObjectViewController*) controller animate:(BOOL) animate;
{
	if(!controller.objectWasEdited && self.delayShowingButtons)
	{
		if(DeviceIsPad())
		{
			if(controller.navigationController.rootViewController != controller)
			{
				return;
			}
		}
		else
		{
			return;
		}
	}

	

//	  if(!controller.objectWasEdited && self.delayShowingButtons && controller.navigationController)
//	  {
//		  return;
//	  }

	if(!controller.leftButton || self.wantsEditButton || self.wantsSaveButton || self.wantsDoneButton)
	{
		if(self.wantsEditButton || self.wantsSaveButton)
		{
			if(!controller.leftButton || controller.leftButtonItemType != UIBarButtonSystemItemCancel)
			{
				controller.leftButtonItemType = UIBarButtonSystemItemCancel;
				controller.leftButton = GtReturnAutoreleased([[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
						target:controller action:@selector(leftButton:)]);
				[controller.navigationItem setLeftBarButtonItem:controller.leftButton animated:animate];
			}
		
		}
		else if(self.wantsDoneButton)
		{
			if(!controller.leftButton || controller.leftButtonItemType != UIBarButtonSystemItemDone)
			{
				controller.leftButtonItemType = UIBarButtonSystemItemDone;
				controller.leftButton = GtReturnAutoreleased([[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
						target:controller action:@selector(leftButton:)]);
				[controller.navigationItem setLeftBarButtonItem:controller.leftButton animated:animate];
			}
		}

		
	}
}

- (void) setSaveButton:(GtEditObjectViewController*) controller animate:(BOOL) animate;
{
	if(!controller.objectWasEdited && self.delayShowingButtons && controller.navigationController)
	{
		return;
	}

	if(self.wantsSaveButton)
	{
		if(!controller.rightButton || controller.rightButtonItemType != UIBarButtonSystemItemSave)
		{
			controller.rightButtonItemType = UIBarButtonSystemItemSave;
			controller.rightButton = GtReturnAutoreleased([[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:controller action:@selector(respondToSaveButton:)]);
			[controller.navigationItem setRightBarButtonItem:controller.rightButton animated:animate];
		}
		
		[controller.rightButton setEnabled:controller.loaded];
	}
	else if(self.wantsEditButton)
	{
		if(!controller.rightButton || controller.rightButtonItemType != UIBarButtonSystemItemEdit)
		{
			controller.rightButtonItemType = UIBarButtonSystemItemEdit;
			controller.rightButton = GtReturnAutoreleased([[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:controller action:@selector(startEditing:)]);
			[controller.navigationItem setRightBarButtonItem:controller.rightButton animated:animate];
		}
		
		[controller.rightButton setEnabled:controller.loaded && controller.tableLayout.hasEditableRows];
	}
	else
	{
		controller.rightButton = nil;
		[controller.navigationItem	setRightBarButtonItem:nil animated:animate];
	}
}

- (void) updateSaveAndCancelButtons:(GtEditObjectViewController*) controller animate:(BOOL) animate;
{
	[self setCancelButton:controller animate:animate];
	[self setSaveButton:controller animate:animate];
	
	controller.isModal = controller.objectWasEdited;
}

@end

@implementation GtEditObjectViewControllerSaveButtonStrategy 

- (void) updateSaveAndCancelButtons:(GtEditObjectViewController*) controller animate:(BOOL) animate;
{
//	  if(!controller.objectWasEdited && self.delayShowingButtons && controller.navigationController)
//	  {	  
//		  if(![controller.buttonbarView viewForKey:@"back"])
//		  {
//			  GtBackButton* backButton = [
//		  }
//	  
//		  return;
//	  }
	
	
}

+ (GtEditObjectViewControllerSaveButtonStrategy*) editObjectViewControllerSaveButtonStrategy:(BOOL) delayShowingButtons
{
	return GtReturnAutoreleased([[GtEditObjectViewControllerSaveButtonStrategy alloc] initWithOptions:delayShowingButtons wantsEditButton:NO wantsDoneButton:NO wantsSaveButton:YES]);
}

@end

@implementation GtEditObjectViewControllerDoneButtonStrategy 

+ (GtEditObjectViewControllerDoneButtonStrategy*) editObjectViewControllerDoneButtonStrategy:(BOOL) delayShowingButtons
{
	return GtReturnAutoreleased([[GtEditObjectViewControllerDoneButtonStrategy alloc] initWithOptions:delayShowingButtons wantsEditButton:NO wantsDoneButton:YES wantsSaveButton:NO]);
}

@end

@implementation GtEditObjectViewControllerCancelButtonStrategy 

@synthesize buttonTitle = m_buttonTitle;

+ (GtEditObjectViewControllerCancelButtonStrategy*) editObjectViewControllerCancelButtonStrategy
{
	return GtReturnAutoreleased([[GtEditObjectViewControllerCancelButtonStrategy alloc] init]);
}

+ (GtEditObjectViewControllerCancelButtonStrategy*) editObjectViewControllerCancelButtonStrategy:(NSString*) buttonTitle
{
	GtEditObjectViewControllerCancelButtonStrategy* strategy = GtReturnAutoreleased([[GtEditObjectViewControllerCancelButtonStrategy alloc] init]);
	strategy.buttonTitle = buttonTitle;
	return strategy;
}

- (void) updateSaveAndCancelButtons:(GtEditObjectViewController*) controller animate:(BOOL) animate
{
	if(!controller.leftButton)
	{
		controller.leftButtonItemType = UIBarButtonSystemItemCancel;
		
		if(GtStringIsEmpty(m_buttonTitle))
		{
			controller.leftButton = GtReturnAutoreleased([[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
					target:controller action:@selector(leftButton:)]);
		}
		else
		{
			controller.leftButton = GtReturnAutoreleased([[UIBarButtonItem alloc] initWithTitle:m_buttonTitle style:UIBarButtonItemStyleBordered 
					target:controller action:@selector(leftButton:)]);
		}
		
		[controller.navigationItem setLeftBarButtonItem:controller.leftButton animated:animate];
	}
}

- (void) dealloc
{
	GtRelease(m_buttonTitle);
	GtSuperDealloc();
}

@end

@implementation GtEditObjectViewControllerInlineSaveAndCancelButtonStrategy

@synthesize saveButtonTitle = m_saveButtonTitle;
@synthesize cancelButtonTitle = m_cancelButtonTitle;

- (void) dealloc
{
	GtRelease(m_saveButtonTitle);
	GtRelease(m_cancelButtonTitle);
	GtSuperDealloc();
}

- (void) updateSaveAndCancelButtons:(GtEditObjectViewController*) controller animate:(BOOL) animate
{
	[controller.rightButton setEnabled:controller.objectWasEdited];
}

- (void) constructInlineButtons:(GtEditObjectViewController*) controller builder:(GtTableViewLayoutBuilder*) builder
{
	[builder addSection];
	
	controller.leftButtonItemType = UIBarButtonSystemItemCancel;
	controller.leftButton = [GtGradientButton gradientButton:m_cancelButtonTitle target:controller action:@selector(leftButton:)];
	
	if(GtStringIsNotEmpty(m_saveButtonTitle))
	{
		controller.rightButtonItemType = UIBarButtonSystemItemCancel;
		GtGradientButton* button = [GtGradientButton gradientButton:GtButtonColorBrightBlue title:m_saveButtonTitle target:controller action:@selector(respondToSaveButton:)];
		controller.rightButton = button;
	}
	
	[builder addCell: [GtTwoButtonCell twoButtonCell:controller.leftButton rightButton:controller.rightButton]];
}
+ (GtEditObjectViewControllerInlineSaveAndCancelButtonStrategy*) editObjectViewControllerInlineSaveAndCancelButtonStrategy:(NSString*) cancelTitle
	saveButtonTitle:(NSString*) saveTitle
{
	GtEditObjectViewControllerInlineSaveAndCancelButtonStrategy* strat = GtReturnAutoreleased([[GtEditObjectViewControllerInlineSaveAndCancelButtonStrategy alloc] init]);
	strat.saveButtonTitle = saveTitle;
	strat.cancelButtonTitle = cancelTitle;
	return strat;
}



@end
#endif
