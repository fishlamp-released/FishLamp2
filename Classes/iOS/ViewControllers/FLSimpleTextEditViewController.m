//
//	FLSimpleTextEditViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 1/30/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLSimpleTextEditViewController.h"
#import "FLSingleLineTextEditCell.h"
#import "FLMultiLineTextEditCell.h"

@implementation FLSimpleTextEditViewController

- (id) initWithPrompt:(NSString*) prompt value:(NSString*) value helpPrompt:(NSString*) helpPrompt editMode:(FLSimpleTextEditViewControllerMode) mode
{
	if((self = [super init])) // WithNibName:DeviceIsPad() ? @"FLEditPanelTableViewController-iPad" : @"FLEditPanelTableViewController" bundle:nil
	{
		_mode = mode;
		[self.dataSourceManager setDefaultDataSource:[NSMutableDictionary dictionary]];
		
		[self.dataSourceManager setObject:prompt forKeyPath:@"./prompt" fireDataChangedEvent:NO];
		[self.dataSourceManager setObject:FLStringIsNotEmpty(value) ? value : @"" forKeyPath:@"./value" fireDataChangedEvent:NO];
		if(FLStringIsNotEmpty(helpPrompt))
		{
			[self.dataSourceManager setObject:helpPrompt forKeyPath:@"./help" fireDataChangedEvent:NO];
		}
	}
	return self;
}

+ (FLSimpleTextEditViewController*) simpleTextEditViewController:(NSString*) prompt value:(NSString*) value helpPrompt:(NSString*) helpPrompt editMode:(FLSimpleTextEditViewControllerMode) mode
{
	return FLAutorelease([[FLSimpleTextEditViewController alloc] initWithPrompt:prompt value:value helpPrompt:helpPrompt editMode:mode]);
}

- (void) willConstructWithTableLayoutBuilder:(FLTableViewLayoutBuilder*) builder
{
	[builder addSection];
	if(_mode == FLSimpleTextEditViewControllerModeSingleLine)
	{
		[builder addCell:[FLSingleLineTextEditCell singleLineTextEditCell:[self.dataSourceManager objectForKeyPath:@"./prompt"]]
			forKey:@"./value"];
	}
	else
	{
		FLMultiLineTextEditCell* cell = [FLMultiLineTextEditCell multiLineTextEditCell:[self.dataSourceManager objectForKeyPath:@"./prompt"]];
		cell.numberOfLines = 5;
		cell.resizeOnEdit = NO;
		[builder addCell:cell forKey:@"./value"];
	}
	builder.cell.helpText = [self.dataSourceManager objectForKeyPath:@"./help"];
}					 

- (NSString*) editedText
{
	return [self.dataSourceManager objectForKeyPath:@"./value"];
}

- (void) _beginEditing
{
	[self beginEditingTextInCell:(FLTextEditCell*) [self cellForRowKey:@"./value"]];
}

- (void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	[self performSelector:@selector(_beginEditing) withObject:nil afterDelay:0.3];
}

- (void) didStopEditingText:(BOOL)withDonePress
{
	[super didStopEditingText:withDonePress];
	if(withDonePress)
	{
		[self respondToSaveButton:self];
	}
}

@end
