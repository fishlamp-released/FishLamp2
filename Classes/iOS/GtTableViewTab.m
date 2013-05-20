//
//	GtTableViewTab.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/10/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTableViewTab.h"
#import "GtTableViewLayout.h"
#import "GtTableViewSection.h"

@implementation GtTableViewTab

@synthesize parentLayout = m_parentLayout;
@synthesize sections = m_sections;

- (id) init
{
	if((self = [super init]))
	{
		m_sections = [[GtOrderedCollection alloc] init];
	}
	return self;
}

//- (void) releaseCachedCells
//{
//	for(int i = 0; i < GtNumEditHandlerTabs; i++)
//	{
//		for(GtTableViewSection* section in m_groups[i])
//		{
//			[section releaseCachedCells];
//		}
//	}
//}

- (void) dealloc
{
	GtRelease(m_sections);
	GtSuperDealloc();
}

//- (BOOL) hasEditableRows
//{
//	for(GtTableViewSection* section in m_sections.forwardObjectEnumerator)
//	{	
//		if(section.hasEditableRows)
//		{
//			return YES;
//		}
//	}
//	
//	return NO;
//}

- (void) addSection:(GtTableViewSection*) section forKey:(id) key;
{
	section.parentTab = self;
	[m_sections addOrReplaceObject:section forKey:key];
}

- (void) removeSectionForKey:(id) key
{	
	[m_sections removeObjectForKey:key];
}

- (GtTableViewSection*) sectionForKey:(id) key
{
	return [m_sections objectForKey:key];
}

- (NSUInteger) sectionCount
{
	return [m_sections count]; 
}

- (GtTableViewSection*) sectionAtIndex:(NSUInteger) idx
{
	return [m_sections objectAtIndex:idx];
}

- (NSString*) description
{
	return @"add a usefull description"; // [m_groups description];
}

- (GtTableViewSection*) lastSection
{
	return [m_sections lastObject];
}

//- (void) addCell:(GtEditObjectTableViewCell*) row inGroup:(GtTableViewSection*) inGroup
//{
//	  [inGroup addRow:row];
//}

- (GtTableViewSection*) sectionForRowKey:(id) rowKey
{
	for(GtTableViewSection* section in m_sections.forwardObjectEnumerator)
	{	
		GtEditObjectTableViewCell* row = [section cellForKey:rowKey];
		if(row)
		{
			return section;
		}
	}

	return nil;
} 

- (GtEditObjectTableViewCell*) rowForRowKey:(id) dataKey
{
	for(GtTableViewSection* section in m_sections.forwardObjectEnumerator)
	{	
		GtEditObjectTableViewCell* row = [section cellForKey:dataKey];
		if(row)
		{
			return row;
		}
	}

	return nil;
}

- (void) removeRow:(GtEditObjectTableViewCell*) row
{
	if(row)
	{
		[row.parentSection removeCell:row];
	}
}

- (void) removeRowForRowKey:(id) rowKey
{
	if(rowKey)
	{
		GtEditObjectTableViewCell* row = [self rowForRowKey:rowKey];
		[self removeRow:row];
	}
}

- (GtEditObjectTableViewCell*) cellForIndexPath:(NSIndexPath*) indexPath
{
	return [[self sectionAtIndex:indexPath.section] cellAtIndex:indexPath.row]; 
}

- (NSIndexPath*) indexPathForCell:(GtEditObjectTableViewCell *)cell
{
	for(NSUInteger i = 0; i < m_sections.count; i++)
	{
		NSUInteger row = [[m_sections objectAtIndex:i] indexForCell:cell];
		if(row != NSNotFound)
		{
			return [NSIndexPath indexPathForRow:row inSection:i];
		}
	
	}
	
	return nil;

}

@end

