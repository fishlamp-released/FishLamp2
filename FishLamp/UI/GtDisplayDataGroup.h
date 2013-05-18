//
//  GtDisplayDataGroup.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/6/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//
#if IPHONE

#import <Foundation/Foundation.h>

#import "GtDisplayDataRow.h"
#import "GtDataContainer.h"
#import "GtTextEditCell.h"

@class GtObjectEditHandler;

@interface GtDisplayDataGroup : NSObject {
	NSMutableArray* m_rows;
	int m_tab;
	NSString* m_title;
	GtObjectEditHandler* m_parentHandler;
}

- (id) init;

// display items
@property (readonly, retain, nonatomic) NSMutableArray* rows;
@property (readwrite, retain, nonatomic) NSString* title;
@property (readwrite, assign, nonatomic) int tab;
@property (readwrite, assign, nonatomic) GtObjectEditHandler* parentHandler;
	
- (void) addRow:(GtDisplayDataRow*) data;
	
- (GtDisplayDataRow*) rowAtIndex:(NSUInteger) index;
- (GtDisplayDataRow*) rowForRowId:(id) rowId;
- (NSUInteger) indexForRow:(GtDisplayDataRow*) row; // returns NSNotFound if not there
- (NSUInteger) indexForRowId:(id) inRowId; // returns NSNotFound if not there
- (NSUInteger) indexForCell:(UITableViewCell *)cell; // returns NSNotFound if not there
- (NSUInteger) rowCount;

- (BOOL) hasEditableRows;
- (GtDisplayDataRow*) nextEditableRow:(NSUInteger) index;
- (NSUInteger) editableRowCount;

- (void) releaseCachedCells;

- (GtTextEditCell*) findNextCellToEdit:(GtTextEditCell*) cell;
- (GtTextEditCell*) findPrevCellToEdit:(GtTextEditCell*) cell;

@end

#endif