//
//	FLTableViewSection.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/6/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLTableViewSection.h"
#import "FLTextEditCell.h"
#import "FLEditObjectTableViewCell.h"
#import "NSString+GUID.h"

@interface FLTableViewSection (PrivateMethods)
//- (NSUInteger) editableRowCount;
//- (FLEditObjectTableViewCell*) nextEditableRow:(NSUInteger) idx;
@end

@implementation FLTableViewSection

@synthesize cells = _cells;
@synthesize parentTab = _parent;
@synthesize headerHeight = _headerHeight;
@synthesize footerHeight = _footerHeight;

@synthesize title = _title;

- (id) init
{
	if((self = [super init]))
	{
		_cells = [[FLOrderedCollection alloc] init];
		_headerView = [[FLTableViewHeaderView alloc] initWithFrame:CGRectZero];
	}
	return self;
}

- (void) dealloc
{
	FLReleaseWithNil(_title);
	FLReleaseWithNil(_cells);
	FLRelease(_headerView);
	FLSuperDealloc();
}

- (NSUInteger) cellCount
{
	return [_cells count];
}

- (FLEditObjectTableViewCell*) cellAtIndex:(NSUInteger) idx
{
	return [_cells objectAtIndex:idx];
}

- (FLEditObjectTableViewCell*) cellForKey:(id) key
{
	return [_cells objectForKey:key];
}

- (NSUInteger) indexForCell:(FLEditObjectTableViewCell*) row
{
	return [_cells indexForKey:[row rowKey]];
}

- (void) removeCell:(FLEditObjectTableViewCell*) row
{
	[_cells removeObjectForKey:[row rowKey]];
}

- (FLTableViewHeaderView*) headerView
{
	_headerView.textLabel.text = self.title;
	[_headerView applyThemeIfNeeded];

	return _headerView;
}

- (NSUInteger) indexForCellKey:(id) inRowKey
{
	return [_cells indexForKey:inRowKey];
}

//- (NSUInteger) indexForCell:(UITableViewCell *)cell
//{
//	for(NSUInteger i = 0; i < _cells.count; i++)
//	{
//		if([_cells objectAtIndex:i] == cell)
//		{
//			return i;
//		} 
//	}
//	
//	return NSNotFound;
//}

- (FLTextEditCell*) findNextCellToEdit:(FLTextEditCell*) cell
{	
	NSUInteger idx = [self indexForCell:cell];
	if(idx != NSNotFound)
	{
		for(NSUInteger i = (idx+1); i < _cells.count; i++)
		{
			FLEditObjectTableViewCell* row = [self cellAtIndex:i];
			if([row isKindOfClass:[FLTextEditCell class]])
			{
				return (FLTextEditCell*) row;
			}
		}
	
	}
	
	return nil;
}

- (FLTextEditCell*) findPrevCellToEdit:(FLTextEditCell*) cell
{
	NSUInteger idx = [self indexForCell:cell];
	if(idx > 0)
	{
		for(int i = (idx-1); i >= 0; i--)
		{
			FLEditObjectTableViewCell* row = [self cellAtIndex:i];
			if([row isKindOfClass:[FLTextEditCell class]])
			{
				return (FLTextEditCell*) row;
			}
		}
	
	}

	return nil;
}

- (NSString*) description
{
	return [_cells description];
}

- (void) addCell:(FLEditObjectTableViewCell*) cell
{
    FLAssertStringIsNotEmpty(cell.dataKeyPath);
    
	if(FLStringIsEmpty(cell.rowKey))
	{
		cell.rowKey = cell.dataKeyPath;
	}
	cell.parentSection = self;
	[_cells addOrReplaceObject:cell forKey:cell.rowKey];
}

@end
