//
//  GtGridViewController.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 12/17/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtScrollViewController.h"
#import "GtTouchableScrollView.h"
#import "GtGridViewCellController.h"
#import "GtOrderedCollection.h"
#import "GtVisibleGridViewCellCollection.h"
#import "GtObjectCache.h"
#import "GtGridViewCellCollection.h"

@class GtViewLayout;

@protocol GtGridViewObject <NSObject>
@property (readonly, retain, nonatomic) id gridViewObjectID;
@property (readonly, retain, nonatomic) NSString* gridViewDisplayName;
@end

@protocol GtGridViewCellFactory <NSObject>
- (GtGridViewCellController*) createGridViewCell;
- (id<GtGridViewCellSelectionHandler>) createGridViewSelectionHandler;
- (id<GtGridViewCellTouchHandler>)createGridViewTouchHandler;
@end

@protocol GtGridViewDataProvider <NSObject>

// TBD?

@end


@interface NSObject (GtGridViewObject)
- (BOOL) implementsGridViewObjectProtocol;
@end

#if DEBUG
#define GtAssertImplementsGridViewObjectProtocol(__o) GtAssert(__o == nil || [__o implementsGridViewObjectProtocol], @"%@ does not implement gridViewObject protocol", NSStringFromClass(__o))
#else
#define GtAssertImplementsGridViewObjectProtocol(__o)
#endif

@interface GtGridViewController : GtScrollViewController<GtTouchableScrollViewDelegate, GtVisibleGridViewCellCollectionDelegate> {
@private    
    GtOrderedCollection* m_cellCollection;
    id<GtVisibleGridViewCellCollection> m_visibleCellCollection;
    GtObjectCache* m_objectCache;
    id m_dataProvider;
    GtViewLayout* m_viewLayout;
    struct {
        unsigned int showingLastCell: 1;
    } m_gridViewControllerFlags;
    
    UILabel* m_scrollIndicatorView;
}

@property (readonly, retain, nonatomic) id<GtVisibleGridViewCellCollection> visibleCellCollection;
@property (readonly, retain, nonatomic) GtOrderedCollection* cellCollection;
@property (readwrite, retain, nonatomic) GtObjectCache* objectCache;
@property (readwrite, retain, nonatomic) id dataProvider;
@property (readwrite, retain, nonatomic) GtViewLayout* viewLayout;

- (void) scrollToGalleryItem:(id) item    
                    animated:(BOOL) animated;
                    

// optional override points
- (CGRect) visibleGridViewBounds;

- (void) lastCellIsVisible;
- (void) visibleCellsChanged;

- (void) unloadVisibleCells;
- (void) removeAllCells;

- (void) reflowCellsInBounds:(CGRect) bounds;
- (void) reflowCells; 

- (void) gridViewCellWasSelected:(GtGridViewCellController*) cell;

- (void) updateVisibleCells:(CGRect) visibleBounds;

@end

