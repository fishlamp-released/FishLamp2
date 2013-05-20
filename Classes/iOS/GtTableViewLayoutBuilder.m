//
//	GtTableViewLayoutBuilder.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/29/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTableViewLayoutBuilder.h"

#import "GtTableViewSection.h"
#import "GtTableViewTab.h"
#import "GtDataSource.h"
#import "NSString+GUID.h"

@implementation GtTableViewLayoutBuilder

@synthesize tableLayout = m_tableLayout;
@synthesize section = m_currentSection;
@synthesize cell = m_currentCell;
@synthesize tab = m_tab;
@synthesize cells = m_cells;
@synthesize sections = m_groups;

- (id) initWithTableLayout:(GtTableViewLayout*) tableLayout
{
	if((self = [super init]))
	{
		self.tableLayout = tableLayout;
		m_cells = [[NSMutableArray alloc] init];
		m_groups = [[NSMutableArray alloc] init];
	}
	
	return self;
}

+ (GtTableViewLayoutBuilder*) tableViewLayoutBuilder:(GtTableViewLayout*) tableLayout
{
	return GtReturnAutoreleased([[GtTableViewLayoutBuilder alloc] initWithTableLayout:tableLayout]);
}

- (void) dealloc
{
	GtRelease(m_tableLayout);
	GtRelease(m_currentSection);
	GtRelease(m_currentCell);
	GtRelease(m_cells);
	GtRelease(m_groups);
	GtSuperDealloc();
}

- (void) addTab
{
	++m_tab;
	if(self.tableLayout.tabCount < m_tab)
	{
		[self.tableLayout addTab];
	}
}

- (void) setTab:(NSUInteger) tab
{
	m_tab = tab;
	
}

- (GtTableViewSection*) addSection:(NSString*) key
{
	self.section = GtReturnAutoreleased([[GtTableViewSection alloc] init]);
	[m_groups addObject:m_currentSection];
	[[self.tableLayout tabWithIndex:m_tab] addSection:m_currentSection forKey:key];
	
	return self.section;
}

- (GtTableViewSection*) addSection
{
	return [self addSection:[NSString guidString]];
}


- (GtEditObjectTableViewCell*) addCell:(GtEditObjectTableViewCell*) cell
{
	self.cell = cell;
	m_currentCell.dataSource = self.tableLayout.cellDataSource;
	[m_cells addObject:self.cell];
	[self.section addCell:self.cell];
	return self.cell;
}

- (GtEditObjectTableViewCell*) addCell:(GtEditObjectTableViewCell*) cell forKey:(NSString*) forKey
{
	if(GtStringIsNotEmpty(forKey))
    {
        cell.dataKeyPath = forKey;
    }
	return [self addCell:cell];
}

- (GtEditObjectTableViewCell*) addCell:(GtEditObjectTableViewCell*) cell forKey:(NSString*) key dataSourceKey:(NSString*) dataSource 
{
	return [self addCell:cell forKey:GtKeyPathStringMake(dataSource, key)];
}

- (void) addCell:(GtEditObjectTableViewCell*) cell 
   forKey:(NSString*) dataKeyOrNil
   configureCell:(GtTableViewLayoutCreateCell) callback
{
	GtAssertNotNil(callback);
	if(callback)
	{
		if(GtStringIsNotEmpty(dataKeyOrNil))
        {
            cell.dataKeyPath = dataKeyOrNil; 
        }
        
        callback(cell);
		[self addCell:cell];
	}
}	


@end
