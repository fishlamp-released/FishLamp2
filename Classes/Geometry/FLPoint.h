//
//	FLPoint.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/22/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//
#import "FishLampCocoa.h"

#if IOS
// CGPoint
    #define FLPoint                 CGPoint
    #define FLPointFromString       CGPointFromString
    #define NSStringFromFLPoint     NSStringFromCGPoint
    #define FLPointMake             CGPointMake
    #define FLPointEqualToPoint     CGPointEqualToPoint
    #define FLPointsAreEqual        FLPointEqualToPoint
    #define FLPointZero             CGPointZero
    #define FLEmptyPoint            FLPointZero

#else
// NSPoint
    #define FLPoint                 NSPoint
    #define FLPointFromString       NSPointFromString
    #define NSStringFromFLPoint     NSStringFromPoint
    #define FLPointMake             NSMakePoint
#endif

#define FLCoordinateIntegral(__coordinate__) (CGFloat) round(__coordinate__)

NS_INLINE
BOOL FLPointIsIntegral(FLPoint p) {
	return FLIsIntegralValue(p.x) && FLIsIntegralValue(p.y); 
}

NS_INLINE
FLPoint FLPointIntegral(FLPoint pt) {
	pt.x = FLCoordinateIntegral(pt.x);
	pt.y = FLCoordinateIntegral(pt.y);
	return pt;
}

NS_INLINE
FLPoint FLPointInvert(FLPoint pt) {
	pt.x *= (CGFloat)-1.0;
	pt.y *= (CGFloat)-1.0;
	return pt;
}

#define FLPointMakeIntegral(__x__, __y__) \
	FLPointMake(FLCoordinateIntegral(__x__), FLCoordinateIntegral(__y__))


NS_INLINE 
CGFloat FLDistanceBetweenTwoPoints(FLPoint point1, FLPoint point2) {
	CGFloat dx = point2.x - point1.x;
	CGFloat dy = point2.y - point1.y;
	return (CGFloat) sqrt(dx*dx + dy*dy );
}

NS_INLINE
BOOL FLPointIsEmpty(FLPoint pt) {
	return pt.x == 0 && pt.y == 0;
}

NS_INLINE
FLPoint FLPointAddPointToPoint(FLPoint pt, FLPoint addToPoint) {
	pt.x += addToPoint.x;
	pt.y += addToPoint.y;
	return pt;
}

NS_INLINE
FLPoint FLPointSubtractPointFromPoint(FLPoint point, FLPoint subtractFromPoint) {
	point.x -= subtractFromPoint.x;
	point.y -= subtractFromPoint.y;
	return point;
}


NS_INLINE
FLPoint FLPointSwapCoordinates(FLPoint pt) {
	return FLPointMake(pt.y, pt.x);
}

NS_INLINE
FLPoint FLPointScale(FLPoint pt, CGFloat scale) {
	pt.x *= scale;
	pt.y *= scale;
	
	return pt;
}

NS_INLINE
FLPoint FLPointMove(FLPoint pt, CGFloat xDelta, CGFloat yDelta) {
	pt.x += xDelta;
	pt.y += yDelta;
	return pt;
}