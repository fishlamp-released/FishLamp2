//
//	FLGeometry.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/22/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//
#import "FishLampCore.h"

NS_INLINE
BOOL FLIsIntegralValue(CGFloat coord) {
    return round(coord) == coord;
}

#define FLRadiansToDegrees(__radians__) ((__radians__) * (180.0 / M_PI))

#define FLDegreesToRadians(__degrees__) ((__degrees__) * (M_PI / 180.0))

#import "FLPoint.h"
#import "FLRect.h"
#import "FLSize.h"
#import "FLEdgeInsets.h"
#import "FLRectOptimize.h"
