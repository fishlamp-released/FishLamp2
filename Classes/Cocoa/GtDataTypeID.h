
#import "GtBitFlags.h"

typedef enum 
{
	GtDataTypeUnknown,

	GtDataTypeChar = kCFNumberCharType,
	GtDataTypeShort = kCFNumberShortType,
	GtDataTypeInteger = kCFNumberIntType,
	GtDataTypeLong = kCFNumberLongType,
	GtDataTypeLongLong = kCFNumberLongLongType,
	GtDataTypeFloat = kCFNumberFloatType,
	GtDataTypeDouble = kCFNumberDoubleType,
	
	// numbers
	GtDataTypeEnum,
	GtDataTypeBool,
	GtDataTypeUnsignedChar,
	GtDataTypeNSInteger,
	GtDataTypeNSUInteger,
	GtDataTypeUnsignedInteger,
	GtDataTypeUnsignedShort,
	GtDataTypeUnsignedLong,
	GtDataTypeUnsignedLongLong,
//	  GtDataTypeDecimal,

// NSValue structs
	GtDataTypePoint,
	GtDataTypeRect,
	GtDataTypeSize,
	GtDataTypeValue,

// Immutable Objects	  
	GtDataTypeString,
	GtDataTypeDate,
	GtDataTypeData,
    GtDataTypeColor,
	
// generic object (id) or otherwise	
	GtDataTypeObject
} GtDataTypeID;

NS_INLINE
BOOL GtDataTypeIsNumber(GtDataTypeID type)
{
	switch(type)
	{
		case GtDataTypeNSInteger:
		case GtDataTypeNSUInteger:
		case GtDataTypeEnum:
		case GtDataTypeBool:
		case GtDataTypeChar:
		case GtDataTypeUnsignedChar:
		case GtDataTypeInteger:
		case GtDataTypeUnsignedInteger:
		case GtDataTypeLong:
		case GtDataTypeUnsignedLong:
		case GtDataTypeShort:
		case GtDataTypeUnsignedShort:
        case GtDataTypeUnsignedLongLong:
		case GtDataTypeLongLong:
        case GtDataTypeFloat:
		case GtDataTypeDouble:
			return YES;
			
        case GtDataTypePoint:
        case GtDataTypeRect:
        case GtDataTypeSize:
        case GtDataTypeValue:
        case GtDataTypeUnknown:
		case GtDataTypeString:
        case GtDataTypeDate:
        case GtDataTypeData:
        case GtDataTypeColor:
        case GtDataTypeObject:
            return NO;

	}

	return NO;
}

NS_INLINE
BOOL GtDataTypeIsValue(GtDataTypeID type)
{
	switch(type)
	{
		case GtDataTypePoint:
		case GtDataTypeRect:
		case GtDataTypeSize:
		case GtDataTypeValue:
			return YES;

		case GtDataTypeNSInteger:
		case GtDataTypeNSUInteger:
		case GtDataTypeEnum:
		case GtDataTypeBool:
		case GtDataTypeChar:
		case GtDataTypeUnsignedChar:
		case GtDataTypeInteger:
		case GtDataTypeUnsignedInteger:
		case GtDataTypeLong:
		case GtDataTypeUnsignedLong:
		case GtDataTypeShort:
		case GtDataTypeUnsignedShort:
		case GtDataTypeUnsignedLongLong:
		case GtDataTypeLongLong:
		case GtDataTypeFloat:
		case GtDataTypeDouble:
        case GtDataTypeUnknown:
		case GtDataTypeString:
        case GtDataTypeDate:
        case GtDataTypeData:
        case GtDataTypeColor:
        case GtDataTypeObject:
            return NO;
	}

	return NO;
}

NS_INLINE
BOOL GtDataTypeIsObject(GtDataTypeID type)
{
	switch(type)
	{
		case GtDataTypeObject:
		case GtDataTypeString:
		case GtDataTypeDate:
		case GtDataTypeData:
        case GtDataTypeColor:
			return YES;

		case GtDataTypePoint:
		case GtDataTypeRect:
		case GtDataTypeSize:
		case GtDataTypeValue:
		case GtDataTypeNSInteger:
		case GtDataTypeNSUInteger:
		case GtDataTypeEnum:
		case GtDataTypeBool:
		case GtDataTypeChar:
		case GtDataTypeUnsignedChar:
		case GtDataTypeInteger:
		case GtDataTypeUnsignedInteger:
		case GtDataTypeLong:
		case GtDataTypeUnsignedLong:
		case GtDataTypeShort:
		case GtDataTypeUnsignedShort:
		case GtDataTypeUnsignedLongLong:
		case GtDataTypeLongLong:
		case GtDataTypeFloat:
		case GtDataTypeDouble:
        case GtDataTypeUnknown:
            return NO;
	}
	
	return NO;
}



