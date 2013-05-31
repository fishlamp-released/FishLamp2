//
//  FLCodeDataType+ObjC.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 3/16/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//
#if REFACTOR
#import "FLCodeDataType.h"

#import "FLStringUtils.h"

@interface FLCodeDataType (Objc)
//extern NSString* FLObjectTypeStringForValueType(FLPropertyDescriber* type);

//+ (FLCodeDataType*) typeFromObjcString:(NSString*) typeString;
//- (NSString*) objcTypeString;
//
//- (BOOL) isNumber;
//- (BOOL) isEnum;
//- (BOOL) isValue;
//- (BOOL) isObject;
//- (BOOL) isKnownObjectType;
//- (BOOL) isString;
//
//- (NSString*) stringForValueType;

//+ (NSString*) convertToKnownTypeString:(NSString*) string;

//extern BOOL FLTypeIsNumber(FLPropertyDescriber* type);
//extern BOOL FLTypeIsEnum(FLPropertyDescriber* type);
//extern BOOL FLTypeIsValue(FLPropertyDescriber* type);
//extern BOOL FLTypeIsObject(FLPropertyDescriber* type);
//extern BOOL FLIsIdType(NSString* inType);
@end

#define FLHasPointerSplat(__str__) ([(__str__) rangeOfString:@"*"].length > 0)

#define FLRemovePointerSplat(__str__) [([__str__ trimmedString]) stringByReplacingOccurrencesOfString:@"*" withString:@""]


// returns string for an type, e.g. if it's a value type, then a object that encapsulates it, 
// like an int and a NSNumber
extern NSString* FLObjcObjectTypeStringFromString(NSString* inString);

// convert a integer value of a FLDataTypeID to a string 
// exampe FLDataTypeBool to @"FLDataTypeBool"
//extern NSString* FLDataTypeIDStringFromDataType(FLPropertyDescriber* dataType);

//extern BOOL FLIsIdType(NSString* type);

extern NSString* FLConvertToKnownType(NSString* string);




@class FLCodeProject;

// Convert a string to a FLDataTypeID
// example: int to FLDataTypeInteger
extern FLDataTypeID FLDataTypeIDFromString(NSString* inString);

// convert a dataTypeId to a objective c type string
// example: FLDataTypeBool to @"BOOL"
extern NSString* FLObjCTypeStringFromDataType(FLDataTypeID dataType);


//extern BOOL FLypeStringIsObject(NSString* inType, id generator);




//extern NSString* FLypeStringFromString(NSString* inString, NSString* defaultType);

#define FLStringIsNumber(__str__) FLDataTypeIsNumber(FLDataTypeIDFromString(__str__))

#define FLStringIsBool(__str__) (FLDataTypeIDFromString(__str__) == FLDataTypeBool)


extern NSString* FLNumberInitForDataTypeID(FLDataTypeID type);

//extern
//NSString* FLAddPointerSplatIfNeeded(NSString* inType, id generator);
//#define FLNormalizedTypeFromString(__unparsedString__) FLObjCTypeStringFromDataType(FLDataTypeIDFromString(__unparsedString__))
//#define IsEnumType(type) FLStringsAreEqual(type.typeName, @"enum")
//#define IsObjectType(type) FLStringsAreEqual(type.typeName, @"enum")
#endif

