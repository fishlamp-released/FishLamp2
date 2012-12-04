//
//	FLTableViewTab.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/10/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLTableViewTab.h"
#import "FLTableViewLayout.h"
#import "FLTableViewSection.h"

@implementation FLTableViewTab

@synthesize parentLayout = _parentLayout;
@synthesize sections = _sections;

- (id) init
{
	if((self = [super init]))
	{
		_sections = [[FLOrderedCollection alloc] init];
	}
	return self;
}

//- (void) releaseCachedCells
//{
//	for(int i = 0; i < FLNumEditHandlerTabs; i++)
//	{
//		for(FLTableViewSection* section in _groups[i])
//		{
//			[section releaseCachedCells];
//		}
//	}
//}

- (void) dealloc
{
	release_(_sections);
	super_dealloc_();
}

//- (BOOL) hasEditableRows
//{
//	for(FLTableViewSection* section in _sections.forwardObjectEnumerator)
//	{	
//		if(section.hasEditableRows)
//		{
//			return YES;
//		}
//	}
//	
//	return NO;
//}

- (void) addSection:(FLTableViewSection*) section forKey:(id) key
{
	section.parentTab = self;
	[_sections addOrReplaceObject:section forKey:key];
}

- (void) removeSectionForKey:(id) key
{	
	[_sections removeObjectForKey:key];
}

- (FLTableViewSection*) sectionForKey:(id) key
{
	return [_sections objectForKey:key];
}

- (NSUInteger) sectionCount
{
	return [_sections count]; 
}

- (FLTableViewSection*) sectionAtIndex:(NSUInteger) idx
{
	return [_sections objectAtIndex:idx];
}

- (NSString*) description
{
	return @"add a usefull description"; // [_groups description];
}

- (FLTableViewSection*) lastSection
{
	return [_sections lastObject];
}

//- (void) addCell:(FLEditObjectTableViewCell*) row inGroup:(FLTableViewSection*) inGroup
//{
//	  [inGroup addRow:row];
//}

- (FLTableViewSection*) sectionForRowKey:(id) rowKey
{
	for(FLTableViewSection* section in _sections.forwardObjectEnumerator)
	{	
		FLEditObjectTableViewCell* row = [section cellForKey:rowKey];
		if(row)
		{
			return section;
		}
	}

	return nil;
} 

- (FLEditObjectTableViewCell*) rowForRowKey:(id) dataKey
{
	for(FLTableViewSection* section in _sections.forwardObjectEnumerator)
	{	
		FLEditObjectTableViewCell* row = [section cellForKey:dataKey];
		if(row)
		{
			return row;
		}
	}

	return nil;
}

- (void) removeRow:(FLEditObjectTableViewCell*) row
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
		FLEditObjectTableViewCell* row = [self rowForRowKey:rowKey];
		[self removeRow:row];
	}
}

- (FLEditObjectTableViewCell*) cellForIndexPath:(NSIndexPath*) indexPath
{
	return [[self sectionAtIndex:indexPath.section] cellAtIndex:indexPath.row]; 
}

- (NSIndexPath*) indexPathForCell:(FLEditObjectTableViewCell *)cell
{
	for(NSUInteger i = 0; i < _sections.count; i++)
	{
		NSUInteger row = [[_sections objectAtIndex:i] indexForCell:cell];
		if(row != NSNotFound)
		{
			return [NSIndexPath indexPathForRow:row inSection:i];
		}
	
	}
	
	return nil;

}

@end

