//
//	GtPointGeometry.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/22/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#define GtCoordinateIntegral(__coordinate__) roundf(__coordinate__)

NS_INLINE
BOOL GtPointIsIntegral(CGPoint p)
{
	GtAssertIsSanePoint(p);
	
	return GtIsIntegralValue(p.x) && GtIsIntegralValue(p.y); 
}

NS_INLINE
CGPoint GtPointIntegral(CGPoint pt)
{
	GtAssertIsSanePoint(pt);
	
	pt.x = GtCoordinateIntegral(pt.x);
	pt.y = GtCoordinateIntegral(pt.y);
	return pt;
}

NS_INLINE
CGPoint GtPointInvert(CGPoint pt)
{
	pt.x *= (CGFloat)-1.0;
	pt.y *= (CGFloat)-1.0;
	return pt;
}

#define GtPointMakeIntegral(__x__, __y__) \
	GtReturnAssertIsSanePoint(CGPointMake(GtCoordinateIntegral(__x__), GtCoordinateIntegral(__y__)))


NS_INLINE 
CGFloat GtDistanceBetweenTwoPoints(CGPoint point1,CGPoint point2)
{
	GtAssertIsSanePoint(point1);
	GtAssertIsSanePoint(point2);
	
	CGFloat dx = point2.x - point1.x;
	CGFloat dy = point2.y - point1.y;
	return sqrtf(dx*dx + dy*dy );
}

NS_INLINE
BOOL GtPointIsEmpty(CGPoint pt)
{
	return pt.x == 0 && pt.y == 0;
}

NS_INLINE
CGPoint GtPointAddPointToPoint(CGPoint pt, CGPoint addToPoint)
{
	pt.x += addToPoint.x;
	pt.y += addToPoint.y;
	return pt;
}

NS_INLINE
CGPoint GtPointSubtractPointFromPoint(CGPoint point, CGPoint subtractFromPoint)
{
	point.x -= subtractFromPoint.x;
	point.y -= subtractFromPoint.y;
	return point;
}


NS_INLINE
CGPoint GtPointSwapCoordinates(CGPoint pt)
{
	return CGPointMake(pt.y, pt.x);
}

NS_INLINE
CGPoint GtPointScale(CGPoint pt, CGFloat scale)
{
	pt.x *= scale;
	pt.y *= scale;
	
	return pt;
}

NS_INLINE
CGPoint GtPointMove(CGPoint pt, CGFloat xDelta, CGFloat yDelta)
{
	pt.x += xDelta;
	pt.y += yDelta;
	return pt;
}