//
//	GtPasswordEntryViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/19/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtPasswordEntryViewController.h"

#import "GtSingleLineTextEditCell.h"

@implementation GtPasswordEntryViewController

- (id) initWithPrompt:(NSString*) prompt withOptions:(GtPasswordEntryViewControllerOptionMask) options
{
	if((self = [super init]))
	{
		m_prompt = GtRetain(prompt);
		m_options = options;
		[self.dataSourceManager setDefaultDataSource:[NSMutableDictionary dictionary]];
	}
	return self;
}

+ (GtPasswordEntryViewController*) passwordEntryViewController:(NSString*) prompt withOptions:(GtPasswordEntryViewControllerOptionMask) options
{
	return GtReturnAutoreleased([[GtPasswordEntryViewController alloc] initWithPrompt:prompt withOptions:options]);
}

- (void) dealloc
{
	GtRelease(m_prompt);
	GtSuperDealloc();
}

- (void) willConstructWithTableLayoutBuilder:(GtTableViewLayoutBuilder*) builder
{
	[builder addSection];
	[builder addCell:[GtPasswordTextEditCell passwordTextEditCell:m_prompt] forKey:@"password"];
	
	if(GtBitTestAny(m_options, GtPasswordEntryViewControllerOptionConfirmationRequired))
	{
		[builder addSection];
		[builder addCell:[GtPasswordTextEditCell passwordTextEditCell:NSLocalizedString(@"Confirm Password", nil)] forKey:@"password2"];
	}
}					 

- (NSString*) password
{
	return [self.dataSourceManager objectForKeyPath:@"password"];
}

- (void) _beginEditing
{
	[self beginEditingTextInCell:(GtTextEditCell*) [self cellForRowKey:@"password"]];
}

- (void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	[self performSelector:@selector(_beginEditing) withObject:nil afterDelay:0.3];

	[self _beginEditing];
}

- (void) didStopEditingText:(BOOL)withDonePress
{
	[super didStopEditingText:withDonePress];
	if(withDonePress)
	{
		[self respondToSaveButton:self];
	}
}

- (BOOL) willBeginSavingChanges
{
	NSString* password = self.password;
	if(GtBitTestAny(m_options, GtPasswordEntryViewControllerOptionPasswordRequired))
	{
		if(GtStringIsEmpty(password))
		{
			UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"No password was entered.", nil) 
                message:NSLocalizedString(@"Please enter a valid password.", nil) 
                    delegate:nil 
                    cancelButtonTitle:nil 
                    otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
            GtAutorelease(alert);
            
			[alert show];
			
			return NO;
		}
	}

	if(GtBitTestAny(m_options, GtPasswordEntryViewControllerOptionConfirmationRequired))
	{
	
		if(!GtStringsAreEqual(password, [self.dataSourceManager objectForKeyPath:@"password2"]))
		{
			UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"The two passwords you entered do not match.", nil) 
                message:NSLocalizedString(@"Please try again.",nil) delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
            GtAutorelease(alert);
			[alert show];

			[self beginEditingTextInCell:(GtTextEditCell*) [self cellForRowKey:@"password"]];

			return NO;
		}
	}
	
	return YES;
}



@end
