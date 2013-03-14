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

@protocol ZFZenfolioGroupElementSelectionDelegate;

@interface FLZenfolioGroupElementSelection : NSObject {
@private
    FLZenfolioGroup* _rootGroup;

// these only hold object ids
    NSMutableSet* _filtered;
    NSMutableSet* _expanded;
    NSMutableSet* _selected;

    NSString* _filterString;

// cached
    NSMutableArray* _selectedPhotoSets;

// all elements, flattened.
    FLOrderedCollection* _elements;

// indexable list for outline view
    NSMutableArray* _displayList;

// cached selection
    NSMutableIndexSet* _cachedIndexSet;

    __unsafe_unretained id<ZFZenfolioGroupElementSelectionDelegate> _delegate;
}


- (id) initWithRootGroup:(FLZenfolioGroup*) rootGroup;
+ (id) groupElementSelection:(FLZenfolioGroup*) rootGroup;

@property (readonly, strong, nonatomic) FLZenfolioGroup* rootGroup;
@property (readwrite, assign, nonatomic) id<ZFZenfolioGroupElementSelectionDelegate> delegate;

/// selection
//@property (readonly, strong, nonatomic) NSSet* selected;
@property (readonly, assign, nonatomic) NSUInteger selectionCount;
@property (readonly, strong, nonatomic) NSArray* selectedPhotoSets;
- (int) selectedPhotoCount;

/// select/unselect a groupElement
- (void) selectGroupElement:(FLZenfolioGroupElement*) groupElement 
                   selected:(BOOL) selected;

- (BOOL) isGroupElementSelected:(FLZenfolioGroupElement*) element;

- (void) toggleSelectionForGroupElement:(FLZenfolioGroupElement*) element;


/// filtering
- (void) updateFilterWithString:(NSString*) string;

/// expansion
- (void) setAllExpanded:(BOOL) expanded;
- (BOOL) elementIsExpanded:(id) item;
- (BOOL) expandElement:(id) element expanded:(BOOL) expanded ;
- (void) updateExpansions;
- (void) setElementWasExpanded:(id) element wasExpanded:(BOOL) wasExpanded;

/// sorting
- (void) sortWithDescriptor:(NSSortDescriptor*) descriptor;

/// misc utils
- (void) replaceGroupElement:(id) element atIndex:(NSUInteger) index;

/// indexed operations
- (id) childElementForGroup:(FLZenfolioGroup*) parent atIndex:(NSUInteger) index;
- (NSUInteger) childCountForGroup:(FLZenfolioGroup*) element;

/// selection by indexes

    // get/set selection with dictionary of indexes.
    // this is weird, since we're essentially a tree, but we need it to work
    // with the NSOutlineView
@property (readwrite, strong, nonatomic) NSIndexSet* selectedIndexSet;

- (id) elementForID:(id) idObject;

@end

@protocol ZFZenfolioGroupElementSelectionDelegate <NSObject>
- (void) groupElementSelection:(FLZenfolioGroupElementSelection*) selection 
            setElementExpanded:(FLZenfolioGroup*) group 
                    isExpanded:(BOOL) isExpanded;
                   
                   
@end