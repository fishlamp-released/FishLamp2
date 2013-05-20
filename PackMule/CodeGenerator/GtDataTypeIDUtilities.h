//
//	GtDataTypeIDUtilities.h
//	PackMule
//
//	Created by Mike Fullerton on 4/27/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GtStringUtils.h"
#import "GtDataTypeID.h"
#import "GtCodeGenerator.h"

@class GtCodeGeneratorProject;

// Convert a string to a GtDataTypeID
// example: int to GtDataTypeInteger
extern GtDataTypeID GtDataTypeIDFromString(NSString* inString);

// convert a dataTypeId to a objective c type string
// example: GtDataTypeBool to @"BOOL"
extern NSString* GtObjCTypeStringFromDataType(GtDataTypeID dataType);

// convert a integer value of a GtDataTypeID to a string 
// exampe GtDataTypeBool to @"GtDataTypeBool"
extern NSString* GtDataTypeIDStringFromDataType(GtDataTypeID dataType);

// returns string for an type, e.g. if it's a value type, then a object that encapsulates it, 
// like an int and a NSNumber
extern NSString* GtObjcObjectTypeStringFromString(NSString* inString);

//extern BOOL GtTypeStringIsObject(NSString* inType, GtCodeGenerator* generator);

extern BOOL GtIsIdType(NSString* inType);


// returns objc type. e.g. INTEGER to int
NSString* GtConvertToKnownType(NSString* inType);

//extern NSString* GtTypeStringFromString(NSString* inString, NSString* defaultType);

#define GtStringIsNumber(__str__) GtDataTypeIsNumber(GtDataTypeIDFromString(__str__))

#define GtStringIsBool(__str__) (GtDataTypeIDFromString(__str__) == GtDataTypeBool)

#define GtHasPointerSplat(__str__) ([(__str__) rangeOfString:@"*"].length > 0)

#define GtRemovePointerSplat(__str__) [([__str__ trimmedString]) stringByReplacingOccurrencesOfString:@"*" withString:@""]


extern NSString* GtObjectTypeStringForValueType(GtDataTypeID type);


extern NSString* GtNumberInitForDataTypeID(GtDataTypeID type);



//extern
//NSString* GtAddPointerSplatIfNeeded(NSString* inType, GtCodeGenerator* generator);
//#define GtNormalizedTypeFromString(__unparsedString__) GtObjCTypeStringFromDataType(GtDataTypeIDFromString(__unparsedString__))
//#define IsEnumType(type) GtStringsAreEqual(type.typeName, @"enum")
//#define IsObjectType(type) GtStringsAreEqual(type.typeName, @"enum")
