//
//	FLEditObjectViewControllerButtonStrategy.m
//	FishLamp
//
//	Created by Mike Fullerton on 1/24/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if 0
#import "FLEditObjectViewControllerButtonStrategy.h"

#import "FLEditObjectViewController.h"
#import "FLTableViewLayoutBuilder.h"
#import "FLTwoButtonCell.h"
#import "FLGradientButton.h"

@implementation FLEditObjectViewControllerButtonStrategy

FLSynthesizeDefault(FLEditObjectViewControllerButtonStrategy, Strategy);

- (void) updateSaveAndCancelButtons:(FLEditObjectViewController*) controller animate:(BOOL) animate
{
	controller.isModal = controller.objectWasEdited;
}

- (void) constructInlineButtons:(FLEditObjectViewController*) controller builder:(FLTableViewLayoutBuilder*) builder
{
}

@end

@interface FLEditObjectViewControllerTwoButtonStrategy (Private)
- (void) setSaveButton:(FLEditObjectViewController*) controller animate:(BOOL) animate;;
- (void) setCancelButton:(FLEditObjectViewController*) controller animate:(BOOL) animate;;
@end

@implementation FLEditObjectViewControllerTwoButtonStrategy 

FLSynthesizeStructProperty(wantsSaveButton, setWantsSaveButton, BOOL, _editFlags);
FLSynthesizeStructProperty(wantsEditButton, setWantsEditButton, BOOL, _editFlags);
FLSynthesizeStructProperty(wantsDoneButton, setWantsDoneButton, BOOL, _editFlags);
FLSynthesizeStructProperty(delayShowingButtons, setDelayShowingButtons, BOOL, _editFlags);

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

- (void) setCancelButton:(FLEditObjectViewController*) controller animate:(BOOL) animate;
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
				controller.leftButton = FLAutorelease([[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
						target:controller action:@selector(leftButton:)]);
				[controller.navigationItem setLeftBarButtonItem:controller.leftButton animated:animate];
			}
		
		}
		else if(self.wantsDoneButton)
		{
			if(!controller.leftButton || controller.leftButtonItemType != UIBarButtonSystemItemDone)
			{
				controller.leftButtonItemType = UIBarButtonSystemItemDone;
				controller.leftButton = FLAutorelease([[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
						target:controller action:@selector(leftButton:)]);
				[controller.navigationItem setLeftBarButtonItem:controller.leftButton animated:animate];
			}
		}

		
	}
}

- (void) setSaveButton:(FLEditObjectViewController*) controller animate:(BOOL) animate;
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
			controller.rightButton = FLAutorelease([[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:controller action:@selector(respondToSaveButton:)]);
			[controller.navigationItem setRightBarButtonItem:controller.rightButton animated:animate];
		}
		
		[controller.rightButton setEnabled:controller.loaded];
	}
	else if(self.wantsEditButton)
	{
		if(!controller.rightButton || controller.rightButtonItemType != UIBarButtonSystemItemEdit)
		{
			controller.rightButtonItemType = UIBarButtonSystemItemEdit;
			controller.rightButton = FLAutorelease([[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:controller action:@selector(startEditing:)]);
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

- (void) updateSaveAndCancelButtons:(FLEditObjectViewController*) controller animate:(BOOL) animate;
{
	[self setCancelButton:controller animate:animate];
	[self setSaveButton:controller animate:animate];
	
	controller.isModal = controller.objectWasEdited;
}

@end

@implementation FLEditObjectViewControllerSaveButtonStrategy 

- (void) updateSaveAndCancelButtons:(FLEditObjectViewController*) controller animate:(BOOL) animate;
{
//	  if(!controller.objectWasEdited && self.delayShowingButtons && controller.navigationController)
//	  {	  
//		  if(![controller.buttonbarView viewForKey:@"back"])
//		  {
//			  FLBackButtonDeprecated* backButton = [
//		  }
//	  
//		  return;
//	  }
	
	
}

+ (FLEditObjectViewControllerSaveButtonStrategy*) editObjectViewControllerSaveButtonStrategy:(BOOL) delayShowingButtons
{
	return FLAutorelease([[FLEditObjectViewControllerSaveButtonStrategy alloc] initWithOptions:delayShowingButtons wantsEditButton:NO wantsDoneButton:NO wantsSaveButton:YES]);
}

@end

@implementation FLEditObjectViewControllerDoneButtonStrategy 

+ (FLEditObjectViewControllerDoneButtonStrategy*) editObjectViewControllerDoneButtonStrategy:(BOOL) delayShowingButtons
{
	return FLAutorelease([[FLEditObjectViewControllerDoneButtonStrategy alloc] initWithOptions:delayShowingButtons wantsEditButton:NO wantsDoneButton:YES wantsSaveButton:NO]);
}

@end

@implementation FLEditObjectViewControllerCancelButtonStrategy 

@synthesize buttonTitle = _buttonTitle;

+ (FLEditObjectViewControllerCancelButtonStrategy*) editObjectViewControllerCancelButtonStrategy
{
	return FLAutorelease([[FLEditObjectViewControllerCancelButtonStrategy alloc] init]);
}

+ (FLEditObjectViewControllerCancelButtonStrategy*) editObjectViewControllerCancelButtonStrategy:(NSString*) buttonTitle
{
	FLEditObjectViewControllerCancelButtonStrategy* strategy = FLAutorelease([[FLEditObjectViewControllerCancelButtonStrategy alloc] init]);
	strategy.buttonTitle = buttonTitle;
	return strategy;
}

- (void) updateSaveAndCancelButtons:(FLEditObjectViewController*) controller animate:(BOOL) animate
{
	if(!controller.leftButton)
	{
		controller.leftButtonItemType = UIBarButtonSystemItemCancel;
		
		if(FLStringIsEmpty(_buttonTitle))
		{
			controller.leftButton = FLAutorelease([[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
					target:controller action:@selector(leftButton:)]);
		}
		else
		{
			controller.leftButton = FLAutorelease([[UIBarButtonItem alloc] initWithTitle:_buttonTitle style:UIBarButtonItemStyleBordered 
					target:controller action:@selector(leftButton:)]);
		}
		
		[controller.navigationItem setLeftBarButtonItem:controller.leftButton animated:animate];
	}
}

- (void) dealloc
{
	FLRelease(_buttonTitle);
	FLSuperDealloc();
}

@end

@implementation FLEditObjectViewControllerInlineSaveAndCancelButtonStrategy

@synthesize saveButtonTitle = _saveButtonTitle;
@synthesize cancelButtonTitle = _cancelButtonTitle;

- (void) dealloc
{
	FLRelease(_saveButtonTitle);
	FLRelease(_cancelButtonTitle);
	FLSuperDealloc();
}

- (void) updateSaveAndCancelButtons:(FLEditObjectViewController*) controller animate:(BOOL) animate
{
	[controller.rightButton setEnabled:controller.objectWasEdited];
}

- (void) constructInlineButtons:(FLEditObjectViewController*) controller builder:(FLTableViewLayoutBuilder*) builder
{
	[builder addSection];
	
	controller.leftButtonItemType = UIBarButtonSystemItemCancel;
	controller.leftButton = [FLGradientButton gradientButton:_cancelButtonTitle target:controller action:@selector(leftButton:)];
	
	if(FLStringIsNotEmpty(_saveButtonTitle))
	{
		controller.rightButtonItemType = UIBarButtonSystemItemCancel;
		FLGradientButton* button = [FLGradientButton gradientButton:FLGradientButtonColorBrightBlue title:_saveButtonTitle target:controller action:@selector(respondToSaveButton:)];
		controller.rightButton = button;
	}
	
	[builder addCell: [FLTwoButtonCell twoButtonCell:controller.leftButton rightButton:controller.rightButton]];
}
+ (FLEditObjectViewControllerInlineSaveAndCancelButtonStrategy*) editObjectViewControllerInlineSaveAndCancelButtonStrategy:(NSString*) cancelTitle
	saveButtonTitle:(NSString*) saveTitle
{
	FLEditObjectViewControllerInlineSaveAndCancelButtonStrategy* strat = FLAutorelease([[FLEditObjectViewControllerInlineSaveAndCancelButtonStrategy alloc] init]);
	strat.saveButtonTitle = saveTitle;
	strat.cancelButtonTitle = cancelTitle;
	return strat;
}



@end
#endif
