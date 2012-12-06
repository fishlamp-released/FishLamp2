//
//	SDKPoint.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/22/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//
#import "FishLampCore.h"

#import "SDKPoint.h"

#define FLCoordinateIntegral(__coordinate__) (CGFloat) round(__coordinate__)

NS_INLINE
BOOL FLPointIsIntegral(SDKPoint p) {
	return FLIsIntegralValue(p.x) && FLIsIntegralValue(p.y); 
}

NS_INLINE
SDKPoint FLPointIntegral(SDKPoint pt) {
	pt.x = FLCoordinateIntegral(pt.x);
	pt.y = FLCoordinateIntegral(pt.y);
	return pt;
}

NS_INLINE
SDKPoint FLPointInvert(SDKPoint pt) {
	pt.x *= (CGFloat)-1.0;
	pt.y *= (CGFloat)-1.0;
	return pt;
}

#define FLPointMakeIntegral(__x__, __y__) \
	FLPointMake(FLCoordinateIntegral(__x__), FLCoordinateIntegral(__y__))


NS_INLINE 
CGFloat FLDistanceBetweenTwoPoints(SDKPoint point1, SDKPoint point2) {
	CGFloat dx = point2.x - point1.x;
	CGFloat dy = point2.y - point1.y;
	return (CGFloat) sqrt(dx*dx + dy*dy );
}

NS_INLINE
BOOL FLPointIsEmpty(SDKPoint pt) {
	return FLFloatEqualToZero(pt.x) && FLFloatEqualToZero(pt.y);
}

NS_INLINE
SDKPoint FLPointAddPointToPoint(SDKPoint pt, SDKPoint addToPoint) {
	pt.x += addToPoint.x;
	pt.y += addToPoint.y;
	return pt;
}

NS_INLINE
SDKPoint FLPointSubtractPointFromPoint(SDKPoint point, SDKPoint subtractFromPoint) {
	point.x -= subtractFromPoint.x;
	point.y -= subtractFromPoint.y;
	return point;
}


NS_INLINE
SDKPoint FLPointSwapCoordinates(SDKPoint pt) {
	return FLPointMake(pt.y, pt.x);
}

NS_INLINE
SDKPoint FLPointScale(SDKPoint pt, CGFloat scale) {
	pt.x *= scale;
	pt.y *= scale;
	
	return pt;
}

NS_INLINE
SDKPoint FLPointMove(SDKPoint pt, CGFloat xDelta, CGFloat yDelta) {
	pt.x += xDelta;
	pt.y += yDelta;
	return pt;
}