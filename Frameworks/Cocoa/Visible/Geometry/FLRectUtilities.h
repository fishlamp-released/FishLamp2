//
//	SDKRect.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/22/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "FishLampCore.h"
#import "SDKRect.h"
#import "SDKSize.h"
#import "SDKPoint.h"
#import "SDKEdgeInsets.h"
#import "FLMath.h"

#define FLRectMakeIntegral(__x__, __y__, __width__, __height__) \
	 SDKRectIntegral(FLRectMake(__x__,__y__,__width__,__height__))

#define FLRectIsTaller(__lhs__, __rhs__) ((__lhs__).size.height > (__rhs___).size.height)
#define FLRectIsWider(__lhs__, __rhs__) ((__lhs__).size.width > (__rhs__).size.width)
#define FLRectGetLeft(__rect__) ((__rect__)).origin.x
#define FLRectGetTop(__rect__) ((__rect__)).origin.y
#define FLRectGetTopLeft(__rect__) (__rect__).origin

#if DEBUG

extern BOOL FLRectIsIntegral(SDKRect r);

// centering
extern SDKRect FLRectCenterOnPoint(SDKRect rect, SDKPoint point);
extern SDKRect FLRectCenterOnPointVertically(SDKRect rect, SDKPoint point);
extern SDKRect FLRectCenterOnPointHorizontally(SDKRect rect, SDKPoint point);

extern SDKPoint FLRectGetCenter(SDKRect rect);
extern SDKRect FLRectCenterRectInRect(SDKRect container, SDKRect containee);
extern SDKRect FLRectCenterRectInRectVertically(SDKRect container, SDKRect containee);
extern SDKRect FLRectCenterRectInRectHorizontally(SDKRect container, SDKRect containee);

// justification
extern SDKRect FLRectJustifyRectInRectRight(SDKRect container, SDKRect containee);
extern SDKRect FLRectJustifyRectInRectLeft(SDKRect container, SDKRect containee);
extern SDKRect FLRectJustifyRectInRectTop(SDKRect container, SDKRect containee);
extern SDKRect FLRectJustifyRectInRectBottom(SDKRect container, SDKRect containee);
extern SDKRect FLRectJustifyRectInRectTopLeft(SDKRect container, SDKRect containee);
extern SDKRect FLRectJustifyRectInRectTopRight(SDKRect container, SDKRect containee);
extern SDKRect FLRectJustifyRectInRectBottomRight(SDKRect container, SDKRect containee);
extern SDKRect FLRectJustifyRectInRectBottomLeft(SDKRect container, SDKRect containee);

// inset
// this is a debugging only function that asserts that you're insetting with a reasonable
// value. Debug only. Ship calls CGRectInset/NSRectInset
extern SDKRect FLRectInset(SDKRect rect, CGFloat dx, CGFloat dy);

extern SDKRect FLRectInsetTop(SDKRect inRect, CGFloat delta);
extern SDKRect FLRectInsetBottom(SDKRect inRect, CGFloat delta);
extern SDKRect FLRectInsetLeft(SDKRect inRect, CGFloat delta);
extern SDKRect FLRectInsetRight(SDKRect inRect, CGFloat delta);
extern SDKRect FLRectInsetWithEdgeInsets(SDKRect inRect, SDKEdgeInsets insets);

// layout
extern SDKRect FLRectAlignRectsHorizonally(SDKRect left, SDKRect right);
extern SDKRect FLRectAlignRectVertically(SDKRect top, SDKRect bottom);
extern SDKRect FLRectPositionRectInRectVerticallyBottomThird(SDKRect container, SDKRect containee);
extern SDKRect FLRectPositionRectInRectVerticallyTopThird(SDKRect container, SDKRect containee);
//	This scales the containee rect to completely fill the container.
//	The containee rect is scaled proportionally so if it has a different
//	aspect ratio than the container, it WILL be larger than the container rect.
extern SDKRect FLRectFillRectInRectProportionally(SDKRect container, SDKRect containee);
extern SDKRect FLRectFitInRectInRectProportionally(SDKRect container, SDKRect containee);
extern SDKRect FLRectEnsureRectInRect(SDKRect container, SDKRect containee);

// size
extern SDKRect FLRectSetHeight(SDKRect rect, CGFloat height);
extern SDKRect FLRectAddHeight(SDKRect rect, CGFloat height);
extern SDKRect FLRectSetWidth(SDKRect rect, CGFloat width);
extern SDKRect FLRectAddWidth(SDKRect rect, CGFloat width);
extern SDKRect FLRectSetSize(SDKRect rect, CGFloat width, CGFloat height);
extern SDKRect FLRectAddSize(SDKRect rect, CGFloat width, CGFloat height);
extern SDKRect FLRectAddSizeWithSize(SDKRect rect, SDKSize size);
extern SDKRect FLRectSetSizeWithSize(SDKRect rect, SDKSize size);
extern SDKRect FLRectScale(SDKRect rect, CGFloat scaleFactor);

// location
extern SDKRect FLRectSetTop(SDKRect rect, CGFloat top);
extern SDKRect FLRectSetLeft(SDKRect rect, CGFloat left);

// edges and corners
extern CGFloat FLRectGetRight(SDKRect rect);
extern CGFloat FLRectGetBottom(SDKRect rect);
extern SDKPoint FLRectGetTopRight(SDKRect rect);
extern SDKPoint FLRectGetBottomRight(SDKRect rect);
extern SDKPoint FLRectGetBottomLeft(SDKRect rect);

// location
extern SDKRect FLRectSetOrigin(SDKRect rect, CGFloat x, CGFloat y);
extern SDKRect FLRectSetOriginWithPoint(SDKRect rect, SDKPoint origin);
extern SDKRect FLRectMoveWithPoint(SDKRect rect, SDKPoint delta);
extern SDKRect FLRectMoveVertically(SDKRect rect, CGFloat delta);
extern SDKRect FLRectMoveHorizontally(SDKRect rect, CGFloat delta);
extern SDKRect FLRectMove(SDKRect rect, CGFloat xDelta, CGFloat yDelta);

// construction
extern SDKRect FLRectMakeWithSize(SDKSize size);
extern SDKRect FLRectMakeWithWidthAndHeight(CGFloat width, CGFloat height);

// misc
extern BOOL FLRectEnclosesRect(SDKRect container, SDKRect containee);
extern SDKRect FLRectRotate90Degrees(SDKRect rect);


#else

#import "FLRectUtilities_Inlines.h"

//	This scales the containee rect to completely fill the container.
//	The containee rect is scaled proportionally so if it has a different
//	aspect ratio than the container, it WILL be larger than the container rect.
extern SDKRect FLRectFillRectInRectProportionally(SDKRect container, SDKRect containee);
extern SDKRect FLRectFitInRectInRectProportionally(SDKRect container, SDKRect containee);
extern SDKRect FLRectEnsureRectInRect(SDKRect container, SDKRect containee);

#endif

