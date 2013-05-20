//
//	GtMultiColumnTableViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/5/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtTableViewController.h"
#import "GtMultiColumnTableViewCell.h"

@interface GtMultiColumnTableViewController : GtTableViewController {
@private
	NSUInteger m_maxLandscapeColumns;
	NSUInteger m_maxPortaitColumns;
	NSUInteger m_visibleColumnCount;
	NSUInteger m_numberOfDataItems;
	NSUInteger m_rowCount;
	BOOL m_isLandscapeOriented;
}

@property (readwrite, assign, nonatomic) NSUInteger maxLandscapeColumns;
@property (readwrite, assign, nonatomic) NSUInteger maxPortaitColumns;
@property (readonly, assign, nonatomic) NSUInteger visibleColumnCount;

- (NSUInteger) rowNumberForDataItemIndex:(NSUInteger) dataItemIndex;

- (void) updateLayout:(BOOL) toLandscapeOrientation;

- (NSUInteger) numberOfDataItems; // TODO: this should probably be in the dataSource?

- (void) updateTableLayoutWithCurrentOrientation;

- (void) updateWidget:(GtWidget*) widget forDataItemIndex:(NSUInteger) itemIndex;
- (GtWidget*) createWidgetForColumn:(NSUInteger) columnNumber;

- (void) didCreateNewTableCell:(GtMultiColumnTableViewCell*) cell;

@end
