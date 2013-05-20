//
//	GtSimpleTextEditViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 1/30/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSimpleTextEditViewController.h"
#import "GtSingleLineTextEditCell.h"
#import "GtMultiLineTextEditCell.h"

@implementation GtSimpleTextEditViewController

- (id) initWithPrompt:(NSString*) prompt value:(NSString*) value helpPrompt:(NSString*) helpPrompt editMode:(GtSimpleTextEditViewControllerMode) mode
{
	if((self = [super init])) // WithNibName:DeviceIsPad() ? @"GtEditPanelTableViewController-iPad" : @"GtEditPanelTableViewController" bundle:nil
	{
		m_mode = mode;
		[self.dataSourceManager setDefaultDataSource:[NSMutableDictionary dictionary]];
		
		[self.dataSourceManager setObject:prompt forKeyPath:@"./prompt" fireDataChangedEvent:NO];
		[self.dataSourceManager setObject:GtStringIsNotEmpty(value) ? value : @"" forKeyPath:@"./value" fireDataChangedEvent:NO];
		if(GtStringIsNotEmpty(helpPrompt))
		{
			[self.dataSourceManager setObject:helpPrompt forKeyPath:@"./help" fireDataChangedEvent:NO];
		}
	}
	return self;
}

+ (GtSimpleTextEditViewController*) simpleTextEditViewController:(NSString*) prompt value:(NSString*) value helpPrompt:(NSString*) helpPrompt editMode:(GtSimpleTextEditViewControllerMode) mode
{
	return GtReturnAutoreleased([[GtSimpleTextEditViewController alloc] initWithPrompt:prompt value:value helpPrompt:helpPrompt editMode:mode]);
}

- (void) willConstructWithTableLayoutBuilder:(GtTableViewLayoutBuilder*) builder
{
	[builder addSection];
	if(m_mode == GtSimpleTextEditViewControllerModeSingleLine)
	{
		[builder addCell:[GtSingleLineTextEditCell singleLineTextEditCell:[self.dataSourceManager objectForKeyPath:@"./prompt"]]
			forKey:@"./value"];
	}
	else
	{
		GtMultiLineTextEditCell* cell = [GtMultiLineTextEditCell multiLineTextEditCell:[self.dataSourceManager objectForKeyPath:@"./prompt"]];
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
	[self beginEditingTextInCell:(GtTextEditCell*) [self cellForRowKey:@"./value"]];
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
