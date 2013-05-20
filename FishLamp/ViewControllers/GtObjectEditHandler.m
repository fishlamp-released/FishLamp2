//
//  GtObjectEditHandler.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/10/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#if IPHONE

#import "GtObjectEditHandler.h"

@implementation GtObjectEditHandler
@synthesize tab = m_tab;

- (id) init
{
	if(self = [super init])
	{
		for(int i = 0; i < GtNumEditHandlerTabs; i++)
		{
			m_groups[i] = nil;
		}
	}
	return self;
}

+ (GtObjectEditHandler*) handler
{
	return [[[GtObjectEditHandler alloc] init] autorelease];
}

- (void) setTab:(NSUInteger) tab
{
	GtAssert(tab >= 0 && tab < GtNumEditHandlerTabs, @"tab is out of range");
	m_tab = tab;
}

- (void) dealloc
{
    [self releaseCachedCells];

	for(int i = 0; i < GtNumEditHandlerTabs; i++)
	{
		if(m_groups[i])
		{
			GtRelease(m_groups[i]);
		}
	}
	[super dealloc];
}

- (GtDisplayDataRow*) rowForPath:(NSIndexPath *)indexPath
{
	GtDisplayDataGroup* group = [self groupAtIndex:indexPath.section];

	return [group rowAtIndex:indexPath.row]; 
}

- (UITableViewCell*) cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	GtDisplayDataRow* row = [self rowForPath:indexPath];
	
	return row.cell;
}

- (BOOL) hasEditableRows
{
	for(int i = 0; i < GtNumEditHandlerTabs; i++)
	{
		for(GtDisplayDataGroup* group in m_groups[i])
		{
			if(group.hasEditableRows)
			{
				return YES;
			}
		}
	}
	
	return NO;
}

- (GtDisplayDataRow*) rowForRowId:(id) rowId
{
	for(int i = 0; i < GtNumEditHandlerTabs; i++)
	{
		for(GtDisplayDataGroup* group in m_groups[i])
		{
			GtDisplayDataRow* row = [group rowForRowId:rowId];
			if(row)
			{
				return row;
			}
		}
	}
	
	return nil;
}

- (void) addGroup:(GtDisplayDataGroup*) group
{
	[self addGroup:group tab:0];
}

- (void) addGroup:(GtDisplayDataGroup*) group tab:(int) inTab
{
	group.parentHandler = self;
	group.tab = inTab;
	
	if(!m_groups[inTab])
	{
		m_groups[inTab] = [GtAlloc(NSMutableArray) initWithObjects:group, nil];
	}
	else
	{
		[m_groups[inTab] addObject:group];
	}
}

- (NSUInteger) groupCount
{
	return [m_groups[self.tab] count]; 
}

- (GtDisplayDataGroup*) groupAtIndex:(NSUInteger) index
{
	return [m_groups[self.tab] objectAtIndex:index];
}

- (NSString*) description
{
	return @"add a usefull description"; // [m_groups description];
}

- (GtDisplayDataGroup*) lastGroup
{
	return [m_groups[self.tab] lastObject];
}

- (NSIndexPath*) indexPathForRowInCurrentTab:(GtDisplayDataRow*) dataRow
{
	for(int i = 0; i <  m_groups[self.tab].count; i++)
	{
		NSUInteger row = [[m_groups[self.tab] objectAtIndex:i] indexForRow:dataRow];
		if(row != NSNotFound)
		{
			return [NSIndexPath indexPathForRow:row inSection:i];
		}
	
	}

	return nil;
}

- (NSIndexPath*) indexPathForRowId:(id) rowId
{
	for(int i = 0; i <  m_groups[self.tab].count; i++)
	{
		NSUInteger row = [[m_groups[self.tab] objectAtIndex:i] indexForRowId:rowId];
		if(row != NSNotFound)
		{
			return [NSIndexPath indexPathForRow:row inSection:i];
		}
	
	}
	
	return nil;
}

- (NSIndexPath*) indexPathForCell:(UITableViewCell *)cell
{
	for(int i = 0; i <  m_groups[self.tab].count; i++)
	{
		NSUInteger row = [[m_groups[self.tab] objectAtIndex:i] indexForCell:cell];
		if(row != NSNotFound)
		{
			return [NSIndexPath indexPathForRow:row inSection:i];
		}
	
	}
	
	return nil;

}



- (void) releaseCachedCells
{
	for(int i = 0; i < GtNumEditHandlerTabs; i++)
	{
		for(GtDisplayDataGroup* group in m_groups[i])
		{
			[group releaseCachedCells];
		}
	}
}


@end
#endif