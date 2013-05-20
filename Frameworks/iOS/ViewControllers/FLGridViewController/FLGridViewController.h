//
//  FLGridViewController.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 12/17/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLScrollViewController.h"
#import "FLGridCell.h"
#import "FLOrderedCollection.h"
#import "FLVisibleGridCellCollection.h"
#import "FLObjectCache.h"
#import "FLGridViewObject.h"
#import "FLGridViewControllerDataSource.h"
#import "FLDataRef.h"

@class FLArrangement;

@interface FLGridViewController : FLScrollViewController<FLVisibleGridCellCollectionDelegate> {
@private    
    struct {
        unsigned int showingLastCell: 1;
        unsigned int allowMultipleSelections: 1;
    } _gridViewControllerFlags;
    
    UILabel* _scrollIndicatorView;
    FLOrderedCollection* _cellCollection;
    id<FLVisibleGridCellCollection> _visibleCellCollection;
    FLObjectCache* _objectCache;
    id _dataProvider;
    FLArrangement* _arrangement;
    NSMutableArray* _selectedObjectIds;
}

@property (readwrite, assign, nonatomic) BOOL allowMultipleSelections;

@property (readwrite, retain, nonatomic) FLObjectCache* objectCache; // views and other stuff is stored in here.

@property (readwrite, retain, nonatomic) id dataModel; 

@property (readwrite, retain, nonatomic) FLArrangement* arrangement; // how to layout this grid view

// cells contain dataRefs

@property (readonly, retain, nonatomic) FLOrderedCollection* cellCollection; // cells are stored by index or dataRefKey

- (FLGridCell*) cellForDataRefKey:(id) dataRefKey;

- (void) removeCell:(FLGridCell*) cell;
- (void) removeAllCells;

// selecting cells
@property (readonly, retain, nonatomic) NSArray* selectedCells;

- (void) selectCell:(FLGridCell*) cell;
- (void) unselectCell:(FLGridCell*) cell;
- (void) unselectAllCells;

- (BOOL) isCellSelected:(FLGridCell*) cell;

// optional overrides
- (void) cellWasSelected:(FLGridCell*) cell;
- (void) cellWasUnselected:(FLGridCell*) cell;

- (void) presentViewControllerForSelectedCell:(FLGridCell *)cell;
- (UIViewController*) createViewControllerForSelectedCell:(FLGridCell *)cell;

- (id<FLViewControllerTransitionAnimation>) createOpenAnimationForCell:(FLGridCell *)cell;

- (id) dataModelForCell:(FLGridCell *)cell;

// TODO: Maybe. These would be potentially expensive to implement.
//- (void) gridViewCellWasAdded:((FLGridCell*) cell;
//- (void) gridViewCellWillBeRemoved:(FLGridCell*) cell;

// scrolling
- (void) scrollToCell:(FLGridCell*) cell    
             animated:(BOOL) animated;

// visible rect in scrollView
- (CGRect) visibleBounds;

// visible cells
@property (readonly, retain, nonatomic) id<FLVisibleGridCellCollection> visibleCellCollection;
- (void) updateVisibleCells:(CGRect) visibleBounds;
- (void) lastCellIsVisible;
- (void) visibleCellsChanged;
- (void) unloadVisibleCells;

// layout
- (void) reflowCellsInBounds:(CGRect) bounds;
- (void) reflowCells; 


// cell construction
- (UIView*) gridViewSuperview; // self.scrollView is default

// optional override

- (FLGridCell*) createGridViewCellForObject:(id) object; // by default this calls [object createGridViewCell]


// batch data management
// these will probably be called by data providers, etc..

// if object with same id's are already in grid, cell state will be preserved.
// objects NOT in item array will be removed from Cell collection.
- (void) mergeCellDataRefs:(NSArray*) dataRefArray; 

- (void) replaceCellDataRefs:(NSArray*) dataRefArray;

// if object with same id's are already in grid, cell state will be preserved. 
// objects with matching ids are updated cells, objects NOT in dataRefArray will be
// left in the collection
- (void) addOrReplaceCellDataRefs:(NSArray*) dataRefArray; 

- (void) addOrReplaceCellDataRef:(id) dataRef;


@end

