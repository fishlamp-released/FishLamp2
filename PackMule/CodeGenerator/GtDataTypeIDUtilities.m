//
//	GtDataTypeIDUtilities.m
//	PackMule
//
//	Created by Mike Fullerton on 4/27/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "GtDataTypeIDUtilities.h"
#import "GtCodeGenerator.h"

NSString* GtObjCTypeStringFromDataType(GtDataTypeID dataType)
{
	switch(dataType)
	{
	// numbers
		case GtDataTypeBool: return @"BOOL";
		case GtDataTypeEnum: return @"enum";
		case GtDataTypeInteger: return @"int";
		case GtDataTypeUnsignedInteger: return @"unsigned int";
		case GtDataTypeLong: return @"long";
		case GtDataTypeUnsignedLong: return @"unsigned long";
		case GtDataTypeFloat: return @"float";
		case GtDataTypeDouble: return @"double";
		case GtDataTypeNSInteger: return @"NSInteger";
		case GtDataTypeNSUInteger: return @"NSUInteger";
		case GtDataTypeShort: return @"short";
		case GtDataTypeUnsignedShort: return @"unsigned short";
		case GtDataTypeUnsignedLongLong: return @"unsigned long long";
		case GtDataTypeLongLong: return @"long long";
		   
	// structs
		case GtDataTypeRect: return @"NSRect";
		case GtDataTypeSize: return @"NSSize";
		case GtDataTypePoint: return @"NSPoint";

	// objects
		case GtDataTypeObject: return @"id";
		case GtDataTypeString: return @"NSString";
		case GtDataTypeValue: return @"NSValue";
		case GtDataTypeDate: return @"NSDate";
		case GtDataTypeData: return @"NSData";
		
		default:
			GtAssertFailed(@"unknown type");
	}

	return nil;
}

NSString* GtDataTypeIDStringFromDataType(GtDataTypeID type)
{
	switch(type)
	{
		case GtDataTypeBool: return @"GtDataTypeBool";
		case GtDataTypeEnum: return @"GtDataTypeEnum";
		case GtDataTypeInteger: return @"GtDataTypeInteger";
		case GtDataTypeUnsignedInteger: return @"GtDataTypeUnsignedInteger";
		case GtDataTypeLong: return @"GtDataTypeLong";
		case GtDataTypeUnsignedLong: return @"GtDataTypeUnsignedLong";
		case GtDataTypeFloat: return @"GtDataTypeFloat";
		case GtDataTypeDouble: return @"GtDataTypeDouble";
		case GtDataTypeString: return @"GtDataTypeString";
		case GtDataTypeDate: return @"GtDataTypeDate";
		case GtDataTypeData: return @"GtDataTypeData";
		case GtDataTypeObject: return @"GtDataTypeObject";
		case GtDataTypePoint: return @"GtDataTypePoint";
		case GtDataTypeRect: return @"GtDataTypeRect";
		case GtDataTypeSize: return @"GtDataTypeSize";
		case GtDataTypeValue: return @"GtDataTypeValue";
		case GtDataTypeNSInteger: return @"GtDataTypeNSInteger";
		case GtDataTypeNSUInteger: return @"GtDataTypeNSUInteger";
	  
		default:
			GtAssertFailed(@"unknown data type");
	}

	return nil;
}

BOOL GtIsIdType(NSString* inType)
{
	return [inType hasPrefix:@"id"];
}

//BOOL GtTypeStringIsObject(NSString* inType, GtCodeGenerator* generator)
//{
//	  static NSSet* s_list = nil;
//	  if(!s_list)
//	  {
//		  s_list = [[NSSet alloc] initWithObjects:
//			  @"char"
//			  @"unsigned char",
//			  @"int",
//			  @"integer",
//			  @"NSInteger",
//			  @"NSUInteger",
//			  @"unsigned int",
//			  @"UInt32",
//			  @"Int32",
//			  @"SInt32",
//			  @"long",
//			  @"unsigned long",
//			  @"long long",
//			  @"unsigned long long",
//			  @"short",
//			  @"unsigned short",
//			  @"float",
//			  @"decimal",
//			  @"double",
//			  @"BOOL",
//			  @"CGPoint",
//			  @"CGRect",
//			  @"CGSize",
//			  @"NSPoint",
//				@"NSRect",
//				@"NSSize",
//			  @"void",
//			  @"id",
//			  @"_GtDataTypeStruct",
//			  nil];
//	  }
//	  
//	  inType = GtRemovePointerSplat(inType);
//	  
//	  for(GtCodeGeneratorEnumType* e in generator.schema.enumTypesXXXXX)
//	  {
//		if(GtStringsAreEqual([generator getTypeName:e.name], inType))
//		  {
//			return NO;
//		  }
//	  }
//	  
//	  if([generator.schema.externallyDefinedEnums indexOfObject:inType] != NSNotFound)
//	  {
//		return NO;
//	  }
//	  
//	  if([inType rangeOfString:@"id<"].length > 0)
//	  {
//		return NO;
//	  }
//	  
//	  return [s_list member:inType] == nil;												   
//}

NSString* GtConvertToKnownType(NSString* inType)
{
	static NSDictionary* s_dictionary = nil;
	if(!s_dictionary)
	{
		s_dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
			@"char",					@"char",
			@"unsigned char",			 @"unsignedchar",
			@"int",						@"int",
			@"int",						@"integer",
			@"NSInteger",				@"nsinteger",
			@"NSUInteger",				@"nsuinteger",
			
			@"unsigned int",			@"unsignedint",
			@"UInt32",					@"uint32",
			@"Int32",					@"int32",
			@"SInt32",					@"sint32",

			@"long",					@"long",
			@"unsigned long",			@"unsignedlong",

			@"long long",				@"longlong",
			@"unsigned long long",		@"unsignedlonglong",

			@"short",					@"short",
			@"unsigned short",			@"unsignedshort",

			@"float",					@"float",
			@"decimal",					@"decimal",
			@"double",					@"double",

			@"NSString",				@"string",
			@"NSString",				@"nsstring",

			@"NSDate",					@"nsdate",
			@"NSDate",					@"date",
			@"NSDate",					@"datetime",
			@"id",						@"id",
			@"NSObject",				@"object",
			@"NSObject",				@"nsobject",
			
			@"NSData",					@"nsdata",
			@"NSData",					@"base64binary",
			@"NSData",					@"data",
			@"NSData",					@"blob",
			
			@"BOOL",					@"bool",
			@"BOOL",					@"boolean",
			
			@"NSPoint",					@"point",
			@"NSPoint",					@"cgpoint",
			@"NSPoint",					@"nspoint",
			
			@"NSRect",					@"rect",
			@"NSRect",					@"cgrect",
			@"NSRect",					@"nsrect",
			
			@"NSSize",					@"size",
			@"NSSize",					@"cgsize",
			@"NSSize",					@"nssize",
						
			@"NSValue",					@"value",
			@"NSValue",					@"nsvalue",
			
			@"NSMutableArray",			@"array",
			@"NSMutableArray",			@"nsarray",
			@"NSMutableArray",			@"nsmutablearray",
			
			@"NSMutableDictionary",		@"dictionary",
			@"NSMutableDictionary",		@"nsdictionary",
			@"NSMutableDictionary",		@"nsmutabledictionary",
			
			@"void",					@"void",
			
			@"GtGuid",					@"guid",
			@"GtGuid",					@"gtguid",
			
			nil];
	}

	inType = [inType stringByReplacingOccurrencesOfString:@" " withString:@""];

	NSString* knownType = [s_dictionary objectForKey:[GtRemovePointerSplat(inType) lowercaseString]];

	return	knownType ? knownType : inType;
}


GtDataTypeID GtDataTypeIDFromString(NSString* inString)
{
	static NSDictionary* s_dictionary = nil;
	if(!s_dictionary)
	{
		s_dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
			[NSNumber numberWithInt:GtDataTypeInteger],				@"int",
			[NSNumber numberWithInt:GtDataTypeNSInteger],			@"NSInteger",
			[NSNumber numberWithInt:GtDataTypeNSUInteger],			@"NSUIntger",
			[NSNumber numberWithInt:GtDataTypeUnsignedInteger],		@"unsigned int",
			[NSNumber numberWithInt:GtDataTypeUnsignedInteger],		@"UInt32",
			[NSNumber numberWithInt:GtDataTypeInteger],				@"Sint32",
			
			[NSNumber numberWithInt:GtDataTypeChar],				@"char",
			[NSNumber numberWithInt:GtDataTypeUnsignedChar],		@"unsigned char",
			[NSNumber numberWithInt:GtDataTypeLong],				@"long",
			[NSNumber numberWithInt:GtDataTypeUnsignedLong],		@"unsigned long",
			[NSNumber numberWithInt:GtDataTypeLongLong],			@"long long",
			[NSNumber numberWithInt:GtDataTypeUnsignedLongLong],	@"unsigned long long",
			[NSNumber numberWithInt:GtDataTypeShort],				@"short",
			[NSNumber numberWithInt:GtDataTypeUnsignedShort],		@"unsigned short",
			
			[NSNumber numberWithInt:GtDataTypeFloat],				@"float",
			[NSNumber numberWithInt:GtDataTypeDouble],			   @"decimal",
			[NSNumber numberWithInt:GtDataTypeDouble],				@"double",

			[NSNumber numberWithInt:GtDataTypeString],				@"NSString",
			[NSNumber numberWithInt:GtDataTypeDate],				@"NSDate",
			[NSNumber numberWithInt:GtDataTypeData],				@"NSData",
			[NSNumber numberWithInt:GtDataTypeBool],				@"BOOL",
	//		  [NSNumber numberWithInt:GtDataTypeEnum],				  @"enum",

			[NSNumber numberWithInt:GtDataTypePoint],				@"NSPoint",
			[NSNumber numberWithInt:GtDataTypeRect],				@"NSRect",
			[NSNumber numberWithInt:GtDataTypeSize],				@"NSSize",
			[NSNumber numberWithInt:GtDataTypeValue],				@"NSValue",
			nil];
	}
		
	NSNumber* number = [s_dictionary objectForKey:GtRemovePointerSplat(inString)];
	
	return number ? (GtDataTypeID) [number intValue] : GtDataTypeObject;
}



NSString* GtObjectTypeStringForValueType(GtDataTypeID type)
{
	if(GtDataTypeIsNumber(type))
	{
		return @"NSNumber";
	}
	
	switch(type)
	{
		case GtDataTypePoint:
		case GtDataTypeRect:
		case GtDataTypeSize:
			return @"NSValue";
	
		case GtDataTypeDate:
			return @"NSDate";
		
		case GtDataTypeData:
			return @"NSData";
	
		case GtDataTypeString:
			return @"NSString";
			
			
		default:
			break;
	}
	
	
	return nil;
}

NSString* GtObjcObjectTypeStringFromString(NSString* inString)
{
	GtDataTypeID type = GtDataTypeIDFromString(GtRemovePointerSplat(inString));

	if(GtDataTypeIsNumber(type))
	{
		inString = @"NSNumber";
	}
	else
	{
		switch(type)
		{
			case GtDataTypePoint:
			case GtDataTypeRect:
			case GtDataTypeSize:
				inString = @"NSValue";
				break;
		
			case GtDataTypeDate:
				inString = @"NSDate";
				break;
			
			case GtDataTypeData:
				inString = @"NSData";
				break;
		
			case GtDataTypeString:
				inString = @"NSString";
				break;

			default:
				break;
		}
	}

	return inString;
}



NSString* GtNumberInitForDataTypeID(GtDataTypeID dataType)
{
	NSString* init = nil;
	switch(dataType)
	{
		case GtDataTypeShort:
			init = @"initWithShort";
		break;

		case GtDataTypeUnsignedShort:
			init = @"initWithUnsignedShort";
		break;
			
		case GtDataTypeNSInteger:
			init = @"initWithInteger";
			
		case GtDataTypeInteger:
			init = @"initWithInt";
			break;
			
		case GtDataTypeNSUInteger:
			init = @"initWithUnsignedInteger";
		break;
		
		case GtDataTypeEnum:
		case GtDataTypeUnsignedInteger:
			init = @"initWithUnsignedInt";
		break;
		
		case GtDataTypeLong:
			init = @"initWithLong";
		break;

		case GtDataTypeUnsignedLong:
			init = @"initWithUnsignedLong";
		break;

		case GtDataTypeLongLong:
			init = @"initWithLongLong";
		break;

		case GtDataTypeUnsignedLongLong:
			init = @"initWithUnsignedLongLong";
		break;	
		
		case GtDataTypeFloat:
			init = @"initWithFloat";
		break;
		
		case GtDataTypeDouble:
			init = @"initWithDouble";
		break;
		
		case GtDataTypeBool:
			init = @"initWithBool";
		break;

			default:
				break;
		
	}

	return init;		 
}

//NSString* GtAddPointerSplatIfNeeded(NSString* inType, GtCodeGenerator* generator) 
//{
//	if(GtTypeStringIsObject(inType, generator))
//	  {
//		return !GtHasPointerSplat(inType) ? [NSString stringWithFormat:@"%@*", inType] : inType;
//	  }
//	  
//	  return GtRemovePointerSplat(inType);
//}
