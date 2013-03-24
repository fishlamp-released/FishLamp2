//
//  FLCoreTypes.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLObjectEncoder.h"


@protocol FLTypeCoreTypesEncoding <NSObject>
- (NSString*) encodeStringWithCGRect:(NSValue*) value;
- (NSString*) encodeStringWithCGPoint:(NSValue*) value;
- (NSString*) encodeStringWithCGSize:(NSValue*) value;

- (NSString*) encodeStringWithNSNumber:(NSNumber*) number;
- (NSString*) encodeStringWithNSString:(NSString*) string;
- (NSString*) encodeStringWithNSDate:(NSDate*) date;
- (NSString*) encodeStringWithNSData:(NSData*) data;
- (NSString*) encodeStringWithNSURL:(NSURL*) URL;

- (NSString*) encodeStringWithBOOL:(NSNumber*) number;
@end

// decoding

@protocol FLTypeCoreTypesDecoding <NSObject>
- (NSValue*) decodeCGPointFromString:(NSString*) string;
- (NSValue*) decodeCGRectFromString:(NSString*) string;
- (NSValue*) decodeCGSizeFromString:(NSString*) string;

- (NSNumber*) decodeBOOLFromString:(NSString*) string;
- (NSNumber*) decodeNSNumberFromString:(NSString*) string;
- (NSString*) decodeNSStringFromString:(NSString*) string;
- (NSDate*) decodeNSDateFromString:(NSString*) string;
- (NSData*) decodeNSDataFromString:(NSString*) string;
- (NSURL*) decodeNSURLFromString:(NSString*) string;
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

@interface FLNumberEncoder : FLObjectEncoder
@property (readonly, assign, nonatomic) FLTypeNumberType numberType;
@end

@interface FLBoolNumber : FLNumberEncoder
+ (id) boolNumber;
@end

@interface FLCharNumber : FLNumberEncoder
+ (id) charNumber;
@end

@interface FLUnsignedCharNumber : FLNumberEncoder
+ (id) unsignedCharNumber;
@end

@interface FLShortNumber : FLNumberEncoder
+ (id) shortNumber;
@end

@interface FLUnsignedShortNumber : FLNumberEncoder
+ (id) unsignedShortNumber;
@end

@interface FLIntNumber : FLNumberEncoder
+ (id) intNumber;
@end

@interface FLUnsignedIntNumber : FLNumberEncoder
+ (id) unsignedIntNumber;
@end

@interface FLLongNumber : FLNumberEncoder
+ (id) longNumber;
@end

@interface FLUnsignedLongNumber : FLNumberEncoder
+ (id) unsignedLongNumber;
@end

@interface FLLongLongNumber : FLNumberEncoder
+ (id) longLongNumber;
@end

@interface FLUnsignedLongLongNumber : FLNumberEncoder
+ (id) unsignedLongLongNumber;
@end

@interface FLFloatNumber : FLNumberEncoder
+ (id) floatNumber;
@end

@interface FLDoubleNumber : FLNumberEncoder
+ (id) doubleNumber;
@end

@interface FLIntegerNumber : FLNumberEncoder
+ (id) integerNumber;
@end

@interface FLUnsignedIntegerNumber : FLNumberEncoder
+ (id) unsignedIntegerNumber;
@end

// values

@interface FLValueType : FLObjectEncoder
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

@interface FLMutableArrayType : FLObjectEncoder
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