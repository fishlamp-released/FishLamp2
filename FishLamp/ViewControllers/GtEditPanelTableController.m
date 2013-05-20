//
//  GtEditPanelTableController.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/14/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#if IPHONE

#import "GtEditPanelTableController.h"
#import "GtGeometry.h"

@implementation GtEditPanelTableController

@synthesize tableView = m_tableView;
@synthesize textEditCellManager = m_textEditCellManager;

- (id) initWithDisplayDataRow:(GtDisplayDataRow*) row
{
	if(self = [super initWithNibName:@"GtEditPanelWithTableView" bundle:nil])
	{
		self.displayDataRow = row;
	}
	
	return self;
}

- (id) initWithDisplayDataRowAndNibName:(GtDisplayDataRow*) row nibName:(NSString*) nibName
{
	if(self = [super initWithNibName:nibName bundle:nil])
	{
		self.displayDataRow = row;
	}
	
	return self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	GtRelease(m_tableView);
	GtRelease(m_textEditCellManager);
    [super dealloc];
}

- (void) viewDidLoad
{
	[super viewDidLoad];
	
	GtAssertNotNil(m_tableView);

	m_textEditCellManager = [GtAlloc(GtTextEditCellManager) initWithTableView:m_tableView];
	m_textEditCellManager.delegate = self;

	self.view.backgroundColor = m_tableView.backgroundColor;
	
	if(self.navigationController.navigationBar.barStyle == UIBarStyleBlackTranslucent)
	{
		CGRect frame = m_tableView.frame;
		if(frame.origin.y < GtNavigationBarHeight)
		{
			CGFloat increment =  (GtNavigationBarHeight - frame.origin.y);
		
			frame.size.height -= increment;
			frame.origin.y = increment;
			
			m_tableView.frame = frame;
		}

	}

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
	   cell = [[GtAlloc(UITableViewCell) initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
		
/*
		RunOnlyOnSdkVersion3
		{
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}

#if FISHLAMP_IPHONE_2_SDK
		DontRunOnSdkVersion3
		{
		   cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
		}
#endif
*/
    }
	
	[m_textEditCellManager setDelegateForCellIfTextEditCell:cell];
  	
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 40; // [self rowHeight];
}

- (void) doneButtonPressed
{
	[m_textEditCellManager stopEditing];
	[super doneButtonPressed];
}

- (BOOL) textEditCellManager:(GtTextEditCellManager*) manager doScrollCellIntoViewOnEdit:(UITableViewCell*) cell
{
	return YES;
}

- (NSIndexPath*) textEditCellManager:(GtTextEditCellManager*) manager indexPathForRowId:(id) rowId;
{
	return nil;
}

- (id) textEditCellManager:(GtTextEditCellManager*) manager cellForIndexPath:(NSIndexPath*) indexPath
{
	return [m_tableView cellForRowAtIndexPath:indexPath];
}

- (NSIndexPath*) textEditCellManager:(GtTextEditCellManager*) manager indexPathForCell:(UITableViewCell*) cell
{
	return [m_tableView indexPathForCell:cell];
}

- (void) textEditCellManager:(GtTextEditCellManager*) manager didBeginEditingCell:(GtTextEditCell *)cell
{
}

- (void) textEditCellManager:(GtTextEditCellManager*) manager didEndEditingCell:(GtTextEditCell *)textField
{
}

@end

#endif