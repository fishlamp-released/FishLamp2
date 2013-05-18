//
//  GtEditPanel.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/13/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#if IPHONE

#import "GtEditPanel.h"
#import "GtEditableObjectView.h"
#import "GtAction.h"

@implementation GtEditPanel

@synthesize displayDataRow = m_displayDataRow;
@synthesize delegate = m_delegate;
@synthesize indexPath = m_indexPath;

GtSynthesizeSetter(setDisplayDataRow, GtDisplayDataRow*, m_displayDataRow);
GtSynthesizeSetter(setIndexPath, NSIndexPath*, m_indexPath);
GtSynthesizeID(userData, setUserData);

- (id) initWithDisplayDataRow:(GtDisplayDataRow*) row
{
	if(self = [super initWithNibName:@"GtEditPanel" bundle:nil])
	{
		self.displayDataRow = row;
	}
	
	return self;
}

- (void)dealloc 
{
	GtRelease(m_userData);
	GtRelease(m_displayDataRow);
	GtRelease(m_indexPath);
	[super dealloc];
}

- (void) onCloseSelf:(GtAction*) action
{
    if(action.didSucceed)
    {
        if(m_wasCancelled)
        {
            [self.delegate editPanel:self 
                cancelledAtPath:self.indexPath];
        }
        else
        {
            id newValue = [self onGetNewValue];
            
            GtAssertNotNil(newValue);
        
            [self.delegate editPanel:self
                itemUpdated:m_displayDataRow
                newData:newValue
                atIndexPath:self.indexPath];
        }

        [[self navigationController] popViewControllerAnimated:YES];
    }
}

- (void) hideSelf:(id) sender
{
	m_wasCancelled = YES;
//	[self deactivateContext];
	
	GtAction* action = [GtAlloc(GtAction) init];
	action.context = self.actionContext;
	[action setCompletedCallback:self selector:@selector(onCloseSelf:)];
	[action queueAction];
	GtRelease(action);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void) viewDidLoad
{
	[super viewDidLoad];
	
	[self.navigationItem setHidesBackButton:YES animated:NO];
	
	UIBarButtonItem* item = [GtAlloc(UIBarButtonItem) initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
		target:self action:@selector(hideSelf:)];
	[self.navigationItem setLeftBarButtonItem:item animated:YES];
	[item release];

	self.navigationItem.rightBarButtonItem = [self editButtonItem];

	[super setEditing:YES animated:NO];
}

- (BOOL) canFinishEditing
{
	return YES;
}

- (void) doneButtonPressed
{
	if([self canFinishEditing])
	{
		m_wasCancelled = NO;
	
		GtAction* action = [GtAlloc(GtAction) init];
		action.context = self.actionContext;
		[action setCompletedCallback:self selector:@selector(onCloseSelf:)];
		[action queueAction];
		GtRelease(action);
	}
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
	if(editing)
	{
		[super setEditing:editing animated:animated];
	}
	else
	{
		[self doneButtonPressed];
	}
}

- (id) onGetNewValue
{
	GtAssert(NO, @"need to override onSetNewValue to update data");
	
	return nil;
}


@end

#endif