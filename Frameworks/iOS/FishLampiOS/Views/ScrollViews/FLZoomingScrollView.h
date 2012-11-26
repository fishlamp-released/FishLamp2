//
//	FLZoomingScrollView.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/26/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLTouchableScrollView.h"

#define FLZoomingScrollViewDefaultDoubleTapZoomScale 2.0
#define FLZoomingScrollViewDefaultMaxZoomScale 3.0

@protocol FLZoomingScrollViewDelegate;

@interface FLZoomingScrollView : UIScrollView<UIScrollViewDelegate> {
@private
	UIView* _zoomedView;
	UITouch* _lastTouch;
	
	__unsafe_unretained id<FLZoomingScrollViewDelegate> _zoomingScrollViewDelegate;
	__unsafe_unretained id<FLTouchableScrollViewDelegate> _touchableScrollViewDelegate;
	
	CGFloat _zoomScale;
	CGFloat _inZoomRelativeScale;
	CGFloat _initialDistance;
	CGFloat _maxZoomScale;
	CGFloat _doubleTapZoomScale;
	
	FLPoint _zoomOutDelta;
	CGFloat _zoomOutScale;
	
	FLRect _startFrame;
	
	struct {
		unsigned int animating:1;
		unsigned int canZoomView:1;
		unsigned int cancelSingleTap:1;
		unsigned int doCoast:1;
		unsigned int atRightEdge:1;
		unsigned int atLeftEdge:1;
		unsigned int inEdgedScrollingMode:1;
		unsigned int isZooming:1;
		unsigned int didEndZooming:1;
	} _zoomingScrollViewFlags;
	
	FLPoint _totalDelta;
	NSInteger _touchCount;
	NSTimeInterval _lastSingleTap;
	NSTimeInterval _firstTapTimeStamp;
	
	NSMutableArray* _touches;
}

// note: setting/getting values related to zooming in superclass are no-ops or
// return default values. Do not set those. Use the zoomingScrollView versions below.

// use these to set zooming sizes.
@property (readwrite, assign, nonatomic) id<FLTouchableScrollViewDelegate> touchableScrollViewDelegate;
@property (readwrite, assign, nonatomic) id<FLZoomingScrollViewDelegate> zoomingScrollViewDelegate;

@property (readwrite, assign, nonatomic) CGFloat zoomingScrollViewMaximumZoomScale;
@property (readwrite, assign, nonatomic) CGFloat zoomingScrollViewDoubleTapZoomScale;

@property (readonly, assign, nonatomic) CGFloat zoomingScrollViewZoomScale;
@property (readonly, assign, nonatomic) BOOL isZoomingScrollViewZooming;

@property (readwrite, retain, nonatomic) UIView* zoomedView;

- (void) setZoomingScrollViewZoomScale:(float) scale animated:(BOOL) animated;
- (void) setZoomingScrollViewZoomScale:(float) scale translateToPoint:(FLPoint) point animated:(BOOL) animated;

- (void) stopZooming:(BOOL) animated 
	target:(id) target 
	action:(SEL) action; // callback fired when zoom out is completed.

@end

@protocol FLZoomingScrollViewDelegate <NSObject>
- (void) zoomingScrollView:(FLZoomingScrollView*) zoomingScrollView isClosePinching:(CGFloat) zoomScale;
- (void) zoomingScrollViewShouldCloseView:(FLZoomingScrollView*) zoomingScrollView;
- (BOOL) zoomingScrollView:(FLZoomingScrollView*) zoomingScrollView canZoomView:(id) view;
- (void) zoomingScrollView:(FLZoomingScrollView*) zoomingScrollView zoomScaleForViewChanged:(id) view zoomScale:(CGFloat) zoomScale;
- (void) zoomingScrollView:(FLZoomingScrollView*) zoomingScrollView zoomingDidStartForView:(id) view;
- (void) zoomingScrollView:(FLZoomingScrollView*) zoomingScrollView zoomingDidStopForView:(id) view;
- (void) zoomingScrollView:(FLZoomingScrollView*) zoomingScrollView userTappedView:(id) view withTouch:(UITouch*) touch;
@end
