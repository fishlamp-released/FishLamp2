//
//	FLTableViewLayout.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLTableViewLayout.h"
#import "FLEditObjectTableViewCell.h"

@implementation FLTableViewLayout

@synthesize currentTabIndex = _currentTabIndex;
@synthesize cellDataSource = _cellDataSource;

FLAssertDefaultInitNotCalled();

- (id) initWithCellDataSouce:(id<FLTableViewCellDataSource>) dataSource
{
	if((self = [super init]))
	{
		_cellDataSource = dataSource;
		_tabs = [[NSMutableArray alloc] initWithCapacity:1];
		[self addTab];
	}
	
	return self;
}

- (void) dealloc
{
	FLRelease(_tabs);
	FLSuperDealloc();
}

- (NSUInteger) tabCount
{
	return _tabs.count;
}

- (void) addTab
{
	FLTableViewTab* tab = [[FLTableViewTab alloc] init];
	[_tabs addObject:tab];
	FLRelease(tab);
}

- (FLTableViewTab*) tabWithIndex:(NSUInteger) tab
{
	while(_tabs.count <= tab)
	{
		[self addTab];
	}

	return [_tabs objectAtIndex:tab];
}

- (FLTableViewTab*) currentTab
{
	return [_tabs objectAtIndex:self.currentTabIndex];
}

//- (BOOL) hasEditableRows
//{
//	for(FLTableViewTab* tab in _tabs)
//	{
//		if(tab.hasEditableRows) 
//		{
//			return YES;
//		}
//	}
//	return NO;
//}

- (FLEditObjectTableViewCell*) rowForRowKey:(id) key
{
	for(FLTableViewTab* tab in _tabs)
	{
		FLEditObjectTableViewCell* row = [tab rowForRowKey:key]; 
		if(row)
		{
			return row;
		}
	}
	return nil;
}

- (void) prepareForDestruction
{
	for(FLTableViewTab* tab in _tabs)
	{
		for(FLTableViewSection* section in tab.sections.forwardObjectEnumerator)
		{
			for(FLEditObjectTableViewCell* row in section.cells.forwardObjectEnumerator)
			{
				[row prepareForDestruction];;
			}
		}
	}
}

- (void) removeRowForRowKey:(id) key
{
	FLEditObjectTableViewCell* row = [self rowForRowKey:key];
	[row.parentSection removeCell:row];
}

@end

