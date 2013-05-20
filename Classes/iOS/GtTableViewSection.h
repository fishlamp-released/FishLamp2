//
//	GtTableViewSection.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/6/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtEditObjectTableViewCell.h"
#import "GtOrderedCollection.h"

@class GtTableViewTab;
@class GtTextEditCell;
#import "GtTableViewHeaderView.h"

@interface GtTableViewSection : NSObject {
@private
	GtOrderedCollection* m_cells;
	NSString* m_title;
	GtTableViewTab* m_parent;
	GtTableViewHeaderView* m_headerView;
	CGFloat m_headerHeight;
	CGFloat m_footerHeight;
}

// display items
@property (readonly, retain, nonatomic) GtOrderedCollection* cells;
@property (readwrite, retain, nonatomic) NSString* title;
@property (readwrite, assign, nonatomic) GtTableViewTab* parentTab;
@property (readwrite, assign, nonatomic) CGFloat headerHeight;	 
@property (readwrite, assign, nonatomic) CGFloat footerHeight;	 //TODO: support this
@property (readonly, retain, nonatomic) GtTableViewHeaderView* headerView;

- (void) removeCell:(GtEditObjectTableViewCell*) cell;
- (void) addCell:(GtEditObjectTableViewCell*) data;
	
- (GtEditObjectTableViewCell*) cellAtIndex:(NSUInteger) idx;
- (GtEditObjectTableViewCell*) cellForKey:(id) key;

- (NSUInteger) indexForCell:(GtEditObjectTableViewCell*) cell; // returns NSNotFound if not there
- (NSUInteger) indexForCellKey:(id) inCellId; // returns NSNotFound if not there
- (NSUInteger) cellCount;

- (GtTextEditCell*) findNextCellToEdit:(GtTextEditCell*) cell;
- (GtTextEditCell*) findPrevCellToEdit:(GtTextEditCell*) cell;

@end

