//
//	GtTableViewSection.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/6/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTableViewSection.h"
#import "GtTextEditCell.h"
#import "GtEditObjectTableViewCell.h"
#import "NSString+GUID.h"

@interface GtTableViewSection (PrivateMethods)
//- (NSUInteger) editableRowCount;
//- (GtEditObjectTableViewCell*) nextEditableRow:(NSUInteger) idx;
@end

@implementation GtTableViewSection

@synthesize cells = m_cells;
@synthesize parentTab = m_parent;
@synthesize headerHeight = m_headerHeight;
@synthesize footerHeight = m_footerHeight;

@synthesize title = m_title;

- (id) init
{
	if((self = [super init]))
	{
		m_cells = [[GtOrderedCollection alloc] init];
		m_headerView = [[GtTableViewHeaderView alloc] initWithFrame:CGRectZero];
	}
	return self;
}

- (void) dealloc
{
	GtReleaseWithNil(m_title);
	GtReleaseWithNil(m_cells);
	GtRelease(m_headerView);
	GtSuperDealloc();
}

- (NSUInteger) cellCount
{
	return [m_cells count];
}

- (GtEditObjectTableViewCell*) cellAtIndex:(NSUInteger) idx
{
	return [m_cells objectAtIndex:idx];
}

- (GtEditObjectTableViewCell*) cellForKey:(id) key
{
	return [m_cells objectForKey:key];
}

- (NSUInteger) indexForCell:(GtEditObjectTableViewCell*) row
{
	return [m_cells indexForKey:[row rowKey]];
}

- (void) removeCell:(GtEditObjectTableViewCell*) row
{
	[m_cells removeObjectForKey:[row rowKey]];
}

- (GtTableViewHeaderView*) headerView
{
	m_headerView.textLabel.text = self.title;
	[m_headerView applyTheme];

	
	return m_headerView;
}

- (NSUInteger) indexForCellKey:(id) inRowKey
{
	return [m_cells indexForKey:inRowKey];
}

//- (NSUInteger) indexForCell:(UITableViewCell *)cell
//{
//	for(NSUInteger i = 0; i < m_cells.count; i++)
//	{
//		if([m_cells objectAtIndex:i] == cell)
//		{
//			return i;
//		} 
//	}
//	
//	return NSNotFound;
//}

- (GtTextEditCell*) findNextCellToEdit:(GtTextEditCell*) cell
{	
	NSUInteger idx = [self indexForCell:cell];
	if(idx != NSNotFound)
	{
		for(NSUInteger i = (idx+1); i < m_cells.count; i++)
		{
			GtEditObjectTableViewCell* row = [self cellAtIndex:i];
			if([row isKindOfClass:[GtTextEditCell class]])
			{
				return (GtTextEditCell*) row;
			}
		}
	
	}
	
	return nil;
}

- (GtTextEditCell*) findPrevCellToEdit:(GtTextEditCell*) cell
{
	NSUInteger idx = [self indexForCell:cell];
	if(idx > 0)
	{
		for(int i = (idx-1); i >= 0; i--)
		{
			GtEditObjectTableViewCell* row = [self cellAtIndex:i];
			if([row isKindOfClass:[GtTextEditCell class]])
			{
				return (GtTextEditCell*) row;
			}
		}
	
	}

	return nil;
}

- (NSString*) description
{
	return [m_cells description];
}

- (void) addCell:(GtEditObjectTableViewCell*) cell
{
    GtAssertIsValidString(cell.dataKeyPath);
    
	if(GtStringIsEmpty(cell.rowKey))
	{
		cell.rowKey = cell.dataKeyPath;
	}
	cell.parentSection = self;
	[m_cells addOrReplaceObject:cell forKey:cell.rowKey];
}

@end
