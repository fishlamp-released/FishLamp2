//
//	FLTilingScrollView.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/22/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLTouchableScrollView.h"

@class FLTouch;
@class FLScrollSnapshot;

#define FLTilingScrollViewPageMargin 10 

typedef enum
{
	FLTilingScrollViewSlideDirectionLeft = 0,
	FLTilingScrollViewSlideDirectionRight = 1
} FLTilingScrollViewSlideDirection;

@protocol FLTilingScrollViewDelegate;
@protocol FLTilingScrollViewDataSource;

@interface FLTilingScrollView : FLTouchableScrollView<UIScrollViewDelegate, FLTouchableScrollViewDelegate> {
@private
	NSMutableArray* _tiledViews;
	NSMutableArray* _scrollQueue;
	FLScrollSnapshot* _currentScroll;
	__unsafe_unretained id _tilingScrollViewDelegate;
	
	NSUInteger _tileCount;
	NSUInteger _centerViewIndex;
	
	struct {
		unsigned int autoRotate:1; 
		unsigned int scrollInProgress:1;
		unsigned int isAutoRotating:1;
		unsigned int disableScroll:1;
		unsigned int canScrollTiles:1;
		FLTilingScrollViewSlideDirection lastScrollDirection:1;
	} _tilingScrollViewFlags;

	NSInteger _touchCount;
	SEL _animationDoneSelector;
}

// datasource and delegate
@property (readwrite, assign, nonatomic) id<FLTilingScrollViewDelegate> tilingScrollViewDelegate;

// properties
@property (readwrite, assign, nonatomic) BOOL autoRotate;
@property (readwrite, assign, nonatomic) BOOL canScrollTiles;

// creation/info
- (void) createTiles:(NSUInteger) tileCount;
@property (readonly, assign, nonatomic) NSUInteger tiledViewCount;

// tiled views

@property (readonly, assign, nonatomic) NSUInteger centerViewIndex;

@property (readonly, assign, nonatomic) NSUInteger firstNextViewIndex;
@property (readonly, assign, nonatomic) NSUInteger lastNextViewIndex;
@property (readonly, assign, nonatomic) NSUInteger nextTiledViewCount;

@property (readonly, assign, nonatomic) NSUInteger lastPreviousViewIndex;
@property (readonly, assign, nonatomic) NSUInteger firstPreviousViewIndex;
@property (readonly, assign, nonatomic) NSUInteger previousTiledViewCount;

@property (readonly, assign, nonatomic) FLTilingScrollViewSlideDirection lastScrollDirection;

@property (readonly, retain, nonatomic) UIView* centerView;

- (void) setTiledView:(UIView*) view atIndex:(NSUInteger) idx;
- (UIView*) tiledViewAtIndex:(NSUInteger) idx;
- (NSInteger) indexForTiledView:(UIView*) view;

// remove a view, then add a new view on the end of the tiling.
- (void) removeTiledViewAtIndex:(NSUInteger) which;
- (BOOL) removeTiledView:(id) view;

// rect utils
- (FLRect) scrollViewPageRectForViewAtIndex:(NSInteger) idx;

// arrangemennt
- (void) shiftArrangementToLeft;
- (void) shiftArrangementToRight;
- (void) updateTiledArrangement;

- (void) resetAllViews;

@end

@interface FLTilingScrollView (Rotate)
// these need to be called from view controller.
- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation;
@end

@protocol FLTilingScrollViewDelegate <NSObject>

- (void) tilingScrollView:(FLTilingScrollView*) tilingScrollView 
	createTiledView:(UIView**) outView;

- (void) tilingScrollView:(FLTilingScrollView*) tilingScrollView 
	releaseMemoryForView:(UIView*) view
	atIndex:(NSInteger) idx;

@optional
- (void) tilingScrollView:(FLTilingScrollView*) tilingScrollView 
	willTileViews:(FLTilingScrollViewSlideDirection) slideDirection;

- (void) tilingScrollView:(FLTilingScrollView*) tilingScrollView 
	didTileViews:(FLTilingScrollViewSlideDirection) slideDirection;

- (void) tilingScrollViewWillRotate:(FLTilingScrollView*) tilingScrollView;

- (void) tilingScrollViewDidRotate:(FLTilingScrollView*) tilingScrollView;

- (void) tilingScrollViewDidFinishDragAnimation:(FLTilingScrollView*) tilingScrollView;

- (void) tilingScrollView:(FLTilingScrollView*) tilingScrollView 
	willRemoveView:(UIView*) view;

	
@end

