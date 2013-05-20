//
//	GtZoomingScrollView.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/26/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtTouchableScrollView.h"

#define GtZoomingScrollViewDefaultDoubleTapZoomScale 2.0
#define GtZoomingScrollViewDefaultMaxZoomScale 3.0

@protocol GtZoomingScrollViewDelegate;

@interface GtZoomingScrollView : UIScrollView<UIScrollViewDelegate> {
@private
	UIView* m_zoomedView;
	UITouch* m_lastTouch;
	
	id<GtZoomingScrollViewDelegate> m_zoomingScrollViewDelegate;
	id<GtTouchableScrollViewDelegate> m_touchableScrollViewDelegate;
	
	CGFloat m_zoomScale;
	CGFloat m_inZoomRelativeScale;
	CGFloat m_initialDistance;
	CGFloat m_maxZoomScale;
	CGFloat m_doubleTapZoomScale;
	
	CGPoint m_zoomOutDelta;
	CGFloat m_zoomOutScale;
	
	CGRect m_startFrame;
	
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
	} m_zoomingScrollViewFlags;
	
	CGPoint m_totalDelta;
	NSInteger m_touchCount;
	NSTimeInterval m_lastSingleTap;
	NSTimeInterval m_firstTapTimeStamp;
	
	NSMutableArray* m_touches;
}

// note: setting/getting values related to zooming in superclass are no-ops or
// return default values. Do not set those. Use the zoomingScrollView versions below.

// use these to set zooming sizes.
@property (readwrite, assign, nonatomic) id<GtTouchableScrollViewDelegate> touchableScrollViewDelegate;
@property (readwrite, assign, nonatomic) id<GtZoomingScrollViewDelegate> zoomingScrollViewDelegate;

@property (readwrite, assign, nonatomic) CGFloat zoomingScrollViewMaximumZoomScale;
@property (readwrite, assign, nonatomic) CGFloat zoomingScrollViewDoubleTapZoomScale;

@property (readonly, assign, nonatomic) CGFloat zoomingScrollViewZoomScale;
@property (readonly, assign, nonatomic) BOOL isZoomingScrollViewZooming;

@property (readwrite, retain, nonatomic) UIView* zoomedView;

- (void) setZoomingScrollViewZoomScale:(float) scale animated:(BOOL) animated;
- (void) setZoomingScrollViewZoomScale:(float) scale translateToPoint:(CGPoint) point animated:(BOOL) animated;

- (void) stopZooming:(BOOL) animated 
	target:(id) target 
	action:(SEL) action; // callback fired when zoom out is completed.

@end

@protocol GtZoomingScrollViewDelegate <NSObject>
- (void) zoomingScrollView:(GtZoomingScrollView*) zoomingScrollView isClosePinching:(CGFloat) zoomScale;
- (void) zoomingScrollViewShouldCloseView:(GtZoomingScrollView*) zoomingScrollView;
- (BOOL) zoomingScrollView:(GtZoomingScrollView*) zoomingScrollView canZoomView:(id) view;
- (void) zoomingScrollView:(GtZoomingScrollView*) zoomingScrollView zoomScaleForViewChanged:(id) view zoomScale:(CGFloat) zoomScale;
- (void) zoomingScrollView:(GtZoomingScrollView*) zoomingScrollView zoomingDidStartForView:(id) view;
- (void) zoomingScrollView:(GtZoomingScrollView*) zoomingScrollView zoomingDidStopForView:(id) view;
- (void) zoomingScrollView:(GtZoomingScrollView*) zoomingScrollView userTappedView:(id) view withTouch:(UITouch*) touch;
@end
