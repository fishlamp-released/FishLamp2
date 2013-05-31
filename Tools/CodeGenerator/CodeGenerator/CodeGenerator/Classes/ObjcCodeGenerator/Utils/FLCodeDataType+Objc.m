//
//  FLCodeDataType+ObjC.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 3/16/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCodeDataType+ObjC.h"
#if REFACTOR

@implementation FLCodeDataType (Objc)



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
//
//+ (NSString*) convertToKnownTypeString:(NSString*) string;

@end


NSString* FLObjCTypeStringFromDataType(FLDataTypeID dataType)
{
//	switch(dataType.specificType)
//	{
//	// numbers
//        case FLSpecificTypeChar: return @"char";
//        case FLSpecificTypeUnsignedChar: return @"unsigned char";
//		case FLSpecificTypeBool: return @"BOOL";
//		case FLSpecificTypeEnum: return @"enum";
//		case FLSpecificTypeInt: return @"int";
//		case FLSpecificTypeUnsignedInt: return @"unsigned int";
//		case FLSpecificTypeLong: return @"long";
//		case FLSpecificTypeUnsignedLong: return @"unsigned long";
//		case FLSpecificTypeFloat: return @"float";
//		case FLSpecificTypeDouble: return @"double";
////		case FLSpecificTypeNSInteger: return @"NSInteger";
////		case FLSpecificTypeNSUInteger: return @"NSUInteger";
//		case FLSpecificTypeShort: return @"short";
//		case FLSpecificTypeUnsignedShort: return @"unsigned short";
//		case FLSpecificTypeUnsignedLongLong: return @"unsigned long long";
//		case FLSpecificTypeLongLong: return @"long long";
//		   
//	// structs
//		case FLSpecificTypeRect: return @"CGRect";
//		case FLSpecificTypeSize: return @"CGSize";
//		case FLSpecificTypePoint: return @"CGPoint";
//
//	// objects
//		case FLSpecificTypeObject: return @"id";
//		case FLSpecificTypeString: return @"NSString";
//		case FLSpecificTypeValue: return @"NSValue";
//		case FLSpecificTypeDate: return @"NSDate";
//		case FLSpecificTypeData: return @"NSData";
//        case FLSpecificTypeColor: return @"UIColor";
//        case FLSpecificTypeURL: return @"NSURL";
//
//        case FLSpecificTypeUnknown:
//            
//        break;
//	}

	return nil;
}

NSString* FLSpecificTypeIDStringFromDataType(FLDataTypeID type)
{
//	switch(type.specificType)
//	{
//		case FLDataTypeChar: return @"FLDataTypeChar";
//        case FLDataTypeUnsignedChar: return @"FLDataTypeUnsignedChar";
//		case FLDataTypeBool: return @"FLDataTypeBool";
//		case FLDataTypeEnum: return @"FLDataTypeEnum";
//		case FLDataTypeInt: return @"FLDataTypeInt";
//		case FLDataTypeUnsignedInt: return @"FLDataTypeUnsignedInt";
//		case FLDataTypeLong: return @"FLDataTypeLong";
//		case FLDataTypeUnsignedLong: return @"FLDataTypeUnsignedLong";
//		case FLDataTypeFloat: return @"FLDataTypeFloat";
//		case FLDataTypeDouble: return @"FLDataTypeDouble";
//		case FLDataTypeString: return @"FLDataTypeString";
//		case FLDataTypeDate: return @"FLDataTypeDate";
//		case FLDataTypeData: return @"FLDataTypeData";
//		case FLDataTypeObject: return @"FLDataTypeObject";
//		case FLDataTypePoint: return @"FLDataTypePoint";
//		case FLDataTypeRect: return @"FLDataTypeRect";
//		case FLDataTypeSize: return @"FLDataTypeSize";
//		case FLDataTypeValue: return @"FLDataTypeValue";
//		case FLDataTypeNSInteger: return @"FLDataTypeNSInteger";
//		case FLDataTypeNSUInteger: return @"FLDataTypeNSUInteger";
//        case FLDataTypeColor: return @"FLDataTypeColor";
//
//		case FLDataTypeShort: return @"FLDataTypeShort";
//		case FLDataTypeUnsignedShort: return @"FLDataTypeUnsignedShort";
//		case FLDataTypeUnsignedLongLong: return @"FLDataTypeUnsignedLongLong";
//		case FLDataTypeLongLong: return @"FLDataTypeLongLong";
//        case FLDataTypeURL: return @"FLDataTypeURL";
//      
//        case FLDataTypeUnknown:
//            
//        break;
//	}

	return nil;
}

BOOL FLIsIdType(NSString* inType)
{
	return [inType hasPrefix:@"id"];
}

NSString* FLConvertToKnownType(NSString* inType)
{
//	static NSDictionary* s_dictionary = nil;
//	if(!s_dictionary)
//	{
//		s_dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
//			@"char",					@"char",
//			@"unsigned char",			 @"unsignedchar",
//			@"int",						@"int",
//			@"int",						@"integer",
//			@"NSInteger",				@"nsinteger",
//			@"NSUInteger",				@"nsuinteger",
//			
//			@"unsigned int",			@"unsignedint",
//			@"UInt32",					@"uint32",
//			@"Int32",					@"int32",
//			@"SInt32",					@"sint32",
//
//			@"long",					@"long",
//			@"unsigned long",			@"unsignedlong",
//
//			@"long long",				@"longlong",
//			@"unsigned long long",		@"unsignedlonglong",
//
//			@"short",					@"short",
//			@"unsigned short",			@"unsignedshort",
//
//			@"float",					@"float",
//			@"decimal",					@"decimal",
//			@"double",					@"double",
//
//			@"NSString",				@"string",
//			@"NSString",				@"nsstring",
//
//			@"NSDate",					@"nsdate",
//			@"NSDate",					@"date",
//			@"NSDate",					@"datetime",
//			@"id",						@"id",
//			@"id",                      @"object",
//
//			@"NSObject",				@"nsobject",
//			
//			@"NSData",					@"nsdata",
//			@"NSData",					@"base64binary",
//			@"NSData",					@"data",
//			@"NSData",					@"blob",
//			
//			@"BOOL",					@"bool",
//			@"BOOL",					@"boolean",
//			
//			@"CGPoint",					@"point",
//			@"CGPoint",					@"cgpoint",
//			@"CGPoint",					@"nspoint",
//			
//			@"CGRect",					@"rect",
//			@"CGRect",					@"cgrect",
//			@"CGRect",					@"nsrect",
//			
//			@"CGSize",					@"size",
//			@"CGSize",					@"cgsize",
//			@"CGSize",					@"nssize",
//						
//			@"NSValue",					@"value",
//			@"NSValue",					@"nsvalue",
//			
//			@"NSMutableArray",			@"array",
//			@"NSMutableArray",			@"nsarray",
//			@"NSMutableArray",			@"nsmutablearray",
//			
//			@"NSMutableDictionary",		@"dictionary",
//			@"NSMutableDictionary",		@"nsdictionary",
//			@"NSMutableDictionary",		@"nsmutabledictionary",
//			
//			@"void",					@"void",
//			
//			@"FLGuid",					@"guid",
//			@"FLGuid",					@"gtguid",
//            
//            @"UIColor",              @"cgcolor",
//            @"UIColor",              @"nscolor",
//            @"UIColor",              @"color",
//            
//            @"NSURL",                   @"url",
//            
//			nil];
//	}
//
//	inType = [inType stringByReplacingOccurrencesOfString:@" " withString:@""];
//
//	NSString* knownType = [s_dictionary objectForKey:[FLRemovePointerSplat(inType) lowercaseString]];
//
//	return	knownType ? knownType : inType;

    return nil;
}


FLDataTypeID FLDataTypeIDFromString(NSString* inString)
{
//	static NSDictionary* s_dictionary = nil;
//	if(!s_dictionary)
//	{
//		s_dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
//			[NSNumber numberWithInt:FLSpecificTypeInteger],				@"int",
//			[NSNumber numberWithInt:FLSpecificTypeNSInteger],			@"NSInteger",
//			[NSNumber numberWithInt:FLSpecificTypeNSUInteger],			@"NSUIntger",
//			[NSNumber numberWithInt:FLSpecificTypeUnsignedInteger],		@"unsigned int",
//			[NSNumber numberWithInt:FLSpecificTypeUnsignedInteger],		@"UInt32",
//			[NSNumber numberWithInt:FLSpecificTypeInteger],				@"Sint32",
//			
//			[NSNumber numberWithInt:FLSpecificTypeChar],				@"char",
//			[NSNumber numberWithInt:FLSpecificTypeUnsignedChar],		@"unsigned char",
//			[NSNumber numberWithInt:FLSpecificTypeLong],				@"long",
//			[NSNumber numberWithInt:FLSpecificTypeUnsignedLong],		@"unsigned long",
//			[NSNumber numberWithInt:FLSpecificTypeLongLong],			@"long long",
//			[NSNumber numberWithInt:FLSpecificTypeUnsignedLongLong],	@"unsigned long long",
//			[NSNumber numberWithInt:FLSpecificTypeShort],				@"short",
//			[NSNumber numberWithInt:FLSpecificTypeUnsignedShort],		@"unsigned short",
//			
//			[NSNumber numberWithInt:FLSpecificTypeFloat],				@"float",
//			[NSNumber numberWithInt:FLSpecificTypeDouble],			    @"decimal",
//			[NSNumber numberWithInt:FLSpecificTypeDouble],				@"double",
//
//			[NSNumber numberWithInt:FLSpecificTypeString],				@"NSString",
//			[NSNumber numberWithInt:FLSpecificTypeDate],				@"NSDate",
//			[NSNumber numberWithInt:FLSpecificTypeData],				@"NSData",
//			[NSNumber numberWithInt:FLSpecificTypeBool],				@"BOOL",
//	//		  [NSNumber numberWithInt:FLSpecificTypeEnum],				  @"enum",
//
//			[NSNumber numberWithInt:FLSpecificTypePoint],				@"CGPoint",
//			[NSNumber numberWithInt:FLSpecificTypeRect],				@"CGRect",
//			[NSNumber numberWithInt:FLSpecificTypeSize],				@"CGSize",
//			[NSNumber numberWithInt:FLSpecificTypeValue],				@"NSValue",
//            
//            [NSNumber numberWithInt:FLSpecificTypeColor],				@"UIColor",
//            [NSNumber numberWithInt:FLSpecificTypeURL],                 @"NSURL",
//            
//            [NSNumber numberWithInt:FLSpecificTypeObject],				@"id",
//            
//			nil];
//	}
//		
//	NSNumber* number = [s_dictionary objectForKey:FLRemovePointerSplat(inString)];
//	
//	return number ? (FLDataTypeID) [number intValue] : FLDataTypeObject;

    return FLDataTypeUnknown;
}



NSString* FLObjectTypeStringForValueType(FLDataTypeID type) {
//	if(FLDataTypeIsNumber(type)) {
//		return @"NSNumber";
//	}
//	
//	switch(type)
//	{
//		case FLDataTypeValue:
//        case FLDataTypePoint:
//		case FLDataTypeRect:
//		case FLDataTypeSize:
//			return @"NSValue";
//	
//		case FLDataTypeDate: 
//            return @"NSDate";
//		   
//		case FLDataTypeData: 
//            return @"NSData";
//
//		case FLDataTypeString:	
//            return @"NSString";
//
//		case FLDataTypeColor: 
//            return @"FLColor";
//            
//        case FLDataTypeURL:
//            return @"NSURL";
//            
//// for compiler 
//        case FLDataTypeObject: 
//        case FLDataTypeChar: 
//        case FLDataTypeUnsignedChar: 
//		case FLDataTypeBool: 
//		case FLDataTypeEnum: 
//		case FLDataTypeInteger: 
//		case FLDataTypeUnsignedInteger: 
//		case FLDataTypeLong: 
//		case FLDataTypeUnsignedLong: 
//		case FLDataTypeFloat: 
//		case FLDataTypeDouble: 
//		case FLDataTypeNSInteger: 
//		case FLDataTypeNSUInteger: ;
//		case FLDataTypeShort: 
//		case FLDataTypeUnsignedShort: 
//		case FLDataTypeUnsignedLongLong: 
//		case FLDataTypeLongLong: 
//		   
//		case FLDataTypeUnknown:
//        break;
//	}
//	
//	
	return nil;
}

NSString* FLObjcObjectTypeStringFromString(NSString* inString) {
//	FLDataTypeID type = FLDataTypeIDFromString(FLRemovePointerSplat(inString));
//
//	if(FLDataTypeIsNumber(type)) {
//		inString = @"NSNumber";
//	}
//	else
//	{
//		switch(type)
//		{
//            case FLDataTypeValue:
//			case FLDataTypePoint:
//			case FLDataTypeRect:
//			case FLDataTypeSize:
//				inString = @"NSValue";
//				break;
//		
//			case FLDataTypeDate:
//				inString = @"NSDate";
//				break;
//			
//			case FLDataTypeData:
//				inString = @"NSData";
//				break;
//		
//			case FLDataTypeString:
//				inString = @"NSString";
//				break;
//
//            case FLDataTypeColor:
//                inString = @"FLColor";
//                break;
//            
//            case FLDataTypeURL:
//                inString = @"NSURL";
//                break;
//
//// for compiler      
//            case FLDataTypeObject:
//            case FLDataTypeChar: 
//            case FLDataTypeUnsignedChar: 
//            case FLDataTypeBool: 
//            case FLDataTypeEnum: 
//            case FLDataTypeInteger: 
//            case FLDataTypeUnsignedInteger: 
//            case FLDataTypeLong: 
//            case FLDataTypeUnsignedLong: 
//            case FLDataTypeFloat: 
//            case FLDataTypeDouble: 
//            case FLDataTypeNSInteger: 
//            case FLDataTypeNSUInteger: ;
//            case FLDataTypeShort: 
//            case FLDataTypeUnsignedShort: 
//            case FLDataTypeUnsignedLongLong: 
//            case FLDataTypeLongLong: 
//               
//            case FLDataTypeUnknown:
//            break;
//
//		}
//	}

	return inString;
}



NSString* FLNumberInitForDataTypeID(FLDataTypeID dataType)
{
	NSString* init = nil;
//	switch(dataType)
//	{
//		case FLDataTypeShort:
//			init = @"initWithShort";
//		break;
//
//		case FLDataTypeUnsignedShort:
//			init = @"initWithUnsignedShort";
//		break;
//			
//		case FLDataTypeNSInteger:
//			init = @"initWithInteger";
//			break;
//            
//		case FLDataTypeInteger:
//			init = @"initWithInt";
//			break;
//			
//		case FLDataTypeNSUInteger:
//			init = @"initWithUnsignedInteger";
//		break;
//		
//		case FLDataTypeEnum:
//		case FLDataTypeUnsignedInteger:
//			init = @"initWithUnsignedInt";
//		break;
//		
//		case FLDataTypeLong:
//			init = @"initWithLong";
//		break;
//
//		case FLDataTypeUnsignedLong:
//			init = @"initWithUnsignedLong";
//		break;
//
//		case FLDataTypeLongLong:
//			init = @"initWithLongLong";
//		break;
//
//		case FLDataTypeUnsignedLongLong:
//			init = @"initWithUnsignedLongLong";
//		break;	
//		
//		case FLDataTypeFloat:
//			init = @"initWithFloat";
//		break;
//		
//		case FLDataTypeDouble:
//			init = @"initWithDouble";
//		break;
//		
//		case FLDataTypeBool:
//			init = @"initWithBool";
//		break;
//        
//        case FLDataTypeChar:
//            init = @"initWithChar";
//        break;
//
//        case FLDataTypeUnsignedChar:
//            init = @"initWithUnsignedChar";
//        break;
//
//
//// for compiler
//        case FLDataTypeURL:
//        case FLDataTypeObject:
//        case FLDataTypeValue:
//        case FLDataTypeUnknown:
//        case FLDataTypePoint:
//        case FLDataTypeRect:
//        case FLDataTypeSize:
//        case FLDataTypeDate:
//        case FLDataTypeData:
//        case FLDataTypeString:
//        case FLDataTypeColor:
//            break;
//
//			
//		
//	}

	return init;		 
}

#endif

