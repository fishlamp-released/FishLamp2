//
//	GtTilingScrollView.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/22/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtTouchableScrollView.h"

@class GtTouch;
@class GtScrollSnapshot;

#define GtTilingScrollViewPageMargin 10 

typedef enum
{
	GtTilingScrollViewSlideDirectionLeft = 0,
	GtTilingScrollViewSlideDirectionRight = 1
} GtTilingScrollViewSlideDirection;

@protocol GtTilingScrollViewDelegate;
@protocol GtTilingScrollViewDataSource;

@interface GtTilingScrollView : GtTouchableScrollView<UIScrollViewDelegate, GtTouchableScrollViewDelegate> {
@private
	NSMutableArray* m_tiledViews;
	NSMutableArray* m_scrollQueue;
	GtScrollSnapshot* m_currentScroll;
	id m_tilingScrollViewDelegate;
	
	NSUInteger m_tileCount;
	NSUInteger m_centerViewIndex;
	
	struct {
		unsigned int autoRotate:1; 
		unsigned int scrollInProgress:1;
		unsigned int isAutoRotating:1;
		unsigned int disableScroll:1;
		unsigned int canScrollTiles:1;
		GtTilingScrollViewSlideDirection lastScrollDirection:1;
	} m_tilingScrollViewFlags;

	NSInteger m_touchCount;
	SEL m_animationDoneSelector;
}

// datasource and delegate
@property (readwrite, assign, nonatomic) id<GtTilingScrollViewDelegate> tilingScrollViewDelegate;

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

@property (readonly, assign, nonatomic) GtTilingScrollViewSlideDirection lastScrollDirection;

@property (readonly, retain, nonatomic) UIView* centerView;

- (void) setTiledView:(UIView*) view atIndex:(NSUInteger) idx;
- (UIView*) tiledViewAtIndex:(NSUInteger) idx;
- (NSInteger) indexForTiledView:(UIView*) view;

// remove a view, then add a new view on the end of the tiling.
- (void) removeTiledViewAtIndex:(NSUInteger) which;
- (BOOL) removeTiledView:(id) view;

// rect utils
- (CGRect) scrollViewPageRectForViewAtIndex:(NSInteger) idx;

// arrangemennt
- (void) shiftArrangementToLeft;
- (void) shiftArrangementToRight;
- (void) updateTiledViewLayout;

- (void) resetAllViews;

@end

@interface GtTilingScrollView (Rotate)
// these need to be called from view controller.
- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation;
@end

@protocol GtTilingScrollViewDelegate <NSObject>

- (void) tilingScrollView:(GtTilingScrollView*) tilingScrollView 
	createTiledView:(UIView**) outView;

- (void) tilingScrollView:(GtTilingScrollView*) tilingScrollView 
	releaseMemoryForView:(UIView*) view
	atIndex:(NSInteger) idx;

@optional
- (void) tilingScrollView:(GtTilingScrollView*) tilingScrollView 
	willTileViews:(GtTilingScrollViewSlideDirection) slideDirection;

- (void) tilingScrollView:(GtTilingScrollView*) tilingScrollView 
	didTileViews:(GtTilingScrollViewSlideDirection) slideDirection;

- (void) tilingScrollViewWillRotate:(GtTilingScrollView*) tilingScrollView;

- (void) tilingScrollViewDidRotate:(GtTilingScrollView*) tilingScrollView;

- (void) tilingScrollViewDidFinishDragAnimation:(GtTilingScrollView*) tilingScrollView;

- (void) tilingScrollView:(GtTilingScrollView*) tilingScrollView 
	willRemoveView:(UIView*) view;

	
@end

