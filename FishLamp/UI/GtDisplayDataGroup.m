//
//  GtDisplayDataGroup.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/6/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#if IPHONE

#import "GtDisplayDataGroup.h"

@interface GtDisplayDataGroup (PrivateMethods)
- (NSUInteger) editableRowCount;
- (GtDisplayDataRow*) nextEditableRow:(NSUInteger) index;
@end

@implementation GtDisplayDataGroup

@synthesize rows = m_rows;
@synthesize tab = m_tab;
@synthesize title = m_title;
@synthesize parentHandler = m_parentHandler;

- (id) init
{
	if(self = [super init])
	{
		m_rows = [GtAlloc(NSMutableArray) init];
	}
	return self;
}

- (void) dealloc
{
	GtRelease(m_title);
	GtRelease(m_rows);
	[super dealloc];
}

- (NSUInteger) rowCount
{
	return [m_rows count];
}

- (GtDisplayDataRow*) rowAtIndex:(NSUInteger) index
{
	return [m_rows objectAtIndex:index];
}

- (NSUInteger) indexForRow:(GtDisplayDataRow*) row
{
	return [m_rows indexOfObject:row];
}

- (NSUInteger) editableRowCount
{
	NSUInteger count = 0;
	for(GtDisplayDataRow* row in m_rows)
	{
		if([row isEditable])
		{
			++count;
		}
	}
	
	return count;
}

- (GtDisplayDataRow*) nextEditableRow:(NSUInteger) index
{
	GtAssert(index >= 0 && index < [m_rows count],
		@"invalid index");

	NSInteger i = -1;
	for(GtDisplayDataRow* row in m_rows)
	{
		if([row isEditable])
		{
			if(++i == index)
			{
				return row;
			}
		}
		
	}
	
	return nil;
}

- (BOOL) hasEditableRows
{
	for(GtDisplayDataRow* row in m_rows)
	{
		if([row isEditable])
		{
			return YES;
		}
	}

	return NO;
}

- (void) releaseCachedCells
{
	for(GtDisplayDataRow* row in m_rows)
	{
		row.cell = nil;
	}
}

- (GtDisplayDataRow*) rowForRowId:(id) inRowId
{
	for(GtDisplayDataRow* row in m_rows)
	{
		id rowId = row.rowId;
		if(rowId && [rowId isEqual:inRowId])
		{
			return row;
		} 
	}
	
	return nil;
}

- (NSUInteger) indexForRowId:(id) inRowId
{
	for(int i = 0; i < m_rows.count; i++)
	{
		id rowId = [[m_rows objectAtIndex:i] rowId];
		if(rowId && [rowId isEqual:inRowId])
		{
			return i;
		} 
	}
	
	return NSNotFound;
}

- (NSUInteger) indexForCell:(UITableViewCell *)cell
{
	for(int i = 0; i < m_rows.count; i++)
	{
		if([[m_rows objectAtIndex:i] cell] == cell)
		{
			return i;
		} 
	}
	
	return NSNotFound;
}

- (GtTextEditCell*) findNextCellToEdit:(GtTextEditCell*) cell
{   
    NSUInteger index = [self indexForCell:cell];
    if(index >= 0)
    {
        for(int i = (index+1); i < m_rows.count; i++)
        {
            GtDisplayDataRow* row = [self rowAtIndex:i];
            if([row.cell isKindOfClass:[GtTextEditCell class]])
            {
                return (GtTextEditCell*) row.cell;
            }
        }
    
    }
    
    return nil;
}

- (GtTextEditCell*) findPrevCellToEdit:(GtTextEditCell*) cell
{
    NSUInteger index = [self indexForCell:cell];
    if(index > 0)
    {
        for(int i = (index-1); i >= 0; i--)
        {
            GtDisplayDataRow* row = [self rowAtIndex:i];
            if([row.cell isKindOfClass:[GtTextEditCell class]])
            {
                return (GtTextEditCell*) row.cell;
            }
        }
    
    }

    return nil;
}



- (NSString*) description
{
	return [m_rows description];
}

- (void) addRow:(GtDisplayDataRow*) data
{
	data.parentGroup = self;
	[m_rows addObject:data];
}

@end
#endif