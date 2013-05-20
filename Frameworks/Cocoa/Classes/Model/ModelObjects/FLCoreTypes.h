//
//  FLCoreTypes.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/24/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "FLStringEncoder.h"


//@protocol FLTypeCoreTypesEncoding <NSObject>
//- (NSString*) encodeStringWithRect:(NSValue*) value;
//- (NSString*) encodeStringWithPoint:(NSValue*) value;
//- (NSString*) encodeStringWithSize:(NSValue*) value;
//
//- (NSString*) encodeStringWithNumber:(NSNumber*) number;
//- (NSString*) encodeStringWithString:(NSString*) string;
//- (NSString*) encodeStringWithBOOL:(NSNumber*) number;
//
//- (NSString*) encodeStringWithData:(NSData*) data;
//- (NSString*) encodeStringWithURL:(NSURL*) URL;
//- (NSString*) encodeStringWithDate:(NSDate*) date;
//- (NSString*) encodeStringWithFont:(SDKFont*) font;
//
//@end
//
//// decoding
//
//@protocol FLTypeCoreTypesDecoding <NSObject>
//- (NSValue*) decodePointFromString:(NSString*) string;
//- (NSValue*) decodeRectFromString:(NSString*) string;
//- (NSValue*) decodeSizeFromString:(NSString*) string;
//
//- (NSNumber*) decodeBOOLFromString:(NSString*) string;
//- (NSNumber*) decodeNumberFromString:(NSString*) string;
//- (NSString*) decodeStringFromString:(NSString*) string;
//
//- (NSData*) decodeDataFromString:(NSString*) string;
//- (NSURL*) decodeURLFromString:(NSString*) string;
//- (NSDate*) decodeDateFromString:(NSString*) string;
//- (SDKFont*) decodeFontFromString:(NSString*) string;
//@end

//// numbers
//typedef enum {
//    FLTypeIDBool              = _C_BOOL,
//	FLTypeIDChar              = _C_CHR,
//	FLTypeIDUnsignedChar      = _C_UCHR,
//	FLTypeIDShort             = _C_SHT,
//	FLTypeIDUnsignedShort     = _C_USHT,
//	FLTypeIDInt               = _C_INT,
//	FLTypeIDUnsignedInt       = _C_UINT,
//	FLTypeIDLong              = _C_LNG,
//	FLTypeIDUnsignedLong      = _C_ULNG,
//	FLTypeIDLongLong          = _C_LNG_LNG,
//	FLTypeIDUnsignedLongLong  = _C_ULNG_LNG,
//	FLTypeIDFloat             = _C_FLT,
//	FLTypeIDDouble            = _C_DBL,
//} FLTypeNumberType;

//@interface FLNumberEncoder : FLStringEncoder {
//@private
//    FLTypeNumberType _numberType;
//}
//@property (readonly, assign, nonatomic) FLTypeNumberType numberType;
//@end
//
//
//@interface FLNumberObject : NSObject
//@end
//
//@interface FLBoolNumber : FLNumberObject
//+ (id) boolNumber;
//@end
//
//@interface FLCharNumber : FLNumberObject
//+ (id) charNumber;
//@end
//
//@interface FLUnsignedCharNumber : FLNumberObject
//+ (id) unsignedCharNumber;
//@end
//
//@interface FLShortNumber : FLNumberObject
//+ (id) shortNumber;
//@end
//
//@interface FLUnsignedShortNumber : FLNumberObject
//+ (id) unsignedShortNumber;
//@end
//
//@interface FLIntNumber : FLNumberObject
//+ (id) intNumber;
//@end
//
//@interface FLUnsignedIntNumber : FLNumberObject
//+ (id) unsignedIntNumber;
//@end
//
//@interface FLLongNumber : FLNumberObject
//+ (id) longNumber;
//@end
//
//@interface FLUnsignedLongNumber : FLNumberObject
//+ (id) unsignedLongNumber;
//@end
//
//@interface FLLongLongNumber : FLNumberObject
//+ (id) longLongNumber;
//@end
//
//@interface FLUnsignedLongLongNumber : FLNumberObject
//+ (id) unsignedLongLongNumber;
//@end
//
//@interface FLFloatNumber : FLNumberObject
//+ (id) floatNumber;
//@end
//
//@interface FLDoubleNumber : FLFloatNumber
//+ (id) doubleNumber;
//@end
//
//@interface FLIntegerNumber : FLNumberObject
//+ (id) integerNumber;
//@end
//
//@interface FLUnsignedIntegerNumber : FLNumberObject
//+ (id) unsignedIntegerNumber;
//@end
//
//// values
//
//@interface FLValueEncoder : FLStringEncoder
//@end
//
//@interface FLGeometrySize : NSObject
//+ (id) geometrySize;
//@end
//
//@interface FLGeometryRect : NSObject
//+ (id) geometryRect;
//@end
//
//@interface FLGeometryPoint : NSObject
//+ (id) geometryPoint;
//@end

//@interface FLMutableArrayType : FLStringEncoder
//@end

//// simple objects that return FLTypes
//@interface NSString (FLCoreTypes)
//@end
//
//@interface NSMutableString (FLCoreTypes)
//@end
//
//@interface NSArray (FLCoreTypes)
//@end
//
//@interface NSMutableArray (FLCoreTypes)
//@end
//
//@interface NSURL (FLCoreTypes)
//@end
//
//@interface NSData (FLCoreTypes)
//@end
//
//@interface NSMutableData (FLCoreTypes)
//@end
//
//@interface NSDate (FLCoreTypes)
//@end
//
//@interface SDKFont (FLCoreTypes)
//
//@end
