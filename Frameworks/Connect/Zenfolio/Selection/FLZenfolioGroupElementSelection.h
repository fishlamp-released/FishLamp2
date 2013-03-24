//
//  FLZenfolioGroupElementSelection.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 2/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FishLampCocoaUI.h"
#import "FLZenfolioGroupElement.h"
#import "FLOrderedCollection.h"
#import "FLObjectStorage.h"

@protocol ZFZenfolioGroupElementSelectionDelegate;

@interface FLZenfolioGroupElementSelection : NSObject {
@private
    id<FLObjectStorage> _objectStorage;

// the group holds the layout of galleries - it should not hold
// the latest photoSets - that's what the objectStorage is for 
// (and the _elements collection)
    FLZenfolioGroup* _rootGroup;

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

    __unsafe_unretained id<ZFZenfolioGroupElementSelectionDelegate> _delegate;
}


@property (readonly, strong, nonatomic) id<FLObjectStorage> objectStorage;

@property (readwrite, strong, nonatomic) FLZenfolioGroup* rootGroup;
@property (readwrite, assign, nonatomic) id<ZFZenfolioGroupElementSelectionDelegate> delegate;

/// selection
@property (readonly, assign, nonatomic) NSUInteger selectionCount;
@property (readonly, strong, nonatomic) NSSet* selectedPhotoSetIDs; 
@property (readonly, assign, nonatomic) NSUInteger selectedPhotoSetCount;

- (id) initWithObjectStorage:(id<FLObjectStorage>) objectStorage;
+ (id) groupElementSelection:(id<FLObjectStorage>) objectStorage;

- (id) elementForID:(NSNumber*) idObject;

/// filtering
// this changes displayList and selectionContainers.
@property (readwrite, strong, nonatomic) NSString* filterString;

/// expansion
- (void) setAllExpanded:(BOOL) expanded;
- (BOOL) elementIsExpanded:(id) item;
- (BOOL) expandElement:(id) element expanded:(BOOL) expanded ;
- (void) updateExpansions;
- (void) setElementWasExpanded:(id) element wasExpanded:(BOOL) wasExpanded;

/// sorting
- (void) sortWithDescriptor:(NSSortDescriptor*) descriptor;

/// misc utils
- (void) replaceGroupElement:(id) element;

/// indexed operations
- (id) childElementForGroup:(FLZenfolioGroup*) parent atIndex:(NSUInteger) index;
- (NSUInteger) childCountForGroup:(FLZenfolioGroup*) element;

/// selection by indexes

/// gets/sets selection by index for outline view
@property (readwrite, strong, nonatomic) NSIndexSet* selectedIndexSet;


@end

@protocol ZFZenfolioGroupElementSelectionDelegate <NSObject>
- (void) groupElementSelection:(FLZenfolioGroupElementSelection*) selection 
            setElementExpanded:(FLZenfolioGroup*) group 
                    isExpanded:(BOOL) isExpanded;
                   
                   
@end

//@interface FLZenfolioGroupElementSelectionForOutlineView : FLZenfolioGroupElementSelection 
//@end

