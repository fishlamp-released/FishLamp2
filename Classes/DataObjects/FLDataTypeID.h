//
//  FishLampDataTypeID.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/23/12
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FishLampCore.h"

typedef enum 
{
	FLDataTypeUnknown,

	FLDataTypeChar = kCFNumberCharType,
	FLDataTypeShort = kCFNumberShortType,
	FLDataTypeInteger = kCFNumberIntType,
	FLDataTypeLong = kCFNumberLongType,
	FLDataTypeLongLong = kCFNumberLongLongType,
	FLDataTypeFloat = kCFNumberFloatType,
	FLDataTypeDouble = kCFNumberDoubleType,
	
	// numbers
	FLDataTypeEnum,
	FLDataTypeBool,
	FLDataTypeUnsignedChar,
	FLDataTypeNSInteger,
	FLDataTypeNSUInteger,
	FLDataTypeUnsignedInteger,
	FLDataTypeUnsignedShort,
	FLDataTypeUnsignedLong,
	FLDataTypeUnsignedLongLong,
//	  FLDataTypeDecimal,

// NSValue structs
	FLDataTypePoint,
	FLDataTypeRect,
	FLDataTypeSize,
	FLDataTypeValue,

// Immutable Objects	  
	FLDataTypeString,
	FLDataTypeDate,
	FLDataTypeData,
    FLDataTypeColor,
    
//  NonImmutableObjects
    FLDataTypeURL,
	
// generic object (id) or otherwise	
	FLDataTypeObject
} FLDataTypeID;

NS_INLINE
BOOL FLDataTypeIsNumber(FLDataTypeID type)
{
	switch(type)
	{
		case FLDataTypeNSInteger:
		case FLDataTypeNSUInteger:
		case FLDataTypeEnum:
		case FLDataTypeBool:
		case FLDataTypeChar:
		case FLDataTypeUnsignedChar:
		case FLDataTypeInteger:
		case FLDataTypeUnsignedInteger:
		case FLDataTypeLong:
		case FLDataTypeUnsignedLong:
		case FLDataTypeShort:
		case FLDataTypeUnsignedShort:
        case FLDataTypeUnsignedLongLong:
		case FLDataTypeLongLong:
        case FLDataTypeFloat:
		case FLDataTypeDouble:
			return YES;
			
        case FLDataTypePoint:
        case FLDataTypeRect:
        case FLDataTypeSize:
        case FLDataTypeValue:
        case FLDataTypeUnknown:
		case FLDataTypeString:
        case FLDataTypeDate:
        case FLDataTypeData:
        case FLDataTypeColor:
        case FLDataTypeObject:
        case FLDataTypeURL:
            return NO;

	}

	return NO;
}

NS_INLINE
BOOL FLDataTypeIsValue(FLDataTypeID type)
{
	switch(type)
	{
		case FLDataTypePoint:
		case FLDataTypeRect:
		case FLDataTypeSize:
		case FLDataTypeValue:
			return YES;

		case FLDataTypeNSInteger:
		case FLDataTypeNSUInteger:
		case FLDataTypeEnum:
		case FLDataTypeBool:
		case FLDataTypeChar:
		case FLDataTypeUnsignedChar:
		case FLDataTypeInteger:
		case FLDataTypeUnsignedInteger:
		case FLDataTypeLong:
		case FLDataTypeUnsignedLong:
		case FLDataTypeShort:
		case FLDataTypeUnsignedShort:
		case FLDataTypeUnsignedLongLong:
		case FLDataTypeLongLong:
		case FLDataTypeFloat:
		case FLDataTypeDouble:
        case FLDataTypeUnknown:
		case FLDataTypeString:
        case FLDataTypeDate:
        case FLDataTypeData:
        case FLDataTypeColor:
        case FLDataTypeObject:
        case FLDataTypeURL:
            return NO;
	}

	return NO;
}

NS_INLINE
BOOL FLDataTypeIsObject(FLDataTypeID type)
{
	switch(type)
	{
		case FLDataTypeObject:
		case FLDataTypeString:
		case FLDataTypeDate:
		case FLDataTypeData:
        case FLDataTypeColor:
        case FLDataTypeURL:
			return YES;

		case FLDataTypePoint:
		case FLDataTypeRect:
		case FLDataTypeSize:
		case FLDataTypeValue:
		case FLDataTypeNSInteger:
		case FLDataTypeNSUInteger:
		case FLDataTypeEnum:
		case FLDataTypeBool:
		case FLDataTypeChar:
		case FLDataTypeUnsignedChar:
		case FLDataTypeInteger:
		case FLDataTypeUnsignedInteger:
		case FLDataTypeLong:
		case FLDataTypeUnsignedLong:
		case FLDataTypeShort:
		case FLDataTypeUnsignedShort:
		case FLDataTypeUnsignedLongLong:
		case FLDataTypeLongLong:
		case FLDataTypeFloat:
		case FLDataTypeDouble:
        case FLDataTypeUnknown:
            return NO;
	}
	
	return NO;
}



