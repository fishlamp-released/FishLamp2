//
//	FLTableViewLayoutBuilder.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/29/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLTableViewLayoutBuilder.h"

#import "FLTableViewSection.h"
#import "FLTableViewTab.h"
#import "FLLegacyDataSource.h"
#import "NSString+GUID.h"

@implementation FLTableViewLayoutBuilder

@synthesize tableLayout = _tableLayout;
@synthesize section = _currentSection;
@synthesize cell = _currentCell;
@synthesize tab = _tab;
@synthesize cells = _cells;
@synthesize sections = _groups;

- (id) initWithTableLayout:(FLTableViewLayout*) tableLayout
{
	if((self = [super init]))
	{
		self.tableLayout = tableLayout;
		_cells = [[NSMutableArray alloc] init];
		_groups = [[NSMutableArray alloc] init];
	}
	
	return self;
}

+ (FLTableViewLayoutBuilder*) tableViewLayoutBuilder:(FLTableViewLayout*) tableLayout
{
	return FLReturnAutoreleased([[FLTableViewLayoutBuilder alloc] initWithTableLayout:tableLayout]);
}

- (void) dealloc
{
	FLRelease(_tableLayout);
	FLRelease(_currentSection);
	FLRelease(_currentCell);
	FLRelease(_cells);
	FLRelease(_groups);
	FLSuperDealloc();
}

- (void) addTab
{
	++_tab;
	if(self.tableLayout.tabCount < _tab)
	{
		[self.tableLayout addTab];
	}
}

- (void) setTab:(NSUInteger) tab
{
	_tab = tab;
	
}

- (FLTableViewSection*) addSection:(NSString*) key
{
	self.section = FLReturnAutoreleased([[FLTableViewSection alloc] init]);
	[_groups addObject:_currentSection];
	[[self.tableLayout tabWithIndex:_tab] addSection:_currentSection forKey:key];
	
	return self.section;
}

- (FLTableViewSection*) addSection
{
	return [self addSection:[NSString guidString]];
}


- (FLEditObjectTableViewCell*) addCell:(FLEditObjectTableViewCell*) cell
{
	self.cell = cell;
	_currentCell.dataSource = self.tableLayout.cellDataSource;
	[_cells addObject:self.cell];
	[self.section addCell:self.cell];
	return self.cell;
}

- (FLEditObjectTableViewCell*) addCell:(FLEditObjectTableViewCell*) cell forKey:(NSString*) forKey
{
	if(FLStringIsNotEmpty(forKey))
    {
        cell.dataKeyPath = forKey;
    }
	return [self addCell:cell];
}

- (FLEditObjectTableViewCell*) addCell:(FLEditObjectTableViewCell*) cell forKey:(NSString*) key dataSourceKey:(NSString*) dataSource 
{
	return [self addCell:cell forKey:FLKeyPathStringMake(dataSource, key)];
}

- (void) addCell:(FLEditObjectTableViewCell*) cell 
   forKey:(NSString*) dataKeyOrNil
   configureCell:(FLTableViewLayoutCreateCell) callback
{
	FLAssertIsNotNil(callback);
	if(callback)
	{
		if(FLStringIsNotEmpty(dataKeyOrNil))
        {
            cell.dataKeyPath = dataKeyOrNil; 
        }
        
        callback(cell);
		[self addCell:cell];
	}
}	


@end
