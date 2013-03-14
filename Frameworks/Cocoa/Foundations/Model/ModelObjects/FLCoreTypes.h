//
//  FLCoreTypes.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLType.h"

@interface FLSimpleType : FLType
@end

// numbers
typedef enum {
    FLTypeIDBool              = _C_BOOL,
	FLTypeIDChar              = _C_CHR,
	FLTypeIDUnsignedChar      = _C_UCHR,
	FLTypeIDShort             = _C_SHT,
	FLTypeIDUnsignedShort     = _C_USHT,
	FLTypeIDInt               = _C_INT,
	FLTypeIDUnsignedInt       = _C_UINT,
	FLTypeIDLong              = _C_LNG,
	FLTypeIDUnsignedLong      = _C_ULNG,
	FLTypeIDLongLong          = _C_LNG_LNG,
	FLTypeIDUnsignedLongLong  = _C_ULNG_LNG,
	FLTypeIDFloat             = _C_FLT,
	FLTypeIDDouble            = _C_DBL,
} FLTypeNumberType;

@interface FLNumberType : FLSimpleType
@property (readonly, assign, nonatomic) FLTypeNumberType numberType;
@end

@interface FLBoolNumber : FLNumberType
+ (id) boolNumber;
@end

@interface FLCharNumber : FLNumberType
+ (id) charNumber;
@end

@interface FLUnsignedCharNumber : FLNumberType
+ (id) unsignedCharNumber;
@end

@interface FLShortNumber : FLNumberType
+ (id) shortNumber;
@end

@interface FLUnsignedShortNumber : FLNumberType
+ (id) unsignedShortNumber;
@end

@interface FLIntNumber : FLNumberType
+ (id) intNumber;
@end

@interface FLUnsignedIntNumber : FLNumberType
+ (id) unsignedIntNumber;
@end

@interface FLLongNumber : FLNumberType
+ (id) longNumber;
@end

@interface FLUnsignedLongNumber : FLNumberType
+ (id) unsignedLongNumber;
@end

@interface FLLongLongNumber : FLNumberType
+ (id) longLongNumber;
@end

@interface FLUnsignedLongLongNumber : FLNumberType
+ (id) unsignedLongLongNumber;
@end

@interface FLFloatNumber : FLNumberType
+ (id) floatNumber;
@end

@interface FLDoubleNumber : FLNumberType
+ (id) doubleNumber;
@end

@interface FLIntegerNumber : FLNumberType
+ (id) integerNumber;
@end

@interface FLUnsignedIntegerNumber : FLNumberType
+ (id) unsignedIntegerNumber;
@end

// values

@interface FLValueType : FLSimpleType
@end

@interface FLGeometrySize : FLValueType
+ (id) geometrySize;
@end

@interface FLGeometryRect : FLValueType
+ (id) geometryRect;
@end

@interface FLGeometryPoint : FLValueType
+ (id) geometryPoint;
@end

@interface FLMutableArrayType : FLType
@end

// simple objects that return FLTypes
@interface NSString (FLCoreTypes)
@end

@interface NSMutableString (FLCoreTypes)
@end

@interface NSArray (FLCoreTypes)
@end

@interface NSMutableArray (FLCoreTypes)
@end

@interface NSURL (FLCoreTypes)
@end

@interface NSData (FLCoreTypes)
@end

@interface NSMutableData (FLCoreTypes)
@end

@interface NSDate (FLCoreTypes)
@end
