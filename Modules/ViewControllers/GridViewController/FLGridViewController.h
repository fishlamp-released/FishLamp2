//
//  FLGridViewController.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 12/17/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLScrollViewController.h"
#import "FLGridViewCell.h"
#import "FLOrderedCollection.h"
#import "FLVisibleGridViewCellCollection.h"
#import "FLObjectCache.h"
#import "FLGridViewObject.h"
#import "FLGridViewControllerDataSource.h"

@class FLArrangement;

@interface FLGridViewController : FLScrollViewController<FLVisibleGridViewCellCollectionDelegate> {
@private    
    struct {
        unsigned int showingLastCell: 1;
        unsigned int allowMultipleSelections: 1;
    } _gridViewControllerFlags;
    
    UILabel* _scrollIndicatorView;
    FLOrderedCollection* _cellCollection;
    id<FLVisibleGridViewCellCollection> _visibleCellCollection;
    FLObjectCache* _objectCache;
    id _dataProvider;
    FLArrangement* _arrangement;
    NSMutableArray* _selectedObjectIds;
}

@property (readwrite, assign, nonatomic) BOOL allowMultipleSelections;

@property (readwrite, retain, nonatomic) FLObjectCache* objectCache; // views and other stuff is stored in here.

@property (readwrite, retain, nonatomic) id dataSource; // the abstraction for fetching data (data model)

@property (readwrite, retain, nonatomic) FLArrangement* cellArrangement; // how to layout this grid view

// cells have gridViewObject and all gridViewObjects have a gridViewObjectId

@property (readonly, retain, nonatomic) FLOrderedCollection* cellCollection; // cells are stored by index or gridViewObjectId

// convert between cells, objects, and objectIds
- (FLGridViewCell*) cellForObject:(id) object;
- (FLGridViewCell*) cellForObjectId:(id) objectId;
- (id) objectIdFromCell:(FLGridViewCell*) cell;
- (id) objectFromCell:(FLGridViewCell*) cell;

- (void) removeCell:(FLGridViewCell*) cell;
- (void) removeAllCells;

// selecting cells
@property (readonly, retain, nonatomic) NSArray* selectedCells;

- (void) selectCell:(FLGridViewCell*) cell;
- (void) unselectCell:(FLGridViewCell*) cell;
- (void) unselectAllCells;

- (BOOL) isCellSelected:(FLGridViewCell*) cell;

// optional overrides
- (void) cellWasSelected:(FLGridViewCell*) cell;
- (void) cellWasUnselected:(FLGridViewCell*) cell;

- (void) showViewControllerForCell:(FLGridViewCell *)cell;
- (UIViewController*) createViewControllerForOpeningCell:(FLGridViewCell *)cell;
- (id<FLViewControllerTransitionAnimation>) createOpenAnimationForCell:(FLGridViewCell *)cell;
- (id) dataSourceForCell:(FLGridViewCell *)cell;

// TODO: Maybe. These would be potentially expensive to implement.
//- (void) gridViewCellWasAdded:((FLGridViewCell*) cell;
//- (void) gridViewCellWillBeRemoved:(FLGridViewCell*) cell;

// scrolling
- (void) scrollToCell:(FLGridViewCell*) cell    
             animated:(BOOL) animated;

// visible rect in scrollView
- (CGRect) visibleBounds;

// visible cells
@property (readonly, retain, nonatomic) id<FLVisibleGridViewCellCollection> visibleCellCollection;
- (void) updateVisibleCells:(CGRect) visibleBounds;
- (void) lastCellIsVisible;
- (void) visibleCellsChanged;
- (void) unloadVisibleCells;

// layout
- (void) reflowCellsInBounds:(CGRect) bounds;
- (void) reflowCells; 


// cell construction

// optional override

- (FLGridViewCell*) createGridViewCellForObject:(id) object; // by default this calls [object createGridViewCell]


// batch data management
// these will probably be called by data providers, etc..

// if object with same id's are already in grid, cell state will be preserved.
// objects NOT in item array will be removed from Cell collection.
- (void) mergeGridViewObjects:(NSArray*) itemArray; 

- (void) replaceGridViewObjects:(NSArray*) itemArray;

// if object with same id's are already in grid, cell state will be preserved. 
// objects with matching ids are updated cells, objects NOT in itemArray will be
// left in the collection
- (void) addOrReplaceGridViewObjects:(NSArray*) itemArray; 

- (void) addOrReplaceGridViewObject:(id) object;


@end

