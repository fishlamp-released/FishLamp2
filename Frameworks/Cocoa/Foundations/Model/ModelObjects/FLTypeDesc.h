//
//  FishLampDataTypeID.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/23/12
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FishLampCore.h"
#import "FLTypeDesc.h"

#import <objc/runtime.h>

typedef uint32_t FLTypeID;

@interface FLTypeDesc : NSObject {
@private
    Class _typeClass;
    FLTypeID _typeID;
    SEL _encodeSelector;
    SEL _decodeSelector;
}

@property (readonly, assign, nonatomic) FLTypeID typeID;
@property (readonly, strong, nonatomic) NSString* typeName;
@property (readonly, assign, nonatomic) Class typeClass;

- (id) initWithClass:(Class) aClass typeID:(FLTypeID) typeID;
- (id) initWithClass:(Class) aClass typeID:(FLTypeID) typeID encoder:(SEL) encoder decoder:(SEL) decoder;

+ (id) typeDescWithClass:(Class) aClass typeID:(FLTypeID) typeID;

// inflation helpers
+ (id) registeredTypeForName:(NSString*) string;
+ (void) registerTypeDesc:(FLTypeDesc*) desc;
- (void) registerSelf;

// encoding overrides (by default these call the encode/decoder selectors
@property (readonly, assign, nonatomic) SEL encodeSelector;
@property (readonly, assign, nonatomic) SEL decodeSelector;

// optional overrides.
- (NSString*) encodeObjectToString:(id) object withEncoder:(id) encoder;
- (id) decodeStringToObject:(NSString*) object withDecoder:(id) decoder;

@end

// core types

// objects
enum  {
    FLTypeIDObject              = _C_CLASS,
    FLTypeIDAbstractObject      = _C_ID,
    FLTypeIDString              = 'stro',
    FLTypeIDDate                = 'date',
    FLTypeIDURL                 = 'urlo',
    FLTypeIDData                = 'data'
};     

// geometry 
enum {
	FLTypeIDPoint               = 'poin',
	FLTypeIDRect                = 'rect',
	FLTypeIDSize                = 'size',
};

// numbers
enum {
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
};

@interface FLTypeDesc (CoreTypes)

// numbers (encoded in NSNumber) 
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

// geometry  (encoded in NSValue)
+ (id) pointType;
+ (id) rectType;
+ (id) sizeType;

// objects (encoded by className)
+ (id) abstractObjectTypeDesc; // e.g. id
+ (id) stringType;
+ (id) dateType;
+ (id) dataType;
+ (id) URLType;

// utils
- (BOOL) isNumber;
- (BOOL) isGeometry;
- (BOOL) isObject;
@end

// Enum Type (special case for a number)

//@interface FLEnumTypeDesc : FLTypeDesc
//@end

// encoding

@protocol FLTypeDescCoreTypesEncoding <NSObject>
- (NSString*) typeDesc:(FLTypeDesc*) typeDesc encodeStringWithNSValue:(NSValue*) value;
- (NSString*) typeDesc:(FLTypeDesc*) typeDesc encodeStringWithNSNumber:(NSNumber*) number;
- (NSString*) typeDesc:(FLTypeDesc*) typeDesc encodeStringWithNSString:(NSString*) string;
- (NSString*) typeDesc:(FLTypeDesc*) typeDesc encodeStringWithNSDate:(NSDate*) date;
- (NSString*) typeDesc:(FLTypeDesc*) typeDesc encodeStringWithNSData:(NSData*) data;
- (NSString*) typeDesc:(FLTypeDesc*) typeDesc encodeStringWithNSURL:(NSURL*) URL;
@end

// decoding

@protocol FLTypeDescCoreTypesDecoding <NSObject>
- (NSValue*) typeDesc:(FLTypeDesc*) typeDesc decodeNSValueFromString:(NSString*) string;
- (NSNumber*) typeDesc:(FLTypeDesc*) typeDesc decodeNSNumberFromString:(NSString*) string;
- (NSString*) typeDesc:(FLTypeDesc*) typeDesc decodeNSStringFromString:(NSString*) string;
- (NSDate*) typeDesc:(FLTypeDesc*) typeDesc decodeNSDateFromString:(NSString*) string;
- (NSData*) typeDesc:(FLTypeDesc*) typeDesc decodeNSDataFromString:(NSString*) string;
- (NSURL*) typeDesc:(FLTypeDesc*) typeDesc decodeNSURLFromString:(NSString*) string;
@end

// compatibility macros for core types

// numbers (NSNumber)
#define FLDataTypeBool              [FLTypeDesc boolType]
#define FLDataTypeChar              [FLTypeDesc charType]
#define FLDataTypeUnsignedChar      [FLTypeDesc unsignedCharType]
#define FLDataTypeShort             [FLTypeDesc shortType]
#define FLDataTypeUnsignedShort     [FLTypeDesc unsignedShortType]
#define FLDataTypeInt               [FLTypeDesc intType]
#define FLDataTypeUnsignedInt       [FLTypeDesc unsignedIntType]
#define FLDataTypeLong              [FLTypeDesc longType]
#define FLDataTypeUnsignedLong      [FLTypeDesc unsignedLongType]
#define FLDataTypeLongLong          [FLTypeDesc longLongType]
#define FLDataTypeUnsignedLongLong  [FLTypeDesc unsignedLongLongType]
#define FLDataTypeFloat             [FLTypeDesc floatType]
#define FLDataTypeDouble            [FLTypeDesc doubleType]
#define FLDataTypeInteger           [FLTypeDesc intType]
#define FLDataTypeUnsignedInteger   [FLTypeDesc unsignedIntType]

// geometry types
#define FLDataTypePoint             [FLTypeDesc pointType]
#define FLDataTypeRect              [FLTypeDesc rectType]
#define FLDataTypeSize              [FLTypeDesc sizeType]

// objects 
#define FLDataTypeString            [FLTypeDesc stringType]
#define FLDataTypeDate              [FLTypeDesc dateType]
#define FLDataTypeURL               [FLTypeDesc URLType]
#define FLDataTypeData              [FLTypeDesc dataType]

// abstract object (id) -- NOT encodeable.
#define FLDataTypeObject            [FLTypeDesc abstractObjectTypeDesc]
