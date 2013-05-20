//
//	FLCheckMarkGroup.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/24/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCheckMarkGroup.h"
#import "FLCheckMarkTableViewCell.h"
#import "NSString+GUID.h"

@implementation FLCheckMarkGroup

@synthesize dataKeyPath = _dataKey;

- (id) initWithDataKeyPath:(NSString*) dataKeyPath
{
	if((self = [super init]))
	{
		_dataKey = FLRetain(dataKeyPath);
		_rows = [[NSMutableArray alloc] init];
	}

	return self;
}

+ (FLCheckMarkGroup*) checkMarkTableCellGroup:(NSString*) dataKeyPath
{
	return FLAutorelease([[FLCheckMarkGroup alloc] initWithDataKeyPath:dataKeyPath]);
}

- (FLCheckMarkTableViewCell*) cellAtIndex:(NSUInteger) idx
{
	return [[_rows objectAtIndex:idx] nonretainedObjectValue];
}

- (NSUInteger) indexForCell:(FLCheckMarkTableViewCell*) cell
{
	for(NSUInteger i = 0; i < _rows.count; i++)
	{
		if([[_rows objectAtIndex:i] nonretainedObjectValue] == cell)
		{
			return i;
		}
	}
	
	return NSNotFound;
}

- (void) setSelectedCellIndex:(NSUInteger) idx
{
	for(NSUInteger i = 0; i < _rows.count; i++)
	{
		FLCheckMarkTableViewCell* cell = [[_rows objectAtIndex:i] nonretainedObjectValue];
		cell.checked = (i == idx);
	}
}

- (NSUInteger) selectedCellIndex
{
	for(NSUInteger i = 0; i < _rows.count; i++)
	{
		if([[[_rows objectAtIndex:i] nonretainedObjectValue] checked])
		{
			return i;
		}
	}
	
	return NSNotFound;
}

- (FLCheckMarkTableViewCell*) addRowWithTitle:(NSString*) title value:(id) value isChecked:(BOOL) isChecked
{
	FLCheckMarkTableViewCell* cell = [FLCheckMarkTableViewCell checkMarkedTableCell:title checked:isChecked checkedValue:value];
	cell.checkMarkGroup = self;
	cell.dataKeyPath = self.dataKeyPath;
	cell.rowKey = [NSString guidString];
	[_rows addObject:[NSValue valueWithNonretainedObject:cell]];
	return cell;
}

- (void) checkMarkWasSelected:(FLCheckMarkTableViewCell*) selectedCell
{
	for(NSUInteger i = 0; i < _rows.count; i++)
	{
		FLCheckMarkTableViewCell* cell = [[_rows objectAtIndex:i] nonretainedObjectValue];
	
		if(cell != selectedCell)
		{
			cell.checked = NO;
			
		}
	}
	
	FLAssertWithComment(selectedCell.checked, @"not checked");
}

- (void) dealloc
{
	FLRelease(_rows);
	FLRelease(_dataKey);
	FLSuperDealloc();
}

@end
