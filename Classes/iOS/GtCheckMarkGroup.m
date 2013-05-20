//
//	GtCheckMarkGroup.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/24/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtCheckMarkGroup.h"
#import "GtCheckMarkTableViewCell.h"
#import "NSString+GUID.h"

@implementation GtCheckMarkGroup

@synthesize dataKeyPath = m_dataKey;

- (id) initWithDataKeyPath:(NSString*) dataKeyPath
{
	if((self = [super init]))
	{
		m_dataKey = GtRetain(dataKeyPath);
		m_rows = [[NSMutableArray alloc] init];
	}

	return self;
}

+ (GtCheckMarkGroup*) checkMarkTableCellGroup:(NSString*) dataKeyPath
{
	return GtReturnAutoreleased([[GtCheckMarkGroup alloc] initWithDataKeyPath:dataKeyPath]);
}

- (GtCheckMarkTableViewCell*) cellAtIndex:(NSUInteger) idx
{
	return [[m_rows objectAtIndex:idx] nonretainedObjectValue];
}

- (NSUInteger) indexForCell:(GtCheckMarkTableViewCell*) cell
{
	for(NSUInteger i = 0; i < m_rows.count; i++)
	{
		if([[m_rows objectAtIndex:i] nonretainedObjectValue] == cell)
		{
			return i;
		}
	}
	
	return NSNotFound;
}

- (void) setSelectedCellIndex:(NSUInteger) idx
{
	for(NSUInteger i = 0; i < m_rows.count; i++)
	{
		GtCheckMarkTableViewCell* cell = [[m_rows objectAtIndex:i] nonretainedObjectValue];
		cell.checked = (i == idx);
	}
}

- (NSUInteger) selectedCellIndex
{
	for(NSUInteger i = 0; i < m_rows.count; i++)
	{
		if([[[m_rows objectAtIndex:i] nonretainedObjectValue] checked])
		{
			return i;
		}
	}
	
	return NSNotFound;
}

- (GtCheckMarkTableViewCell*) addRowWithTitle:(NSString*) title value:(id) value isChecked:(BOOL) isChecked
{
	GtCheckMarkTableViewCell* cell = [GtCheckMarkTableViewCell checkMarkedTableCell:title checked:isChecked checkedValue:value];
	cell.checkMarkGroup = self;
	cell.dataKeyPath = self.dataKeyPath;
	cell.rowKey = [NSString guidString];
	[m_rows addObject:[NSValue valueWithNonretainedObject:cell]];
	return cell;
}

- (void) checkMarkWasSelected:(GtCheckMarkTableViewCell*) selectedCell
{
	for(NSUInteger i = 0; i < m_rows.count; i++)
	{
		GtCheckMarkTableViewCell* cell = [[m_rows objectAtIndex:i] nonretainedObjectValue];
	
		if(cell != selectedCell)
		{
			cell.checked = NO;
			
		}
	}
	
	GtAssert(selectedCell.checked, @"not checked");
}

- (void) dealloc
{
	GtRelease(m_rows);
	GtRelease(m_dataKey);
	GtSuperDealloc();
}

@end
