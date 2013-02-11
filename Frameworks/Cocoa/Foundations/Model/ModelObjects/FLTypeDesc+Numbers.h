//
//  FLTypeDesc+Numbers.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/10/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

// included by FLTypeDesc.h

typedef enum  {
    FLTypeDescBool              = _C_BOOL,
	FLTypeDescChar              = _C_CHR,
	FLTypeDescUnsignedChar      = _C_UCHR,
	FLTypeDescShort             = _C_SHT,
	FLTypeDescUnsignedShort     = _C_USHT,
	FLTypeDescInt               = _C_INT,
	FLTypeDescUnsignedInt       = _C_UINT,

//#if FL_INT64
//	FLTypeDescInteger           = _C_LNG,
//	FLTypeDescUnsignedInteger   = _C_ULNG,
//#else
//	FLTypeDescInteger           = _C_INT,
//	FLTypeDescUnsignedInteger   = _C_UINT,
//#endif    
	FLTypeDescLong              = _C_LNG,
	FLTypeDescUnsignedLong      = _C_ULNG,
	FLTypeDescLongLong          = _C_LNG_LNG,
	FLTypeDescUnsignedLongLong  = _C_ULNG_LNG,
	FLTypeDescFloat             = _C_FLT,
	FLTypeDescDouble            = _C_DBL,
	FLTypeDescEnum              = 'enum',
} FLTypeDescNumberType;

@interface FLTypeDesc (Numbers)

// numbers
+ (id) boolType;
+ (id) charType;
+ (id) unsignedCharType;
+ (id) shortType;
+ (id) unsignedShortType;
+ (id) intType;
+ (id) unsignedIntType;
+ (id) longType;
+ (id) unsignedLongType;
+ (id) longLongType;
+ (id) unsignedLongLongType;
+ (id) floatType;
+ (id) doubleType;
//+ (id) enumType;
@end

@interface FLNumberTypeDesc : FLTypeDesc {
@private
    FLTypeDescNumberType _numberType;
}
- (id) initWithName:(NSString*) name numberType:(FLTypeDescNumberType) numberType;

@property (readonly, assign, nonatomic) FLTypeDescNumberType numberType;

@end

@interface FLEnumTypeDesc : FLNumberTypeDesc
@end


@protocol FLTypeDescNumberEncoding <NSObject>
- (NSString*) encodeStringWithNumber:(NSNumber*) number;
- (NSNumber*) decodeNumberFromString:(NSString*) string;
@end

// compatibility macros
#define FLDataTypeBool [FLTypeDesc boolType]
#define FLDataTypeChar [FLTypeDesc charType]
#define FLDataTypeUnsignedChar [FLTypeDesc unsignedCharType]
#define FLDataTypeShort [FLTypeDesc shortType]
#define FLDataTypeUnsignedShort [FLTypeDesc unsignedShortType]
#define FLDataTypeInt [FLTypeDesc intType]
#define FLDataTypeUnsignedInt [FLTypeDesc unsignedIntType]
#define FLDataTypeLong [FLTypeDesc longType]
#define FLDataTypeUnsignedLong [FLTypeDesc unsignedLongType]
#define FLDataTypeLongLong [FLTypeDesc longLongType]
#define FLDataTypeUnsignedLongLong [FLTypeDesc unsignedLongLongType]
#define FLDataTypeFloat [FLTypeDesc floatType]
#define FLDataTypeDouble [FLTypeDesc doubleType]


#define FLDataTypeInteger [FLTypeDesc intType]
#define FLDataTypeUnsignedInteger [FLTypeDesc unsignedIntType]
