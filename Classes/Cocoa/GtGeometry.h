//
//	GtGeometry.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/22/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <CoreGraphics/CGGeometry.h>

// more of these can be made into macros for speed?

extern const CGSize CGSizeMax;

#define GtIsIntegralValue(__coordinate__) (roundf(__coordinate__) == __coordinate__)

#define GtRadiansToDegrees(__radians__) ((__radians__) * (180.0 / M_PI))

#define GtDegreesToRadians(__degrees__) ((__degrees__) * (M_PI / 180.0))

#import "GtRectGeometry.h"
#import "GtPointGeometry.h"
//#import "GtOrientationUtilities.h"

NS_INLINE
CGSize GtSizeScale(CGSize size, CGFloat scaleFactor)
{
	size.width *= scaleFactor;
	size.height *= scaleFactor;
	return size;
}

NS_INLINE
CGSize GtSizeSwapValues(CGSize size)
{
	return CGSizeMake(size.height, size.width);
}



NS_INLINE
CGSize GtSizeAddSizeToSize(CGSize addTo, CGSize delta)
{
	addTo.height += delta.height;
	addTo.width += delta.width;
	return addTo;
}

NS_INLINE
CGSize GtPointSubtractSizeFromSize(CGSize subtractFrom, CGSize delta)
{
	subtractFrom.width -= delta.width;
	subtractFrom.height -= delta.height;
	return subtractFrom;
}

NS_INLINE
BOOL GtSizeIsEmpty(CGSize size)
{
	return size.width == 0 && size.height == 0;
}

