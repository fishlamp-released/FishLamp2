//
//	GtRectGeometry.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/22/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

#import "FishLampObjc.h"

#if DEBUG
#define GT_INLINE extern
#else
#define GT_INLINE NS_INLINE
#endif

#if GT_CHECK_RECT_SANITY
extern CGRect GtAssertIsSaneRect(CGRect r);
extern CGPoint GtAssertIsSanePoint(CGPoint p);
#define GtReturnAssertIsSaneRect GtAssertIsSanePoint
#define GtReturnAssertIsSanePoint GtAssertIsSanePoint 

#else
#define GtAssertIsSaneRect(__r__) 
#define GtAssertIsSanePoint(__r__) 
#define GtReturnAssertIsSaneRect(__r__) __r__
#define GtReturnAssertIsSanePoint(__r__) __r__ 

#endif




/* 
	Regarding GtRectOptimizeForSize

	There are two issues here:
	1.	you don't want your origin on a subpixel boundary, e.g. frame.origin.x = 10.5. You want it
		on integral bounderies, e.g. 10.0. Images and Text will render "fuzzy" if you do.
	2.	you don't want the center point of the view to be on a subpixel, which means the width an 
		height need to be evenly divisible by 2. Note that I opted to grow the frame by 1 pixel
		so that finely sized views aren't clipped (like text with decenders).
*/ 

GT_INLINE BOOL GtRectIsIntegral(CGRect r);
GT_INLINE BOOL GtRectIsOptimizedForView(CGRect r);
#define GtRectWidthIsOptimizedForView(r)	(r.size.width == 0	|| (fmodf(r.origin.x + r.size.width, 2.0f) == 0))
#define GtRectHeightIsOptimizedForView(r)	(r.size.height == 0 || (fmodf(r.origin.y + r.size.height, 2.0f) == 0))

#if DEBUG
#define GtWarnIfRectIsNotOptimizedForView(r) if(!GtRectIsOptimizedForView(r)) GtLog(@"%s is not optimized for view", #r)
#define GtAssertRectOptimizedForView(r) GtAssert(GtRectIsOptimizedForView(r), @"%s is not optimized for view", #r) 
#else
#define GtWarnIfRectIsNotOptimizedForView(r)
#define GtAssertRectOptimizedForView(r)
#endif

GT_INLINE CGRect GtRectGrowRectToOptimizedSizeIfNeeded(CGRect r);
GT_INLINE CGRect GtRectMoveRectToOptimizedLocationIfNeeded(CGRect r);

GT_INLINE CGSize GtSizeOptimizeForView(CGSize aSize);

#define GtRectMakeIntegral(__x__, __y__, __width__, __height__) \
	 GtReturnAssertIsSaneRect(CGRectIntegral(CGRectMake(__x__,__y__,__width__,__height__)))

#define GtRectIsTaller(__lhs__, __rhs__) ((__lhs__).size.height > (__rhs___).size.height)
#define GtRectIsWider(__lhs__, __rhs__) ((__lhs__).size.width > (__rhs__).size.width)

GT_INLINE CGRect GtRectCenterOnPoint(CGRect rect, CGPoint point);
GT_INLINE CGPoint GtRectGetCenter(CGRect rect);
GT_INLINE CGRect GtRectCenterRectInRect(CGRect container, CGRect containee);
GT_INLINE CGRect GtRectCenterRectInRectVertically(CGRect container, CGRect containee);
GT_INLINE CGRect GtRectCenterRectInRectHorizontally(CGRect container, CGRect containee);
GT_INLINE CGRect GtRectJustifyRectInRectRight(CGRect container, CGRect containee);
GT_INLINE CGRect GtRectJustifyRectInRectLeft(CGRect container, CGRect containee);
GT_INLINE CGRect GtRectJustifyRectInRectTop(CGRect container, CGRect containee);
GT_INLINE CGRect GtRectJustifyRectInRectBottom(CGRect container, CGRect containee);
GT_INLINE CGRect GtRectJustifyRectInRectTopLeft(CGRect container, CGRect containee);
GT_INLINE CGRect GtRectJustifyRectInRectTopRight(CGRect container, CGRect containee);
GT_INLINE CGRect GtRectJustifyRectInRectBottomRight(CGRect container, CGRect containee);
GT_INLINE CGRect GtRectJustifyRectInRectBottomLeft(CGRect container, CGRect containee);
GT_INLINE CGRect GtRectInsetTop(CGRect inRect, CGFloat delta);
GT_INLINE CGRect GtRectInsetBottom(CGRect inRect, CGFloat delta);
GT_INLINE CGRect GtRectInsetLeft(CGRect inRect, CGFloat delta);
GT_INLINE CGRect GtRectInsetRight(CGRect inRect, CGFloat delta);
GT_INLINE CGRect GtRectInsetWithEdgeInsets(CGRect inRect, UIEdgeInsets insets);
GT_INLINE CGRect GtRectAlignRectsHorizonally(CGRect left, CGRect right);
GT_INLINE CGRect GtRectSetHeight(CGRect rect, CGFloat height);
GT_INLINE CGRect GtRectAddHeight(CGRect rect, CGFloat height);
GT_INLINE CGRect GtRectSetWidth(CGRect rect, CGFloat width);
GT_INLINE CGRect GtRectAddWidth(CGRect rect, CGFloat width);

GT_INLINE CGRect GtRectSetTop(CGRect rect, CGFloat top);
GT_INLINE CGRect GtRectSetLeft(CGRect rect, CGFloat left);
GT_INLINE CGRect GtRectAlignRectVertically(CGRect top, CGRect bottom);
GT_INLINE CGRect GtRectRotate90Degrees(CGRect rect);

GT_INLINE CGRect GtRectPositionRectInRectVerticallyBottomThird(CGRect container, CGRect containee);
GT_INLINE CGRect GtRectPositionRectInRectVerticallyTopThird(CGRect container, CGRect containee);
GT_INLINE BOOL GtRectEnclosesRect(CGRect container, CGRect containee) ;
GT_INLINE CGFloat GtRectGetRight(CGRect rect);
GT_INLINE CGFloat GtRectGetBottom(CGRect rect);
#define GtRectGetLeft(__rect__) ((__rect__)).origin.x
#define GtRectGetTop(__rect__) ((__rect__)).origin.y


GT_INLINE CGRect GtRectMoveWithPoint(CGRect rect, CGPoint delta);
GT_INLINE CGRect GtRectMoveVertically(CGRect rect, CGFloat delta);

GT_INLINE CGRect GtRectMoveHorizontally(CGRect rect, CGFloat delta);
GT_INLINE CGRect GtRectMove(CGRect rect, CGFloat xDelta, CGFloat yDelta);
#define GtRectGetTopLeft(__rect__) (__rect__).origin

GT_INLINE CGPoint GtRectGetTopRight(CGRect rect);
GT_INLINE CGPoint GtRectGetBottomRight(CGRect rect);
GT_INLINE CGPoint GtRectGetBottomLeft(CGRect rect);
GT_INLINE CGRect GtRectSetOrigin(CGRect rect, CGFloat x, CGFloat y);
GT_INLINE CGRect GtRectSetOriginWithPoint(CGRect rect, CGPoint origin);
GT_INLINE CGRect GtRectSetSize(CGRect rect, CGFloat width, CGFloat height);

GT_INLINE CGRect GtRectAddSize(CGRect rect, CGFloat width, CGFloat height);
GT_INLINE CGRect GtRectAddSizeWithSize(CGRect rect, CGSize size);
GT_INLINE CGRect GtRectSetSizeWithSize(CGRect rect, CGSize size);
GT_INLINE CGRect GtRectScale(CGRect rect, CGFloat scaleFactor);
GT_INLINE CGRect GtRectMakeWithSize(CGSize size);
GT_INLINE CGRect GtRectMakeWithWidthAndHeight(CGFloat width, CGFloat height);

#if DEBUG
GT_INLINE CGRect GtRectInset(CGRect rect, CGFloat dx, CGFloat dy);
#define CGRectInset GtRectInset
#else
#define GtRectInset GtRectInset
#endif

/*
	This scales the containee rect to completely fill the container.
	
	The containee rect is scaled proportionally so if it has a different
	aspect ratio than the container, it WILL be larger than the container rect.
*/
extern 
CGRect GtRectFillRectInRectProportionally(CGRect container, CGRect containee);

extern 
CGRect GtRectFitInRectInRectProportionally(CGRect container, CGRect containee);

extern
CGRect GtRectEnsureRectInRect(CGRect container, CGRect containee);

#ifndef DEBUG
#include "_GtRectGeometry.h"
#endif
