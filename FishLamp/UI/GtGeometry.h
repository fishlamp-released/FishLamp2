//
//  GtGeometry.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/22/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GtPoint.h"

#define GtTabBarHeight 49
#define GtToolBarHeight 44
#define GtNavigationBarHeight 42
#define GtKeyboardHeight 216
#define GtStatusBarHeight 20

NS_INLINE 
CGRect GtCenterRectInRect(CGRect container, CGRect containee)
{
	containee.origin.x = (container.size.width/2) - (containee.size.width/2);
	containee.origin.y = (container.size.height/2) - (containee.size.height/2);
	return containee;
}

NS_INLINE 
CGRect GtCenterRectVerticallyInRect(CGRect container, CGRect containee)
{
	containee.origin.y = (container.size.height/2) - (containee.size.height/2);
	return containee;
}

NS_INLINE 
CGRect GtCenterRectHorizontallyInRect(CGRect container, CGRect containee)
{
	containee.origin.x = (container.size.width/2) - (containee.size.width/2);
	return containee;
}

NS_INLINE 
CGRect GtRightJustifyRectInRect(CGRect container, CGRect containee)
{
	containee.origin.x = container.size.width - containee.size.width;
	return containee;
}

NS_INLINE 
CGRect GtLeftJustifyRectInRect(CGRect container, CGRect containee)
{
	containee.origin.x = container.origin.x;
	return containee;
}

NS_INLINE 
CGRect GtBottomJustifyRectInRect(CGRect container, CGRect containee)
{
	containee.origin.y = container.size.height - containee.size.height;
	return containee;
}

NS_INLINE 
CGRect GtBottomRightJustifyRectInRect(CGRect container, CGRect containee)
{
    containee.origin.y = container.size.height - containee.size.height;
	containee.origin.x = container.size.width - containee.size.width;
	return containee;
}

NS_INLINE 
CGRect GtRotateRect90Degrees(CGRect rect)
{
	return CGRectMake(rect.origin.x, rect.origin.y, rect.size.height, rect.size.width);
}

NS_INLINE  
CGFloat GtDistanceBetweenTwoPoints(CGPoint point1,CGPoint point2)
{
	CGFloat dx = point2.x - point1.x;
	CGFloat dy = point2.y - point1.y;
	return sqrt(dx*dx + dy*dy );
};

NS_INLINE 
CGFloat GtRadiansToDegrees(CGFloat radians)
{
	return radians * (180.0 / M_PI);
}

NS_INLINE 
CGFloat GtDegreesToRadian(CGFloat degrees)
{
	return degrees * (M_PI / 180.0);
}

NS_INLINE 
BOOL GtRectEnclosesRect(CGRect container, CGRect containee) 
{
	return	containee.origin.x >= container.origin.x &&
			containee.origin.y >= container.origin.y &&
			(containee.origin.x + containee.size.width) <= (container.origin.x + container.size.width) &&
			(containee.origin.y + containee.size.height) <= (container.origin.y + container.size.height);
}

NS_INLINE 
CGRect GtCenterRectOnPoint(CGPoint point, CGRect rect)
{
	rect.origin.x = point.x - (rect.size.width/2);
	rect.origin.y = point.y - (rect.size.height/2);
	return rect;
}

NS_INLINE 
CGPoint GtRectGetCenter(CGRect rect)
{
	return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

NS_INLINE 
CGFloat GtRectRightSide(CGRect rect)
{
    return rect.origin.x + rect.size.width;
}

NS_INLINE
CGFloat GtRectBottomSide(CGRect rect)
{
    return rect.origin.y + rect.size.height;
}

NS_INLINE
CGRect GtRectOffsetByPoint(CGRect rect, CGPoint delta)
{
    rect.origin.x += delta.x;
    rect.origin.y += delta.y;
    return rect;
}


extern CGRect GtFillRectInRect(CGRect container, CGRect containee);


#define GtStringFromRect(r) [NSString stringWithFormat:@"x:%f, y:%f, width:%f, height:%f", r.origin.x, r.origin.y, r.size.width, r.size.height]


