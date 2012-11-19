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

#define FLFloatEqualToFloat(a,b) (fabs((a) - (b)) < FLT_EPSILON)
#define FLFloatEqualToZero(a) (fabs(a) < FLT_EPSILON)

#if CGFLOAT_IS_DOUBLE
#define FLFloatFloor(__CGFLOAT__) ((CGFloat) floor(__CGFLOAT__))
#define FLFloatRound(__CGFLOAT__) ((CGFloat) round(__CGFLOAT__))
#define FLFloatMod(__LHS__, __RHS__) ((CGFloat) fmod(__LHS__, __RHS__))
#define FLFloatAbs(__CGFLOAT__) ((CGFloat) fabs(__CGFLOAT__))
#else
#define FLFloatFloor(__CGFLOAT__) ((CGFloat) floorf(__CGFLOAT__))
#define FLFloatRound(__CGFLOAT__) ((CGFloat) roundf(__CGFLOAT__))
#define FLFloatMod(__LHS__, __RHS__) ((CGFloat) fmodf(__LHS__, __RHS__))
#define FLFloatAbs(__CGFLOAT__) ((CGFloat) fabsf(__CGFLOAT__))
#endif



#import "FLPoint.h"
#import "FLRect.h"
#import "FLSize.h"
#import "FLEdgeInsets.h"
#import "FLRectOptimize.h"
