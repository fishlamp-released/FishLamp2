//
//	GtTableViewTab.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/10/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtOrderedCollection.h"

@class GtTableViewLayout;
@class GtEditObjectTableViewCell;
@class GtTableViewSection;

@interface GtTableViewTab : NSObject {
@private
	GtOrderedCollection* m_sections;
	GtTableViewLayout* m_parentLayout;
}

@property (readwrite, assign, nonatomic) GtTableViewLayout* parentLayout;
@property (readonly, retain, nonatomic) GtOrderedCollection* sections;

// sections
- (void) addSection:(GtTableViewSection*) section forKey:(id) key;
- (void) removeSectionForKey:(id) key;

- (GtTableViewSection*) sectionForKey:(id) rowKey;
- (GtEditObjectTableViewCell*) rowForRowKey:(id) rowKey;

- (NSUInteger) sectionCount;

- (GtTableViewSection*) sectionAtIndex:(NSUInteger) idx;
- (GtTableViewSection*) lastSection;

- (GtEditObjectTableViewCell*) cellForIndexPath:(NSIndexPath*) path;

- (NSIndexPath*) indexPathForCell:(GtEditObjectTableViewCell *)cell;
//- (BOOL) hasEditableRows;

@end


