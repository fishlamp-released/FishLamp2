//
//	FLRect.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/22/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "FishLampCore.h"
#import "FLSize.h"
#import "FLPoint.h"
#import "FLEdgeInsets.h"

#if IOS
    #if DEBUG
        #define CGRectInset             FLRectInset
    #else
        #define FLRectInset             CGRectInset
    #endif
    
    #define FLRect                      CGRect
    #define FLRectMake                  CGRectMake
    #define FLRectFromString            CGRectFromString
    #define NSStringFromFLRect          NSStringFromCGRect
    #define FLRectIntegral              CGRectIntegral
    #define FLRectGetMidX               CGRectGetMidX
    #define FLRectGetMidY               CGRectGetMidY
    #define FLRectInsetWithEdgeInsets   UIEdgeInsetsInsetRect
    #define FLRectEqualToRect           CGRectEqualToRect
    #define FLEqualRects                CGRectEqualToRect
    #define FLRectZero                  CGRectZero
    
#else
    #if DEBUG
        #define NSRectInset             FLRectInset
    #else
        #define FLRectInset             NSRectInset
    #endif
    
    #define NSStringFromFLRect          NSStringFromRect
    #define FLRect                      NSRect
    #define FLRectFromString            NSRectFromString
    #define FLRectMake                  NSMakeRect
    #define FLRectIntegral              NSIntegralRect
    #define FLRectGetMidX               NSMidX
    #define FLRectGetMidY               NSMidY
    #define FLEqualRects                NSEqualRects
    #define FLRectEqualToRect           NSEqualRects
    #define FLRectZero                  NSZeroRect
    
#endif

#define FLRectMakeIntegral(__x__, __y__, __width__, __height__) \
	 FLRectIntegral(FLRectMake(__x__,__y__,__width__,__height__))

#define FLRectIsTaller(__lhs__, __rhs__) ((__lhs__).size.height > (__rhs___).size.height)
#define FLRectIsWider(__lhs__, __rhs__) ((__lhs__).size.width > (__rhs__).size.width)
#define FLRectGetLeft(__rect__) ((__rect__)).origin.x
#define FLRectGetTop(__rect__) ((__rect__)).origin.y
#define FLRectGetTopLeft(__rect__) (__rect__).origin

#if DEBUG

extern BOOL FLRectIsIntegral(FLRect r);

// centering
extern FLRect FLRectCenterOnPoint(FLRect rect, FLPoint point);
extern FLRect FLRectCenterOnPointVertically(FLRect rect, FLPoint point);
extern FLRect FLRectCenterOnPointHorizontally(FLRect rect, FLPoint point);

extern FLPoint FLRectGetCenter(FLRect rect);
extern FLRect FLRectCenterRectInRect(FLRect container, FLRect containee);
extern FLRect FLRectCenterRectInRectVertically(FLRect container, FLRect containee);
extern FLRect FLRectCenterRectInRectHorizontally(FLRect container, FLRect containee);

// justification
extern FLRect FLRectJustifyRectInRectRight(FLRect container, FLRect containee);
extern FLRect FLRectJustifyRectInRectLeft(FLRect container, FLRect containee);
extern FLRect FLRectJustifyRectInRectTop(FLRect container, FLRect containee);
extern FLRect FLRectJustifyRectInRectBottom(FLRect container, FLRect containee);
extern FLRect FLRectJustifyRectInRectTopLeft(FLRect container, FLRect containee);
extern FLRect FLRectJustifyRectInRectTopRight(FLRect container, FLRect containee);
extern FLRect FLRectJustifyRectInRectBottomRight(FLRect container, FLRect containee);
extern FLRect FLRectJustifyRectInRectBottomLeft(FLRect container, FLRect containee);

// inset
extern FLRect FLRectInsetTop(FLRect inRect, CGFloat delta);
extern FLRect FLRectInsetBottom(FLRect inRect, CGFloat delta);
extern FLRect FLRectInsetLeft(FLRect inRect, CGFloat delta);
extern FLRect FLRectInsetRight(FLRect inRect, CGFloat delta);

// this is a debugging only function that asserts that you're insetting with a reasonable
// value. Debug only. Ship calls CGRectInset/NSRectInset
extern FLRect FLRectInset(FLRect rect, CGFloat dx, CGFloat dy);

// layout
extern FLRect FLRectAlignRectsHorizonally(FLRect left, FLRect right);
extern FLRect FLRectAlignRectVertically(FLRect top, FLRect bottom);
extern FLRect FLRectPositionRectInRectVerticallyBottomThird(FLRect container, FLRect containee);
extern FLRect FLRectPositionRectInRectVerticallyTopThird(FLRect container, FLRect containee);
//	This scales the containee rect to completely fill the container.
//	The containee rect is scaled proportionally so if it has a different
//	aspect ratio than the container, it WILL be larger than the container rect.
extern FLRect FLRectFillRectInRectProportionally(FLRect container, FLRect containee);
extern FLRect FLRectFitInRectInRectProportionally(FLRect container, FLRect containee);
extern FLRect FLRectEnsureRectInRect(FLRect container, FLRect containee);

// size
extern FLRect FLRectSetHeight(FLRect rect, CGFloat height);
extern FLRect FLRectAddHeight(FLRect rect, CGFloat height);
extern FLRect FLRectSetWidth(FLRect rect, CGFloat width);
extern FLRect FLRectAddWidth(FLRect rect, CGFloat width);
extern FLRect FLRectSetSize(FLRect rect, CGFloat width, CGFloat height);
extern FLRect FLRectAddSize(FLRect rect, CGFloat width, CGFloat height);
extern FLRect FLRectAddSizeWithSize(FLRect rect, FLSize size);
extern FLRect FLRectSetSizeWithSize(FLRect rect, FLSize size);
extern FLRect FLRectScale(FLRect rect, CGFloat scaleFactor);

// location
extern FLRect FLRectSetTop(FLRect rect, CGFloat top);
extern FLRect FLRectSetLeft(FLRect rect, CGFloat left);

// edges and corners
extern CGFloat FLRectGetRight(FLRect rect);
extern CGFloat FLRectGetBottom(FLRect rect);
extern FLPoint FLRectGetTopRight(FLRect rect);
extern FLPoint FLRectGetBottomRight(FLRect rect);
extern FLPoint FLRectGetBottomLeft(FLRect rect);

// location
extern FLRect FLRectSetOrigin(FLRect rect, CGFloat x, CGFloat y);
extern FLRect FLRectSetOriginWithPoint(FLRect rect, FLPoint origin);
extern FLRect FLRectMoveWithPoint(FLRect rect, FLPoint delta);
extern FLRect FLRectMoveVertically(FLRect rect, CGFloat delta);
extern FLRect FLRectMoveHorizontally(FLRect rect, CGFloat delta);
extern FLRect FLRectMove(FLRect rect, CGFloat xDelta, CGFloat yDelta);

// construction
extern FLRect FLRectMakeWithSize(FLSize size);
extern FLRect FLRectMakeWithWidthAndHeight(CGFloat width, CGFloat height);

// misc
extern BOOL FLRectEnclosesRect(FLRect container, FLRect containee);
extern FLRect FLRectRotate90Degrees(FLRect rect);


#else

#import "_FLRect.h"

//	This scales the containee rect to completely fill the container.
//	The containee rect is scaled proportionally so if it has a different
//	aspect ratio than the container, it WILL be larger than the container rect.
extern FLRect FLRectFillRectInRectProportionally(FLRect container, FLRect containee);
extern FLRect FLRectFitInRectInRectProportionally(FLRect container, FLRect containee);
extern FLRect FLRectEnsureRectInRect(FLRect container, FLRect containee);

#endif

