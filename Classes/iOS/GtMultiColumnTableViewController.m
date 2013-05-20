//
//	GtMultiColumnTableViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/5/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtMultiColumnTableViewController.h"


@implementation GtMultiColumnTableViewController

@synthesize maxPortaitColumns = m_maxPortaitColumns;
@synthesize maxLandscapeColumns = m_maxLandscapeColumns;
@synthesize visibleColumnCount = m_visibleColumnCount;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
	{
		self.maxPortaitColumns = 1;
		self.maxLandscapeColumns = 1;
		
		
	}
	
	return self;
}

- (void) updateLayout:(BOOL) toLandscapeOrientation
{
	m_isLandscapeOriented = toLandscapeOrientation;
	m_visibleColumnCount = toLandscapeOrientation ? 
		 m_maxLandscapeColumns : m_maxPortaitColumns;

	m_numberOfDataItems = [self numberOfDataItems];
	m_rowCount = ((m_numberOfDataItems / m_visibleColumnCount) + 
							(((m_numberOfDataItems % m_visibleColumnCount) > 0) ? 1 : 0));
}

- (void) updateTableLayoutWithCurrentOrientation
{
	[self updateLayout:(self.view.bounds.size.width > self.view.bounds.size.height)];
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self updateTableLayoutWithCurrentOrientation];
}

- (void) tableViewWillReloadData:(UITableView*) tableView
{
	[super tableViewWillReloadData:tableView];
	[self updateTableLayoutWithCurrentOrientation];
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
	[self updateLayout:UIInterfaceOrientationIsLandscape(toInterfaceOrientation)];
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	[super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
	[self updateTableLayoutWithCurrentOrientation];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	return m_rowCount;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	return nil;
}

- (NSUInteger) numberOfDataItems
{
	return 0;
}

- (GtWidget*) createWidgetForColumn:(NSUInteger) columnNumber
{ 
	return nil;
}

- (void) updateWidget:(GtWidget*) widget forDataItemIndex:(NSUInteger) itemIndex
{
}

- (NSUInteger) rowNumberForDataItemIndex:(NSUInteger) dataItemIndex
{
	return dataItemIndex / m_visibleColumnCount;
}

- (void) updateColumnsInCell:(GtMultiColumnTableViewCell*) cell	 forIndexPath:(NSIndexPath*) indexPath
{
	NSUInteger startIndex = indexPath.row * m_visibleColumnCount;
	for(NSUInteger i = 0; i < MAX(m_maxLandscapeColumns, m_maxPortaitColumns); i++)
	{
		NSUInteger arrayIndex = i + startIndex;
	
		if(arrayIndex < m_numberOfDataItems && i < m_visibleColumnCount)
		{
			[cell.widget subwidgetAtIndex:i].hidden = NO;
			[self updateWidget:[cell.widget subwidgetAtIndex:i] forDataItemIndex:arrayIndex];
		}
		else 
		{
			[cell.widget subwidgetAtIndex:i].hidden = YES;
		}
	}
}

- (void) didCreateNewTableCell:(GtMultiColumnTableViewCell*) cell
{

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	static NSString* CellIdentifier = @"c";
	
	GtMultiColumnTableViewCell* cell = (GtMultiColumnTableViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if(!cell)
	{
		cell = GtReturnAutoreleased([[GtMultiColumnTableViewCell alloc] initWithReuseIdentifier:CellIdentifier]);
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		for(NSUInteger i = 0; i < MAX(m_maxLandscapeColumns, m_maxPortaitColumns); i++)
		{
			[cell.widget addSubwidget:[self createWidgetForColumn:i]];
		} 
		
		[self didCreateNewTableCell:cell];
	}
	
	cell.widget.visibleColumnCount = m_visibleColumnCount;
 
	[self updateColumnsInCell:cell forIndexPath:indexPath];
 
	return cell;
}

//- (void) tableView:(UITableView*) tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//	  NSArray* visibleCells = [tableView visibleCells];
//	  for(GtMultiColumnTableViewCell* cell in visibleCells)
//	  {
//		  [cell.widget touchesBegan:touches withEvent:event];
//	  }
//}
//
//- (void) tableView:(UITableView*) tableView touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//	  NSArray* visibleCells = [tableView visibleCells];
//	  for(GtMultiColumnTableViewCell* cell in visibleCells)
//	  {
//		  [cell.widget touchesMoved:touches withEvent:event];
//	  }
//}
//
//- (void) tableView:(UITableView*) tableView touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//	  GtLog(@"touches ended event in tableview controller");
//
//	  NSArray* visibleCells = [[tableView visibleCells] copy];
//	  for(GtMultiColumnTableViewCell* cell in visibleCells)
//	  {
//		  [cell.widget touchesEnded:touches withEvent:event];
//	  }
//	  GtRelease(visibleCells);
//}
//
//- (void) tableView:(UITableView*) tableView touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
//{
//	  GtLog(@"touches cancelled event in tableview controller");
//
//	  NSArray* visibleCells = [tableView visibleCells];
//	  for(GtMultiColumnTableViewCell* cell in visibleCells)
//	  {
//		  [cell.widget touchesCancelled:touches withEvent:event];
//	  }
//}




@end
