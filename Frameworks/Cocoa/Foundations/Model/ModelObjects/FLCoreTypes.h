//
//  FLCoreTypes.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLTypeDesc.h"

@interface FLSimpleTypeDesc : FLTypeDesc
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
} FLTypeDescNumberType;

@interface FLNumberTypeDesc : FLSimpleTypeDesc
@property (readonly, assign, nonatomic) FLTypeDescNumberType numberType;
@end

@interface FLBoolNumber : FLNumberTypeDesc
+ (id) boolNumber;
@end

@interface FLCharNumber : FLNumberTypeDesc
+ (id) charNumber;
@end

@interface FLUnsignedCharNumber : FLNumberTypeDesc
+ (id) unsignedCharNumber;
@end

@interface FLShortNumber : FLNumberTypeDesc
+ (id) shortNumber;
@end

@interface FLUnsignedShortNumber : FLNumberTypeDesc
+ (id) unsignedShortNumber;
@end

@interface FLIntNumber : FLNumberTypeDesc
+ (id) intNumber;
@end

@interface FLUnsignedIntNumber : FLNumberTypeDesc
+ (id) unsignedIntNumber;
@end

@interface FLLongNumber : FLNumberTypeDesc
+ (id) longNumber;
@end

@interface FLUnsignedLongNumber : FLNumberTypeDesc
+ (id) unsignedLongNumber;
@end

@interface FLLongLongNumber : FLNumberTypeDesc
+ (id) longLongNumber;
@end

@interface FLUnsignedLongLongNumber : FLNumberTypeDesc
+ (id) unsignedLongLongNumber;
@end

@interface FLFloatNumber : FLNumberTypeDesc
+ (id) floatNumber;
@end

@interface FLDoubleNumber : FLNumberTypeDesc
+ (id) doubleNumber;
@end

@interface FLIntegerNumber : FLNumberTypeDesc
+ (id) integerNumber;
@end

@interface FLUnsignedIntegerNumber : FLNumberTypeDesc
+ (id) unsignedIntegerNumber;
@end

// values

@interface FLValueTypeDesc : FLSimpleTypeDesc
@end

@interface FLGeometrySize : FLValueTypeDesc
+ (id) geometrySize;
@end

@interface FLGeometryRect : FLValueTypeDesc
+ (id) geometryRect;
@end

@interface FLGeometryPoint : FLValueTypeDesc
+ (id) geometryPoint;
@end

@interface FLMutableArrayType : FLTypeDesc
@end

// simple objects that return FLTypeDescs
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
