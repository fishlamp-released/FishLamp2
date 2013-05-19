//
//	FLTableViewSection.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/6/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLEditObjectTableViewCell.h"
#import "FLOrderedCollection.h"

@class FLTableViewTab;
@class FLTextEditCell;
#import "FLTableViewHeaderView.h"

@interface FLTableViewSection : NSObject {
@private
	FLOrderedCollection* _cells;
	NSString* _title;
	__unsafe_unretained FLTableViewTab* _parent;
	FLTableViewHeaderView* _headerView;
	CGFloat _headerHeight;
	CGFloat _footerHeight;
}

// display items
@property (readonly, retain, nonatomic) FLOrderedCollection* cells;
@property (readwrite, retain, nonatomic) NSString* title;
@property (readwrite, assign, nonatomic) FLTableViewTab* parentTab;
@property (readwrite, assign, nonatomic) CGFloat headerHeight;	 
@property (readwrite, assign, nonatomic) CGFloat footerHeight;	 //TODO: support this
@property (readonly, retain, nonatomic) FLTableViewHeaderView* headerView;

- (void) removeCell:(FLEditObjectTableViewCell*) cell;
- (void) addCell:(FLEditObjectTableViewCell*) data;
	
- (FLEditObjectTableViewCell*) cellAtIndex:(NSUInteger) idx;
- (FLEditObjectTableViewCell*) cellForKey:(id) key;

- (NSUInteger) indexForCell:(FLEditObjectTableViewCell*) cell; // returns NSNotFound if not there
- (NSUInteger) indexForCellKey:(id) inCellId; // returns NSNotFound if not there
- (NSUInteger) cellCount;

- (FLTextEditCell*) findNextCellToEdit:(FLTextEditCell*) cell;
- (FLTextEditCell*) findPrevCellToEdit:(FLTextEditCell*) cell;

@end

