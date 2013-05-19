//
//	FLTableViewTab.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/10/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLOrderedCollection.h"

@class FLTableViewLayout;
@class FLEditObjectTableViewCell;
@class FLTableViewSection;

@interface FLTableViewTab : NSObject {
@private
	FLOrderedCollection* _sections;
	__unsafe_unretained FLTableViewLayout* _parentLayout;
}

@property (readwrite, assign, nonatomic) FLTableViewLayout* parentLayout;
@property (readonly, retain, nonatomic) FLOrderedCollection* sections;

// sections
- (void) addSection:(FLTableViewSection*) section forKey:(id) key;
- (void) removeSectionForKey:(id) key;

- (FLTableViewSection*) sectionForKey:(id) rowKey;
- (FLEditObjectTableViewCell*) rowForRowKey:(id) rowKey;

- (NSUInteger) sectionCount;

- (FLTableViewSection*) sectionAtIndex:(NSUInteger) idx;
- (FLTableViewSection*) lastSection;

- (FLEditObjectTableViewCell*) cellForIndexPath:(NSIndexPath*) path;

- (NSIndexPath*) indexPathForCell:(FLEditObjectTableViewCell *)cell;
//- (BOOL) hasEditableRows;

@end


