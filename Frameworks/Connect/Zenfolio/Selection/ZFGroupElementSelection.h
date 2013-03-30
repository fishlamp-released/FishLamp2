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

@protocol ZFZenfolioGroupElementSelectionDelegate;
@protocol ZFGroupElementSelectionDataSource;

@interface ZFGroupElementSelection : NSObject {
@private
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
    __unsafe_unretained id<ZFGroupElementSelectionDataSource> _dataSource;
}

@property (readwrite, assign, nonatomic) id<ZFZenfolioGroupElementSelectionDelegate> delegate;
@property (readwrite, assign, nonatomic) id<ZFGroupElementSelectionDataSource> dataSource;

/// selection
@property (readonly, assign, nonatomic) NSUInteger selectionCount;
@property (readonly, strong, nonatomic) NSSet* selectedPhotoSetIDs; 
@property (readonly, assign, nonatomic) NSUInteger selectedPhotoSetCount;

+ (id) groupElementSelection;

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
- (id) childElementForGroup:(ZFGroup*) parent atIndex:(NSUInteger) index;
- (NSUInteger) childCountForGroup:(ZFGroup*) element;

/// selection by indexes

/// gets/sets selection by index for outline view
@property (readwrite, strong, nonatomic) NSIndexSet* selectedIndexSet;


@end

@protocol ZFGroupElementSelectionDataSource <NSObject>
- (ZFGroup*) groupElementSelectionGetRootGroup:(ZFGroupElementSelection*) selection;
- (id<FLObjectStorage>) groupElementSelectionGetObjectStorage:(ZFGroupElementSelection*) selection;
@end

@protocol ZFZenfolioGroupElementSelectionDelegate <NSObject>
- (void) groupElementSelection:(ZFGroupElementSelection*) selection 
            setElementExpanded:(ZFGroup*) group 
                    isExpanded:(BOOL) isExpanded;
                   
                   
@end

//@interface ZFGroupElementSelectionForOutlineView : ZFGroupElementSelection 
//@end

