//
//  GtObjectEditHandler.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/10/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import "GtDisplayDataRow.h"
#import "GtDisplayDataGroup.h"

#define GtNumEditHandlerTabs 5

@interface GtObjectEditHandler : NSObject {
@private
	NSMutableArray* m_groups[GtNumEditHandlerTabs];
	NSUInteger m_tab;
}

@property (readwrite, assign, nonatomic) NSUInteger tab;

// groups
- (void) addGroup:(GtDisplayDataGroup*) group;
- (void) addGroup:(GtDisplayDataGroup*) group tab:(int) tab;

- (NSUInteger) groupCount;

- (GtDisplayDataGroup*) groupAtIndex:(NSUInteger) index;

- (GtDisplayDataGroup*) lastGroup;

- (GtDisplayDataRow*) rowForPath:(NSIndexPath *)indexPath;
- (GtDisplayDataRow*) rowForRowId:(id) rowId;

- (NSIndexPath*) indexPathForRowId:(id) rowId;
- (NSIndexPath*) indexPathForRowInCurrentTab:(GtDisplayDataRow*) row;

- (BOOL) hasEditableRows;

- (void) releaseCachedCells;

- (UITableViewCell*) cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath*) indexPathForCell:(UITableViewCell *)cell;

@end
