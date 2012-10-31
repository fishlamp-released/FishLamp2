//
//	FLMultiColumnTableViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/5/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLMultiColumnTableViewController.h"


@implementation FLMultiColumnTableViewController

@synthesize maxPortaitColumns = _maxPortaitColumns;
@synthesize maxLandscapeColumns = _maxLandscapeColumns;
@synthesize visibleColumnCount = _visibleColumnCount;

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
	_isLandscapeOriented = toLandscapeOrientation;
	_visibleColumnCount = toLandscapeOrientation ? 
		 _maxLandscapeColumns : _maxPortaitColumns;

	_numberOfDataItems = [self numberOfDataItems];
	_rowCount = ((_numberOfDataItems / _visibleColumnCount) + 
							(((_numberOfDataItems % _visibleColumnCount) > 0) ? 1 : 0));
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
	return _rowCount;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	return nil;
}

- (NSUInteger) numberOfDataItems
{
	return 0;
}

- (FLWidget*) createWidgetForColumn:(NSUInteger) columnNumber
{ 
	return nil;
}

- (void) updateWidget:(FLWidget*) widget forDataItemIndex:(NSUInteger) itemIndex
{
}

- (NSUInteger) rowNumberForDataItemIndex:(NSUInteger) dataItemIndex
{
	return dataItemIndex / _visibleColumnCount;
}

- (void) updateColumnsInCell:(FLMultiColumnTableViewCell*) cell	 forIndexPath:(NSIndexPath*) indexPath
{
	NSUInteger startIndex = indexPath.row * _visibleColumnCount;
	for(NSUInteger i = 0; i < MAX(_maxLandscapeColumns, _maxPortaitColumns); i++)
	{
		NSUInteger arrayIndex = i + startIndex;
	
		if(arrayIndex < _numberOfDataItems && i < _visibleColumnCount)
		{
			[cell.widget widgetAtIndex:i].hidden = NO;
			[self updateWidget:[cell.widget widgetAtIndex:i] forDataItemIndex:arrayIndex];
		}
		else 
		{
			[cell.widget widgetAtIndex:i].hidden = YES;
		}
	}
}

- (void) didCreateNewTableCell:(FLMultiColumnTableViewCell*) cell
{

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	static NSString* CellIdentifier = @"c";
	
	FLMultiColumnTableViewCell* cell = (FLMultiColumnTableViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if(!cell)
	{
		cell = autorelease_([[FLMultiColumnTableViewCell alloc] initWithReuseIdentifier:CellIdentifier]);
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		for(NSUInteger i = 0; i < MAX(_maxLandscapeColumns, _maxPortaitColumns); i++)
		{
			[cell.widget addWidget:[self createWidgetForColumn:i]];
		} 
		
		[self didCreateNewTableCell:cell];
	}
	
	cell.widget.visibleColumnCount = _visibleColumnCount;
 
	[self updateColumnsInCell:cell forIndexPath:indexPath];
 
	return cell;
}

//- (void) tableView:(UITableView*) tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//	  NSArray* visibleCells = [tableView visibleCells];
//	  for(FLMultiColumnTableViewCell* cell in visibleCells)
//	  {
//		  [cell.widget touchesBegan:touches withEvent:event];
//	  }
//}
//
//- (void) tableView:(UITableView*) tableView touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//	  NSArray* visibleCells = [tableView visibleCells];
//	  for(FLMultiColumnTableViewCell* cell in visibleCells)
//	  {
//		  [cell.widget touchesMoved:touches withEvent:event];
//	  }
//}
//
//- (void) tableView:(UITableView*) tableView touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//	  FLLog(@"touches ended event in tableview controller");
//
//	  NSArray* visibleCells = [[tableView visibleCells] copy];
//	  for(FLMultiColumnTableViewCell* cell in visibleCells)
//	  {
//		  [cell.widget touchesEnded:touches withEvent:event];
//	  }
//	  mrc_release_(visibleCells);
//}
//
//- (void) tableView:(UITableView*) tableView touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
//{
//	  FLLog(@"touches cancelled event in tableview controller");
//
//	  NSArray* visibleCells = [tableView visibleCells];
//	  for(FLMultiColumnTableViewCell* cell in visibleCells)
//	  {
//		  [cell.widget touchesCancelled:touches withEvent:event];
//	  }
//}




@end
