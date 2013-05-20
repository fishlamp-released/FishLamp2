//
//	GtTableViewLayout.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTableViewLayout.h"
#import "GtEditObjectTableViewCell.h"

@implementation GtTableViewLayout

@synthesize currentTabIndex = m_currentTabIndex;
@synthesize cellDataSource = m_cellDataSource;

GtAssertDefaultInitNotCalled();

- (id) initWithCellDataSouce:(id<GtTableViewCellDataSource>) dataSource
{
	if((self = [super init]))
	{
		m_cellDataSource = dataSource;
		m_tabs = [[NSMutableArray alloc] initWithCapacity:1];
		[self addTab];
	}
	
	return self;
}

- (void) dealloc
{
	GtRelease(m_tabs);
	GtSuperDealloc();
}

- (NSUInteger) tabCount
{
	return m_tabs.count;
}

- (void) addTab
{
	GtTableViewTab* tab = [[GtTableViewTab alloc] init];
	[m_tabs addObject:tab];
	GtRelease(tab);
}

- (GtTableViewTab*) tabWithIndex:(NSUInteger) tab
{
	while(m_tabs.count <= tab)
	{
		[self addTab];
	}

	return [m_tabs objectAtIndex:tab];
}

- (GtTableViewTab*) currentTab
{
	return [m_tabs objectAtIndex:self.currentTabIndex];
}

//- (BOOL) hasEditableRows
//{
//	for(GtTableViewTab* tab in m_tabs)
//	{
//		if(tab.hasEditableRows) 
//		{
//			return YES;
//		}
//	}
//	return NO;
//}

- (GtEditObjectTableViewCell*) rowForRowKey:(id) key
{
	for(GtTableViewTab* tab in m_tabs)
	{
		GtEditObjectTableViewCell* row = [tab rowForRowKey:key]; 
		if(row)
		{
			return row;
		}
	}
	return nil;
}

- (void) prepareForDestruction
{
	for(GtTableViewTab* tab in m_tabs)
	{
		for(GtTableViewSection* section in tab.sections.forwardObjectEnumerator)
		{
			for(GtEditObjectTableViewCell* row in section.cells.forwardObjectEnumerator)
			{
				[row prepareForDestruction];;
			}
		}
	}
}

- (void) removeRowForRowKey:(id) key
{
	GtEditObjectTableViewCell* row = [self rowForRowKey:key];
	[row.parentSection removeCell:row];
}

@end

