//
//  ZFGroupElementSelection.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 2/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FishLampCocoa.h"
#import "ZFGroupElement.h"
#import "FLOrderedCollection.h"
#import "FLObjectStorage.h"

@interface ZFGroupElementSelection : NSObject {
@private
    ZFGroup* _rootGroup;
    id<FLObjectStorage> _objectStorage;

// these only hold object ids
    NSMutableSet* _filtered;
    NSMutableSet* _expanded;
    NSMutableSet* _selected;
    NSMutableSet* _selectedPhotoSets;

    NSString* _filterString;

// all elements, flattened. Also essentially a cache of the group elements in memory
// this might need to be smarter. 
    FLOrderedCollection* _elements;

// indexable list for outline view
    NSMutableArray* _displayList;

// cached selection
    NSMutableIndexSet* _cachedSelectionIndexesForOutlineView;
}

@property (readwrite, strong, nonatomic) id<FLObjectStorage> objectStorage;
@property (readwrite, strong, nonatomic) ZFGroup* rootGroup;

/// filtering
// this changes displayList and selectionContainers.
@property (readwrite, strong, nonatomic) NSString* filterString;

/// selection
@property (readonly, assign, nonatomic) NSUInteger selectionCount;
@property (readonly, copy, nonatomic) NSSet* selectedPhotoSetIDs; 
@property (readonly, assign, nonatomic) NSUInteger selectedPhotoSetCount;

+ (id) groupElementSelection:(NSSet*) selectedPhotoSets;

- (id) elementForID:(NSNumber*) idObject;

/// expansion
- (void) setAllExpanded:(BOOL) expanded;
- (BOOL) elementIsExpanded:(id) item;

- (BOOL) expandElementWithID:(NSNumber*) elementID expanded:(BOOL) expanded;
- (BOOL) expandElement:(id) element expanded:(BOOL) expanded;
- (void) updateExpansions;
- (void) setElementWasExpanded:(id) element wasExpanded:(BOOL) wasExpanded;

/// sorting
- (void) sortWithDescriptor:(NSSortDescriptor*) descriptor;

/// misc utils
- (void) replaceGroupElement:(id) element;

/// indexed operations
- (id) childElementForGroup:(ZFGroup*) parent atIndex:(NSUInteger) index;
- (NSUInteger) childCountForGroup:(ZFGroup*) element;

/// selection by indexes

/// gets/sets selection by index for outline view
@property (readwrite, strong, nonatomic) NSIndexSet* selectedIndexSet;

- (void) resetAllButSelection;

// optional overrides

- (void) didExpandGroup:(ZFGroup*) group 
             isExpanded:(BOOL) isExpanded;

- (void) didReplaceElementAtIndex:(NSUInteger) index withElement:(id) element;

@end

