//
//	FLMultiColumnTableViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/5/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLTableViewController.h"
#import "FLMultiColumnTableViewCell.h"

@interface FLMultiColumnTableViewController : FLTableViewController {
@private
	NSUInteger _maxLandscapeColumns;
	NSUInteger _maxPortaitColumns;
	NSUInteger _visibleColumnCount;
	NSUInteger _numberOfDataItems;
	NSUInteger _rowCount;
	BOOL _isLandscapeOriented;
}

@property (readwrite, assign, nonatomic) NSUInteger maxLandscapeColumns;
@property (readwrite, assign, nonatomic) NSUInteger maxPortaitColumns;
@property (readonly, assign, nonatomic) NSUInteger visibleColumnCount;

- (NSUInteger) rowNumberForDataItemIndex:(NSUInteger) dataItemIndex;

- (void) updateLayout:(BOOL) toLandscapeOrientation;

- (NSUInteger) numberOfDataItems; // TODO: this should probably be in the dataSource?

- (void) updateTableLayoutWithCurrentOrientation;

- (void) updateWidget:(FLWidget*) widget forDataItemIndex:(NSUInteger) itemIndex;
- (FLWidget*) createWidgetForColumn:(NSUInteger) columnNumber;

- (void) didCreateNewTableCell:(FLMultiColumnTableViewCell*) cell;

@end
