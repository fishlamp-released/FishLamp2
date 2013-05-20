//
//	GtCodeGeneratorObjectMore.m
//	PackMule
//
//	Created by Mike Fullerton on 4/18/10.
//	Copyright 2010 Greentongue Software. All rights reserved.
//

#import "GtCodeGeneratorObject.h"
#import "GtCodeGeneratorPropertyMore.h"
#import "GtCodeGeneratorMethodMore.h"
#import "GtCodeGeneratorCodeSnippetMore.h"
#import "GtCodeGeneratorEnumTypeMore.h"
#import "GtKeyValuePair.h"
#import "GtCodeGeneratorStorageOptions+CodeFile.h"

#import "GtCodeGeneratorObjectMore.h"

@interface NSMutableDictionary (More)
- (void) setObjectOrFail:(id) object forKey:(id) key;
@end

//@interface NSMutableArray (More)
//- (void) addUniqueObject:(id) object;
//@end


@implementation NSMutableDictionary (More)

- (void) setObjectOrFail:(id) object forKey:(id) key
{
	if([self objectForKey:key] != nil)
	{
		GtFail(GtCodeGeneratorErrorDomain, GtCodeGeneratorErrorCodeItemExists, @"Item exists already: %@", key);
	}
	
	[self setObject:object forKey:key];
}

@end




@implementation GtCodeGeneratorObject (More)


- (NSString*) typeDescriptorNameForProperty:(NSString*) name
{
/*
	if(prop.arrayTypes && prop.arrayTypes.count > 0)
	{
		 return [NSString stringWithFormat:@"s_%@ArrayTypeDescriptor%d", prop.name, prop.arrayTypes.count - 1];
	}
 */	   
	return [NSString stringWithFormat:@"s_%@TypeDescriptor", name];
}

- (void) setTypeName:(NSString*) type
{
	[super setTypeName:type];
	
	if(GtStringIsEmpty(self.name))
	{
		self.name = type;
	}
}

- (void) addCopySelfToMethod:(GtObjectiveCCodeGenerator*) generator storageProperties:(NSMutableDictionary*) storageProperties
{
	GtCodeGeneratorMethod* method = [GtCodeGeneratorMethod codeGeneratorMethod];
	method.name = @"copySelfTo";
	method.isPrivate = [NSNumber numberWithBool:YES];
	method.isStatic = [NSNumber numberWithBool:NO];
	[self.methods addUniqueObject:method];
	
	GtCodeGeneratorVariable* parameter = [GtCodeGeneratorVariable codeGeneratorVariable];
	parameter.name = @"object";
	parameter.typeName = @"id";
	[method.parameters addObject:parameter];
	
	GtStringBuilder* builder = [GtStringBuilder stringBuilder];
	[builder appendLine:@"[super copySelfTo:object];"];
	
//	[builder appendLineWithFormat:@"%@* destObject = object;", self.typeName];
	
	for(GtCodeGeneratorProperty* prop in storageProperties.objectEnumerator)
	{	
		if(	!prop.isStatic.boolValue && 
			!prop.isImmutable)
		{
			[builder appendLineWithFormat:@"((%@*)object).%@ = GtCopyOrRetainObject(%@);", self.typeName, prop.getterName, prop.memberName];
		}
	}

	method.code.lines = [builder toString];
}

- (void) addCopyMethod:(GtObjectiveCCodeGenerator*) generator
{
	GtCodeGeneratorMethod* method = [GtCodeGeneratorMethod codeGeneratorMethod];
	method.name = @"copyWithZone";
	method.isPrivate = [NSNumber numberWithBool:YES];
	method.isStatic = [NSNumber numberWithBool:NO];
	method.returnType = @"id";
	[self.methods addUniqueObject:method];
	
	GtCodeGeneratorVariable* parameter = [GtCodeGeneratorVariable codeGeneratorVariable];
	parameter.name = @"zone";
	parameter.typeName = @"NSZone";
	[method.parameters addObject:parameter];
	
	GtStringBuilder* builder = [GtStringBuilder stringBuilder];
	[builder appendLine:@"id outObject = [[[self class] alloc] init];"];
	[builder appendLine:@"[self copySelfTo:outObject];"];
	[builder appendLine:@"return outObject;"];
	method.code.lines = [builder toString];
}



- (GtCodeGeneratorVariable*) memberByName:(NSString*) memberName
{
	for(GtCodeGeneratorObjectMemberType* member in self.members)
	{
		if([member.name isEqualToString:memberName])
		{
			return member;
		}
	}
	return nil;
}

- (void) addIsEqualMethod:(NSMutableDictionary*) storageProperties
{
	NSMutableArray* equalityProperties = [NSMutableArray array];
	
	for(NSString* key in storageProperties)
	{
		GtCodeGeneratorProperty* prop = [storageProperties objectForKey:key];
		if(prop.useForEquality.boolValue)
		{
			[equalityProperties addUniqueObject:prop];
		}
	}
	
	if(equalityProperties.count)
	{
		{
			GtCodeGeneratorMethod* method = [GtCodeGeneratorMethod codeGeneratorMethod];
			method.name = @"isEqual";
			method.isPrivate = [NSNumber numberWithBool:YES];
			method.returnType = @"BOOL";
			[self.methods addUniqueObject:method];
			
			GtCodeGeneratorVariable* parameter = [GtCodeGeneratorVariable codeGeneratorVariable];
			parameter.name = @"object";
			parameter.typeName = @"id";
			[method.parameters addUniqueObject:parameter];
		
			GtStringBuilder* builder = [GtStringBuilder stringBuilder];
			[builder appendString:@"return [object isKindOfClass:[self class]]"]; 
			
			for(GtCodeGeneratorProperty* prop in equalityProperties)
			{
				[builder appendFormat:@" && [[object %@] isEqual:[self %@]]", prop.name, prop.name];
			}
			
			[builder appendLine:@";"];
			method.code.lines = [builder toString];
		}
		
		{
			GtCodeGeneratorMethod* hashMethod = [GtCodeGeneratorMethod codeGeneratorMethod];
			hashMethod.name = @"hash";
			hashMethod.isPrivate = [NSNumber numberWithBool:YES];
			hashMethod.returnType = @"NSUInteger";
			[self.methods addUniqueObject:hashMethod];
			
			GtStringBuilder* builder = [GtStringBuilder stringBuilder];
			[builder appendString:@"return"]; 
			int count = 0;
			for(GtCodeGeneratorProperty* prop in equalityProperties)
			{
				[builder appendFormat:@" %@[[self %@] hash]", count++ > 0 ? @"+ " : @"", prop.name];
			}
			
			[builder appendLine:@";"];
			hashMethod.code.lines = [builder toString];
		}
	}
}

//- (void) addOnCopyToMethod:(GtObjectiveCCodeGenerator*) generator storageProperties:(NSMutableDictionary*) storageProperties
//{
//	  GtCodeGeneratorMethod* method = [[GtCodeGeneratorMethod alloc] init];
//	  method.name = @"onCopyTo";
//	  method.options.isPrivate = [NSNumber numberWithBool:YES];
//	  method.isStatic = [NSNumber numberWithBool:NO];
//	  [self.methods addUniqueObject:method];
//	  [method release];
//	  
//	  GtCodeGeneratorVariable* parameter = [[GtCodeGeneratorVariable alloc] init];
//	  parameter.name = @"object";
//	  parameter.type = self.type;
//	  [method.parameters addUniqueObject:parameter];
//	  [parameter release];
//	  
//	  method.code.scopedBy = [method declaration:generator];
//	  GtStringBuilder* builder = [GtStringBuilder stringBuilder];
//	  for(NSString* key in storageProperties)
//	  {
//		  GtCodeGeneratorProperty* property = [storageProperties objectForKey:key];
//		  
//		  if(!property.isReadOnly.boolValue && !property.isImmutable.boolValue && !property.isStatic.boolValue && GtStringIsNotEmpty(property.memberName))
//		  {
//			  GtCodeGeneratorVariable* memberVariable = [self memberByName:property.memberName];
//			  
//		  //	[builder appendLineWithFormat:@"GtCopyObject(&%@, 
//			  
//			  if([property.type rangeOfString:@"Mutable"].length > 0)
//			  {
//				  [builder appendLineWithFormat:@"object.%@ = [[%@ mutableCopy] autorelease];", property.getterName, memberVariable.name];
//			  }
//			  else
//			  {
//				  [builder appendLineWithFormat:@"object.%@ = [[%@ copy] autorelease];", property.getterName, memberVariable.name];
//			  }
//		  }
//	  
//	  }
//	  
//	  [builder appendLine:@"[super onCopyTo:object];"];
//	  
//	  method.code.lines = [builder toString];
//}

- (void) addEncodeMethod:(NSMutableDictionary*) storageProperties
{
	GtCodeGeneratorMethod* method = [GtCodeGeneratorMethod codeGeneratorMethod];
	method.name = @"encodeWithCoder";
	method.isPrivate = [NSNumber numberWithBool:YES];
	[self.methods addUniqueObject:method];
	
	GtCodeGeneratorVariable* parameter = [GtCodeGeneratorVariable codeGeneratorVariable];
	parameter.name = @"aCoder";
	parameter.typeName = @"NSCoder";
	[method.parameters addUniqueObject:parameter];

	GtStringBuilder* builder = [GtStringBuilder stringBuilder];
	for(GtCodeGeneratorObjectMemberType* member in self.members)
	{
		if(!member.isStatic.boolValue)
		{
			[builder appendLineWithFormat:@"if(%@) [aCoder encodeObject:%@ forKey:@\"%@\"];", member.name, member.name, member.name];
		}
	}
	
	if([self.superclass rangeOfString:@"NSObject"].length == 0)
	{
		[builder appendLine:@"[super encodeWithCoder:aCoder];"];
	}
	
	method.code.lines = [builder toString];
}

- (void) addDecodeMethod:(NSMutableDictionary*) storageProperties
{
	GtCodeGeneratorMethod* method = [GtCodeGeneratorMethod codeGeneratorMethod];
	method.name = @"initWithCoder";
	method.isPrivate = [NSNumber numberWithBool:YES];
	method.returnType = @"id";
	[self.methods addUniqueObject:method];
	
	GtCodeGeneratorVariable* parameter = [GtCodeGeneratorVariable codeGeneratorVariable];
	parameter.name = @"aDecoder";
	parameter.typeName = @"NSCoder";
	[method.parameters addUniqueObject:parameter];
	
	GtStringBuilder* builder = [GtStringBuilder stringBuilder];
	
	if([self.superclass rangeOfString:@"NSObject"].length == 0)
	{
		[builder appendLine:@"if((self = [super initWithCoder:aDecoder]))"];
	}
	else
	{
		[builder appendLine:@"if((self = [super init]))"];
	}
	
	[builder appendLine:@"{"];
	[builder tabIn];
	
	for(GtCodeGeneratorObjectMemberType* member in self.members)
	{
		if(!member.isStatic.boolValue)
		{
			if([member.typeName rangeOfString:@"Mutable"].length > 0)
			{
				[builder appendLineWithFormat:@"%@ = [[aDecoder decodeObjectForKey:@\"%@\"] mutableCopy];", member.name, member.name];
			}
			else
			{
				[builder appendLineWithFormat:@"%@ = [[aDecoder decodeObjectForKey:@\"%@\"] retain];", member.name, member.name];
			}
		
		}
	}
	[builder tabOut];
	[builder appendLine:@"}"];
	
	
	[builder appendLine:@"return self;"];
	
	method.code.lines = [builder toString];
}

//- (void) addCreatePropertyMethod:(GtObjectiveCCodeGenerator*) generator property:(GtCodeGeneratorProperty*) property
//{
//	GtCodeGeneratorMethod* method = [GtCodeGeneratorMethod codeGeneratorMethod];
//	method.name = [NSString stringWithFormat:@"create%@", [property.name stringWithUpperCaseFirstLetter]];
//	method.options.isPrivate.boolValue NO;
//	method.isStatic = [NSNumber numberWithBool:NO];
//	method.returnType = @"void";
//	[self.methods addUniqueObject:method];
//	
//	GtStringBuilder* builder = [GtStringBuilder stringBuilder];
//	[builder appendLineWithFormat:@"if(!%@) {", property.memberName];
//	[builder tabIn];
//	[builder appendLineWithFormat:@"%@ = [[%@ alloc] init];", property.memberName, property.type];
//	[builder tabOut];
//	[builder appendLine:@"}"];
//	method.code.lines = [builder toString];
//}

- (void) addDependency:(NSString*) item generator:(GtObjectiveCCodeGenerator*) generator
{
	for(GtCodeGeneratorTypeDefinition* aDef in self.dependencies)
	{
		if(GtStringsAreEqual(aDef.typeName, item))
		{
			return;
		}
	}	

	[self.dependencies addUniqueObject:[generator typeForName:item]];
}


- (void) addDescriberMethod:(GtObjectiveCCodeGenerator*) generator
{
	[self addDependency:@"GtObjectDescriber" generator:generator];

	GtCodeGeneratorMethod* method = [GtCodeGeneratorMethod codeGeneratorMethod];
	method.name = @"sharedObjectDescriber";
	method.returnType = @"GtObjectDescriber";
	method.isPrivateValue = YES;
	method.isStaticValue = YES;
	
	GtStringBuilder* builder = [GtStringBuilder stringBuilder];
	[builder appendLine:@"static GtObjectDescriber* s_describer = nil;"];
	[builder appendLine:@"if(!s_describer)"];
	[builder appendLine:@"{"];
	[builder tabIn];
	[builder appendLine:@"@synchronized(self) {"];
	[builder tabIn];
	[builder appendLine:@"if(!s_describer)"];
	[builder appendLine:@"{"];
	[builder tabIn];
		
	[builder appendLineWithFormat:@"s_describer = [[super sharedObjectDescriber] copy];"];
	
	[builder appendLineWithFormat:@"if(!s_describer)"];
	[builder appendLine:@"{"];
	[builder tabIn];
	[builder appendLine:@"s_describer = [[GtObjectDescriber alloc] init];"];
	[builder tabOut];
	[builder appendLine:@"}"];

	for(GtCodeGeneratorProperty* prop in self.properties)
	{
		if(	!prop.isStatic && 
			!prop.isImmutable && 
			!prop.isReadOnly)
		{
			GtDataTypeID typeId = GtDataTypeIDFromString(prop.originalType);
			NSString* objectType = GtObjectTypeStringForValueType(typeId);
			if(!objectType)
			{
				objectType = prop.type;
			}

			if(prop.arrayTypes.count)
			{
				NSMutableArray* arrayTypes = [NSMutableArray array];
				NSString* arrayTypesStr = @"nil";
			
				for(GtCodeGeneratorArrayType* type in prop.arrayTypes)
				{
					[arrayTypes addObject:[NSString stringWithFormat:@"[GtPropertyDescription propertyDescription:@\"%@\" propertyClass:[%@ class] propertyType:%@ arrayTypes:nil]",
						type.name,
						type.typeName,
						GtDataTypeIDStringFromDataType(GtDataTypeIDFromString(GtConvertToKnownType(type.originalType)))]];
				}
				
				if(arrayTypes.count)
				{
					[arrayTypes addObject:@"nil"];
					
					arrayTypesStr = [NSString stringWithFormat:@"[NSArray arrayWithObjects:%@]", [NSString concatStringArray:arrayTypes]];
				}
			
				[builder appendLineWithFormat:
					@"[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@\"%@\" propertyClass:[%@ class] propertyType:%@ arrayTypes:%@ isUnboundedArray:%@] forPropertyName:@\"%@\"];", 
						prop.name,
						objectType,
						GtDataTypeIDStringFromDataType(typeId),
						arrayTypesStr,
						prop.isWildcardArrayValue ? @"YES" : @"NO",
						prop.name
						];

			
			}
			else
			{
				[builder appendLineWithFormat:
					@"[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@\"%@\" propertyClass:[%@ class] propertyType:%@] forPropertyName:@\"%@\"];", 
						prop.name,
						objectType,
						GtDataTypeIDStringFromDataType(typeId),
						prop.name];
			}
			
			
		
		
//			[builder appendLineWithFormat:@"[table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@\"%@\" columnType:%@ columnConstraints:%@ columnIndex:%@]];", 
//				prop.name,
//				type,
//				constraintsStr,
//				indexStr];
		}
	
	}

	[builder tabOut];
	[builder appendLine:@"}"];
	[builder tabOut];
	[builder appendLine:@"}"];
	[builder tabOut];
	[builder appendLine:@"}"];
	
	[builder appendLine:@"return s_describer;"];
	
	method.code.lines = [builder toString];

	[self.methods addObject:method];

}

- (void) addObjectInflatorMethod:(GtObjectiveCCodeGenerator*) generator
{
	[self addDependency:@"GtObjectInflator"  generator:generator];

	GtCodeGeneratorMethod* method = [GtCodeGeneratorMethod codeGeneratorMethod];
	method.name = @"sharedObjectInflator";
	method.returnType = @"GtObjectInflator";
	method.isPrivateValue = YES;
	method.isStaticValue = YES;
	
	GtStringBuilder* builder = [GtStringBuilder stringBuilder];
	[builder appendLine:@"static GtObjectInflator* s_inflator = nil;"];
	[builder appendLine:@"if(!s_inflator)"];
	[builder appendLine:@"{"];
	[builder tabIn];
	[builder appendLine:@"@synchronized(self) {"];
	[builder tabIn];
	[builder appendLine:@"if(!s_inflator)"];
	[builder appendLine:@"{"];
	[builder tabIn];
		
	[builder appendLine:@"s_inflator = [[GtObjectInflator alloc] initWithObjectDescriber:[[self class] sharedObjectDescriber]];"];
	[builder tabOut];
	[builder appendLine:@"}"];

	[builder tabOut];
	[builder appendLine:@"}"];
	[builder tabOut];
	[builder appendLine:@"}"];
	
	[builder appendLine:@"return s_inflator;"];
	
	method.code.lines = [builder toString];

	[self.methods addObject:method];

}


//- (void) addPropertyDescriptionsMethod:(GtObjectiveCCodeGenerator*) generator
//{
//	[self addDependency:@"GtPropertyDescription"  generator:generator];
//
//	GtCodeGeneratorMethod* method = [GtCodeGeneratorMethod codeGeneratorMethod];
//	method.name = @"propertyDescriptions";
//	method.returnType = @"NSDictionary";
//	method.isPrivateValue = YES;
//	method.isStaticValue = YES;
//	
//	GtStringBuilder* builder = [GtStringBuilder stringBuilder];
//	[builder appendLine:@"static NSMutableDictionary* s_descriptions = nil;"];
//	[builder appendLine:@"if(!s_descriptions)"];
//	[builder appendLine:@"{"];
//	[builder tabIn];
//	[builder appendLine:@"@synchronized(self) {"];
//	[builder tabIn];
//	[builder appendLine:@"if(!s_descriptions)"];
//	[builder appendLine:@"{"];
//	[builder tabIn];
//		
//	[builder appendLineWithFormat:@"s_descriptions = [[super propertyDescriptions] mutableCopy];"];
//	
//	[builder appendLineWithFormat:@"if(!s_descriptions)"];
//	[builder appendLine:@"{"];
//	[builder tabIn];
//	[builder appendLine:@"s_descriptions = [[NSMutableDictionary alloc] init];"];
//	[builder tabOut];
//	[builder appendLine:@"}"];
//
//	for(GtCodeGeneratorProperty* prop in self.properties)
//	{
//		if(	!prop.isStatic && 
//			!prop.isImmutable && 
//			!prop.isReadOnly)
//		{
//			GtDataTypeID typeId = GtDataTypeIDFromString(prop.originalType);
//			NSString* objectType = GtObjectTypeStringForValueType(typeId);
//			if(!objectType)
//			{
//				objectType = prop.type;
//			}
//			
//			if(GtStringsAreEqual(prop.name, @"Keywords"))
//			{
//				GtLog(@"yo");
//			}
//			
//			NSMutableArray* arrayTypes = [NSMutableArray array];
//			NSString* arrayTypesStr = @"nil";
//			
//			if(prop.arrayTypes.count)
//			{
//				for(GtCodeGeneratorArrayType* type in prop.arrayTypes)
//				{
//					[arrayTypes addObject:[NSString stringWithFormat:@"[GtPropertyDescription propertyDescription:@\"%@\" propertyClass:[%@ class] propertyType:%@ arrayTypes:nil]",
//						type.name,
//						type.typeName,
//						GtDataTypeIDStringFromDataType(GtDataTypeIDFromString(type.originalType))]];
//				}
//				
//				if(arrayTypes.count)
//				{
//					[arrayTypes addObject:@"nil"];
//					
//					arrayTypesStr = [NSString stringWithFormat:@"[NSArray arrayWithObjects:%@]", [NSString concatStringArray:arrayTypes]];
//				}
//			}
//			
//			
//			[builder appendLineWithFormat:
//				@"[s_descriptions setObject:[GtPropertyDescription propertyDescription:@\"%@\" propertyClass:[%@ class] propertyType:%@ arrayTypes:%@] forKey:@\"%@\"];", 
//					prop.name,
//					objectType,
//					GtDataTypeIDStringFromDataType(typeId),
//					arrayTypesStr,
//					prop.name];
//			
//		
//		
////			[builder appendLineWithFormat:@"[table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@\"%@\" columnType:%@ columnConstraints:%@ columnIndex:%@]];", 
////				prop.name,
////				type,
////				constraintsStr,
////				indexStr];
//		}
//	
//	}
//
//	[builder tabOut];
//	[builder appendLine:@"}"];
//	[builder tabOut];
//	[builder appendLine:@"}"];
//	[builder tabOut];
//	[builder appendLine:@"}"];
//	
//	[builder appendLine:@"return s_descriptions;"];
//	
//	method.code.lines = [builder toString];
//
//	[self.methods addObject:method];
//
//}

- (void) addSqlTableMethod:(GtObjectiveCCodeGenerator*) generator
{
	[self addDependency:@"GtSqliteTable"  generator:generator];
	
	GtCodeGeneratorMethod* method = [GtCodeGeneratorMethod codeGeneratorMethod];
	method.name = @"sharedSqliteTable";
	method.returnType = @"GtSqliteTable";
	method.isPrivateValue = YES;
	method.isStaticValue = YES;
	
	GtStringBuilder* builder = [GtStringBuilder stringBuilder];

	[builder appendLine:@"static GtSqliteTable* s_table = nil;"];
	[builder appendLine:@"if(!s_table)"];
	[builder appendLine:@"{"];
	[builder tabIn];
	[builder appendLine:@"@synchronized(self) {"];
	[builder tabIn];
	[builder appendLine:@"if(!s_table)"];
	[builder appendLine:@"{"];
	[builder tabIn];
	[builder appendLineWithFormat:@"GtSqliteTable* superTable = [super sharedSqliteTable];"];
	[builder appendLineWithFormat:@"if(superTable)"];
	[builder appendLine:@"{"];
	[builder tabIn];
	[builder appendLineWithFormat:@"s_table = [superTable copy];"];
	[builder appendLineWithFormat:@"s_table.tableName = [self sqliteTableName];"];
	[builder tabOut];
	[builder appendLine:@"}"];
	[builder appendLine:@"else"];
	[builder appendLine:@"{"];
	[builder tabIn];
	[builder appendLineWithFormat:@"s_table = [[GtSqliteTable alloc] initWithTableName:[self sqliteTableName]];"];
	[builder tabOut];
	[builder appendLine:@"}"];

	for(GtCodeGeneratorProperty* prop in self.properties)
	{
		if(	!prop.isStatic && 
			!prop.isImmutable && 
			!prop.isReadOnly &&
			prop.storageOptions.isStorableValue)
		{
			NSString* type = @"GtSqliteTypeText";
			NSString* constraintsStr = @"nil";
		
			if(prop.storageOptions.isPrimaryKey)
			{
				constraintsStr = @"[NSArray arrayWithObject:[GtSqliteColumn primaryKeyConstraint]]";
			}
			else
			{
				NSMutableArray* array = [NSMutableArray array];
			
				if(prop.storageOptions.isRequired)
				{
					[array addObject:@"[GtSqliteColumn notNullConstraint]"];
				}
				
				if(prop.storageOptions.isUnique)
				{
					[array addObject:@"[GtSqliteColumn uniqueConstraint]"];
				}

				if(array.count)
				{
					[array addObject:@"nil"];
				
					NSMutableString* constraints = [NSMutableString stringWithString:@"[NSArray arrayWithObjects:"];
					[constraints appendString:[NSString concatStringArray:array]];
					[constraints appendString:@"]"];
					constraintsStr = constraints;
				}

			}
			
			GtDataTypeID typeId = GtDataTypeIDFromString(prop.originalType);
			
			switch(typeId)
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
					type = @"GtSqliteTypeInteger";
					break;
					
				case GtDataTypeFloat:
				case GtDataTypeDouble:
					type = @"GtSqliteTypeFloat";
					break;

				case GtDataTypeData:
				case GtDataTypeObject:
				case GtDataTypePoint:
				case GtDataTypeRect:
				case GtDataTypeSize:
				case GtDataTypeValue:					
					type = @"GtSqliteTypeObject";
					break;
					
				case GtDataTypeString:
					type = @"GtSqliteTypeText";
					break;
				
				case GtDataTypeDate:
					type = @"GtSqliteTypeDate";
					break;	
					
				case GtDataTypeUnknown:
					GtAssertFailed(@"unknown type");
					break;
			}
		
		
			[builder appendLineWithFormat:@"[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@\"%@\" columnType:%@ columnConstraints:%@]];", 
				prop.name,
				type,
				constraintsStr];
		
		
			if(prop.storageOptions.isIndexed)
			{
				if(prop.storageOptions.isUniqueValue)
				{
					[builder appendLineWithFormat:@"[s_table addIndex:[GtSqliteIndex sqliteIndex:@\"%@\" indexProperties:GtSqliteColumnIndexPropertyUnique]];", 
						prop.name];
				}
				else
				{
					[builder appendLineWithFormat:@"[s_table addIndex:[GtSqliteIndex sqliteIndex:@\"%@\" indexProperties:GtSqliteColumnIndexPropertyNone]];", 
						prop.name];
				}
			}
		}
	}

	[builder tabOut];
	[builder appendLine:@"}"];
	[builder tabOut];
	[builder appendLine:@"}"];
	[builder tabOut];
	[builder appendLine:@"}"];

	[builder appendLine:@"return s_table;"];
	method.code.lines = [builder toString];

	[self.methods addObject:method];
}

- (void) addInitializer:(GtObjectiveCCodeGenerator*) generator
{
	GtCodeGeneratorMethod* method = [GtCodeGeneratorMethod codeGeneratorMethod];
	
	NSString* prefix = generator.schema.generatorOptions.typePrefix;
	if(GtStringIsNotEmpty(prefix) && [self.typeName hasPrefix:prefix])
	{
		method.name = [self.typeName substringFromIndex:prefix.length];
	}
	else
	{
		method.name = self.typeName;
	}
	method.name = [method.name stringWithLowercaseFirstLetter];
	method.isPrivate = [NSNumber numberWithBool:NO];
	method.isStatic = [NSNumber numberWithBool:YES];
	method.returnType = self.typeName;
	[self.methods addUniqueObject:method];
	
	method.code.lines = [NSString stringWithFormat:@"return [[[%@ alloc] init] autorelease];", self.typeName];
}

- (void) addObjectProperty:(GtCodeGenerator*) generator
	property:(GtCodeGeneratorProperty*) property
	newProperties:(NSMutableArray*) newProperties
	storageProperties:(NSMutableDictionary*) storageProperties
{	
	if(	!property.isImmutableValue && 
		![property willLazyCreate:generator] &&
		[property isValueProperty:generator])
	{
		GtAssertStringIsNotEmpty(property.name);
		GtAssertStringIsNotEmpty(property.type);
		GtAssertStringIsNotEmpty(property.memberName);
		GtAssertStringIsNotEmpty(property.originalType);
		
		GtCodeGeneratorProperty* newProp = [[property copy] autorelease];
		newProp.getter = nil;
		newProp.setter = nil;
		newProp.name = [NSString stringWithFormat:@"%@Object", property.name];
		newProp.canLazyCreate = [NSNumber numberWithBool:NO];
		newProp.defaultValue = nil;
		
		[newProperties addUniqueObject:newProp];
		[storageProperties setObjectOrFail:newProp forKey:property.name];
		
	}
	else
	{
		[storageProperties setObjectOrFail:property forKey:property.name];
	}
}

- (void) configureValueProperty:(GtObjectiveCCodeGenerator*) generator
	property:(GtCodeGeneratorProperty*) prop 
{
	GtAssertStringIsNotEmpty(prop.originalType);
		
	GtDataTypeID typeId = GtDataTypeIDFromString(prop.originalType);

	FailIfStringIsEmpty(prop.name, @"property needs a name");
	FailIfStringIsEmpty(prop.type, @"property needs a type");

//	if([prop isEnumProperty:generator])
//	{
//		typeId = GtDataTypeEnum;
//		prop.type = [prop.enumType fullyQualifiedName:generator];
//	}
//	else
	{
		prop.type = GtObjCTypeStringFromDataType(typeId);
	}

	prop.hasCustomCode = [NSNumber numberWithBool:YES];

	NSString* valueString = nil;
	NSString* initString = nil; 

	switch(typeId)
	{
		case GtDataTypeObject:
		case GtDataTypeString:
		case GtDataTypeDate:
		case GtDataTypeData:
			GtAssertFailed(@"trying to generate object as value property");
			break;
	
		case GtDataTypeBool:
			valueString = @"boolValue";
			initString = @"[NSNumber numberWithBool:value]";
			break;
		
		case GtDataTypeShort:
			valueString = @"shortValue";
			initString = @"[NSNumber numberWithShort:value]";
			break;
		
		case GtDataTypeUnsignedShort:
			valueString = @"shortValue";
			initString = @"[NSNumber numberWithUnsignedShort:value]";
			break;
		
		case GtDataTypeNSInteger:
			valueString = @"integerValue";
			initString = @"[NSNumber numberWithInteger:value]";
			break;
		
		case GtDataTypeNSUInteger:
			valueString = @"unsignedIntegerValue";
			initString = @"[NSNumber numberWithUnsignedInteger:value]";
			break;
							
		case GtDataTypeEnum:
			valueString = @"intValue";
			initString = @"[NSNumber numberWithInt:value]";
			break;
		
		case GtDataTypeInteger:
			valueString = @"intValue";
			initString = @"[NSNumber numberWithInt:value]";
			break;
		
		case GtDataTypeUnsignedInteger:
			valueString = @"unsignedIntValue";
			initString = @"[NSNumber numberWithUnsignedInt:value]";
			break;

		case GtDataTypeChar:
			valueString = @"charValue";
			initString = @"[NSNumber numberWithChar:value]";
			break;
			
		case GtDataTypeUnsignedChar:
			valueString = @"unsignedCharValue";
			initString = @"[NSNumber numberWithUnsignedChar:value]";
			break;

		case GtDataTypeLong:
			valueString = @"longValue";
			initString = @"[NSNumber numberWithLong:value]";
			break;
			
		case GtDataTypeUnsignedLong:
			 valueString = @"unsignedLongValue";
			initString = @"[NSNumber numberWithUnsignedLong:value]";
			break;
	   case GtDataTypeFloat:
			valueString = @"floatValue";
			initString = @"[NSNumber numberWithFloat:value]";
			break;
		case GtDataTypeDouble:
			 valueString = @"doubleValue";
			initString = @"[NSNumber numberWithDouble:value]";
			break;
	   case GtDataTypeUnsignedLongLong:
			valueString = @"unsignedLongLongValue";
			initString = @"[NSNumber numberWithUnsignedLongLong:value]";
			break;
		case GtDataTypeLongLong:
			valueString = @"longLongValue";
			initString = @"[NSNumber numberWithLongLong:value]";
			break;
			
		case GtDataTypePoint:
			valueString = @"pointValue";
			initString = @"[NSValue valueWithPoint:value]";
			break;
		case GtDataTypeRect:
			valueString = @"rectValue";
			initString = @"[NSValue valueWithRect:value]";
			break;

		case GtDataTypeSize:
			valueString = @"sizeValue";
			initString = @"[NSValue valueWithSize:value]";
			break;

		case GtDataTypeValue:
			GtAssertFailed(@"not sure how to generate a NSValue for value property");
			break;			  
	
		case GtDataTypeUnknown:
			GtAssertFailed(@"unknown type");
			break;

	}
	
	prop.getter.code.lines = [NSString stringWithFormat:@"return [self.%@ %@];", prop.name, valueString];
	
	GtCodeGeneratorVariable* p1 = [GtCodeGeneratorVariable codeGeneratorVariable];
	p1.name = @"value";
	p1.typeName = prop.type; 
	[prop.setter.parameters addUniqueObject:p1];


	GtStringBuilder* builder = [GtStringBuilder stringBuilder];
	[builder appendLineWithFormat:@"self.%@ = %@;", prop.name, initString];
	prop.setter.code.lines = [builder toString];
	
	prop.name = [NSString stringWithFormat:@"%@Value", prop.name];
}

//- (void) addWildCardProperty:(GtObjectiveCCodeGenerator*) generator property: (GtCodeGeneratorProperty*) prop 
//{
//	if(prop.arrayTypes.count > 0)
//	{
//		GtCodeGeneratorObjectCategory* category = [self categoryByName:@"Parsing"];
//	
//		if(!prop.isWildcardArrayValue)
//		{
//			prop.isWildcardArray = self.isWildcardArray;
//		}
//
//		if(prop.isWildcardArrayValue)
//		{
//			for(GtCodeGeneratorArrayType* type in prop.arrayTypes)
//			{
//				GtCodeGeneratorProperty* property = [GtCodeGeneratorProperty codeGeneratorProperty];
//				property.isPrivateValue = YES;
//				property.isStaticValue = NO;
//				property.type = type.typeName;
//				property.name = type.name;
//
//				property.getter.code.lines = @"return nil;";
//
//				GtCodeGeneratorVariable* parameter = [GtCodeGeneratorVariable codeGeneratorVariable];
//				parameter.name = @"obj";
//				parameter.typeName = type.typeName;
//				parameter.originalType = type.typeName;
//				[property.setter.parameters addUniqueObject:parameter];
//				property.setter.code.lines = [NSString stringWithFormat:@"if(!%@) %@ = [[NSMutableArray alloc] init];\n[%@ addObject:obj];", prop.memberName, prop.memberName, prop.memberName];
//
//				[category.properties addUniqueObject:property];
//				
//				property.setter.comment = [NSString stringWithFormat:@"This is used for parsing. Setter adds an %@ to %@ array. Getter returns nil.", type.typeName, prop.name];;
//				property.getter.comment = [NSString stringWithFormat:@"This is used for parsing. Setter adds an %@ to %@ array. Getter returns nil.", type.typeName, prop.name];;
//				
//			
//				type.wildcardProperty = property;
//			
////				GtCodeGeneratorMethod* method = [GtCodeGeneratorMethod codeGeneratorMethod];
////				method.name = type.name; // [NSString stringWithFormat:@"add%@To%@", [type.name stringWithUpperCaseFirstLetter], [prop.name stringWithUpperCaseFirstLetter]];
////				method.returnType = @"void";
////				method.comment = [NSString stringWithFormat:@"This is used for parsing. It adds an %@ to %@ array", type.typeName, prop.name];
////				[category.methods addUniqueObject:method];
////							   
////				GtCodeGeneratorVariable* parameter = [GtCodeGeneratorVariable codeGeneratorVariable];
////				parameter.name = @"obj";
////				parameter.typeName = type.typeName;
////				parameter.originalType = type.typeName;
////				[method.parameters addUniqueObject:parameter];
////
////				method.code.lines = [NSString stringWithFormat:@"if(!%@) %@ = [[NSMutableArray alloc] init];\n[%@ addObject:obj];", prop.memberName, prop.memberName, prop.memberName];
////									   
////				type.wildcardMethod = method;
//			}
//		}
//	}
//}

- (GtCodeGeneratorProperty*) createEnumProperty:(GtObjectiveCCodeGenerator*) generator
				property: (GtCodeGeneratorProperty*) prop
				enumType: (GtCodeGeneratorEnumType*) enumType
{
	GtCodeGeneratorProperty* newProperty = [GtCodeGeneratorProperty codeGeneratorProperty];
	newProperty.name = [NSString stringWithFormat:@"%@Value", prop.name];
	newProperty.type = [generator getTypeName:prop.type];
	
// configure setter	   
	GtCodeGeneratorVariable* parameter = [GtCodeGeneratorVariable codeGeneratorVariable];
	parameter.name = @"inEnumValue";
	parameter.typeName = newProperty.type;
	[newProperty.setter.parameters addObject:parameter];
	
	NSString* typeName = [generator getTypeName:parameter.typeName];
		
	newProperty.setter.code.lines = [NSString stringWithFormat:@"self.%@ = [[%@ instance] %@:inEnumValue];", prop.name, 
		[GtCodeGeneratorEnumType lookupObjectNameFromGenerator:generator],
		[GtCodeGeneratorEnumType toStringFromEnumFunctionName:generator typeName:typeName]];
	
// configure getter	   
	newProperty.getter.code.lines = [NSString stringWithFormat:@"return [[%@ instance] %@:self.%@];", [GtCodeGeneratorEnumType lookupObjectNameFromGenerator:generator],
		[GtCodeGeneratorEnumType toEnumFromStringFunctionName:generator typeName:typeName], prop.name];
	
	return newProperty;
}

- (void) configIsEnumProperty:(GtObjectiveCCodeGenerator*) generator
				property: (GtCodeGeneratorProperty*) prop
{
//	GtCodeGeneratorProperty* newProperty = [[[GtCodeGeneratorProperty alloc] init] autorelease];
//	newProperty.name = [NSString stringWithFormat:@"%@Object", prop.name];
//	  newProperty.type = [generator getTypeName:prop.type];
//	  
//// configure setter	 
	GtCodeGeneratorVariable* parameter = [GtCodeGeneratorVariable codeGeneratorVariable];
	parameter.name = @"inEnumValue";
	parameter.typeName = prop.originalType;
	[prop.setter.parameters addObject:parameter];
	
	GtStringBuilder* builder = [GtStringBuilder stringBuilder];
	[builder appendLineWithFormat:@"[%@ release];", prop.memberName];
	[builder appendLineWithFormat:@"%@ = [NSNumber numberWithInt:inEnumValue];", prop.memberName];
	prop.setter.code.lines = [builder toString];
	
// configure getter	   
	prop.getter.code.lines = [NSString stringWithFormat:@"return (%@) [%@ intValue];", prop.originalType, prop.memberName];
}


- (GtCodeGeneratorObjectCategory*) categoryByName:(NSString*) name
{	
	for(GtCodeGeneratorObjectCategory* cat in self.categories)
	{
		if(GtStringsAreEqual(name, cat.categoryName))
		{
			return cat;
		}
	}

	return nil;
}


- (void) configureProperty:(GtObjectiveCCodeGenerator*) generator
	property: (GtCodeGeneratorProperty*) prop 
	storageProperties:(NSMutableDictionary*) storageProperties
{
	GtCodeGeneratorObjectCategory* category = [self categoryByName:@"ValueProperties"];

//	GtMergeObjects(prop.options, self.propertyOptions, GtMergeModeSourceWins);
	if(!prop.canLazyCreate)
	{
		prop.canLazyCreate = self.canLazyCreate;
	}
	
	if(!prop.isWildcardArray)
	{
		prop.isWildcardArray = self.isWildcardArray;
	}
	//GtMergeObjects(prop.storageOptions, self.storageOptions, GtMergeModeSourceWins);
	
	GtThrowIfStringEmpty(prop.type);
	GtThrowIfStringEmpty(prop.name);

	// this wires array objects up as NSMutableArray's instead of the object type
	for(GtCodeGeneratorArray* array in generator.schema.arrays)
	{			
		if([prop.type isEqualToString:array.name])
		{
			prop.type = @"NSMutableArray";
			prop.arrayTypes = array.types;
			break;
		}
	}

	GtCodeGeneratorEnumType* enumType = [generator getEnum:prop.type];
	if(enumType)
	{
		[self addDependency:enumType.typeName generator:generator];
		
		[category.properties addObject:
			[self createEnumProperty:generator property:prop enumType:enumType]];
		
		prop.type = @"string";
	    prop.enumType = enumType;
	}
	
	prop.type = GtConvertToKnownType(prop.type);
	prop.originalType = prop.type;
	
	if(!prop.isImmutable.boolValue)
	{
		prop.type = GtObjcObjectTypeStringFromString(prop.type);
	}

	
	GtThrowIfStringEmpty(prop.type);
	
	[self addDependency:prop.type generator:generator];
	[prop addVariablesToParentObject:self];

	// update array types
	for(GtCodeGeneratorArrayType* type in prop.arrayTypes)
	{
		if(GtStringIsEmpty(type.originalType))
		{
			type.originalType = type.typeName;
			type.typeName = GtObjcObjectTypeStringFromString(GtConvertToKnownType(type.typeName));
		}
	}
	
	if(	!prop.isImmutableValue && 
		![prop isEnumProperty:generator] && 
		[prop isValueProperty:generator])
	{
		GtCodeGeneratorProperty* newProp = [[prop copy] autorelease];
		newProp.getter = nil;
		newProp.setter = nil;
		newProp.defaultValue = nil;
		
		[category.properties addObject:newProp];

		[self configureValueProperty:generator property:newProp];
		newProp.canLazyCreate = [NSNumber numberWithBool:NO];
	}
	
	[storageProperties setObjectOrFail:prop forKey:prop.name];
	
//	[self addObjectProperty:generator 
//		property:prop 
//		newProperties:newProperties 
//		storageProperties:storageProperties];

//	if( !prop.isImmutable.boolValue &&	
//		![prop isValueProperty:generator] &&
//		!prop.options.isPrivate.boolValue &&
//		!prop.isStatic.boolValue && 
//		!GtIsIdType(prop.type))
//	{
//		[self addCreatePropertyMethod:generator property:prop];
//	}

//	if(type.dataTypeIsEnum)
//	{
//		prop.type = prop.originalType;
//		
////		  if([generator.schema.externallyDefinedEnums indexOfObject:prop.type] == NSNotFound)
////		  {
////			[generator.schema.externallyDefinedEnums addObject:prop.type];
////		}
//	}
////	else if([prop isValueProperty:generator] && !prop.isImmutable.boolValue)
////	{	 
////		[self configureValueProperty:generator property:prop];
////	}
////	
//	[self addWildCardProperty:generator property:prop];
}

- (NSMutableDictionary*) configureAllPropertiesAndReturnStoragePropertyList:(GtObjectiveCCodeGenerator*) generator
{
	NSMutableDictionary* storageProperties = [NSMutableDictionary dictionary];


	for(GtCodeGeneratorProperty* prop in self.properties)
	{
		[self configureProperty:generator 
			property:prop 
			storageProperties:storageProperties];
		

		
		if([prop canCreateMemberData:generator])
		{
			GtCodeGeneratorObjectCategory* category = [self categoryByName:@"ObjectMembers"];
			GtStringBuilder* builder = [GtStringBuilder stringBuilder];
				
			[builder appendLineWithFormat:@"if(!%@)", prop.memberName];
			[builder appendLine:@"{"];
			[builder tabIn];
			[builder appendLineWithFormat:@"%@ = [[%@ alloc] init];", prop.memberName, GtRemovePointerSplat(prop.type)];
			[builder tabOut];
			[builder appendLine:@"}"];

			GtCodeGeneratorMethod* method = [GtCodeGeneratorMethod codeGeneratorMethod];
			method.name = [NSString stringWithFormat:@"create%@IfNil", [prop.getterName stringWithUpperCaseFirstLetter]];
			method.isStatic = NO;
			method.isPrivate = NO;
			method.code.lines = [builder toString];			
			[category.methods addObject:method];
		}
				
		if([prop willLazyCreate:generator])
		{
		
			{
			GtCodeGeneratorObjectCategory* category = [self categoryByName:@"ObjectMembers"];
/*			
			GtCodeGeneratorProperty* property = [GtCodeGeneratorProperty codeGeneratorProperty];
			property.name = [NSString stringWithFormat:@"%@", prop.getterName];
			property.type = prop.type;
			property.isReadOnlyValue = YES;
			GtStringBuilder* builder = [GtStringBuilder stringBuilder];
				
			[builder appendLineWithFormat:@"if(!%@)", prop.memberName];
			[builder appendLine:@"{"];
			[builder tabIn];
			[builder appendLineWithFormat:@"%@ = [[%@ alloc] init];", prop.memberName, GtRemovePointerSplat(prop.type)];
			[builder tabOut];
			[builder appendLine:@"}"];
			[builder appendLineWithFormat:@"return %@;", prop.memberName];
			property.getter.code.lines = [builder toString];
			
			[category.properties addObject:property];
*/

		//	prop.comment 

			GtStringBuilder* builder = [GtStringBuilder stringBuilder];
				
			[builder appendLineWithFormat:@"if(!%@)", prop.memberName];
			[builder appendLine:@"{"];
			[builder tabIn];
			[builder appendLineWithFormat:@"%@ = [[%@ alloc] init];", prop.memberName, GtRemovePointerSplat(prop.type)];
			[builder tabOut];
			[builder appendLine:@"}"];
			[builder appendLineWithFormat:@"return %@;", prop.memberName];
///			property.getter.code.lines = [builder toString];
			
			prop.comment = [NSString stringWithFormat:@"Getter will create %@ if nil. Alternately, use the %@Object property, which will not lazy create it.", prop.memberName, prop.getterName, prop.getterName];
			prop.getter.code.lines = [builder toString];
			

//			GtCodeGeneratorProperty* isNil = [GtCodeGeneratorProperty codeGeneratorProperty];
//			isNil.name = [NSString stringWithFormat:@"%@IsNil", prop.getterName];
//			isNil.type = @"BOOL";
//			isNil.isReadOnlyValue = YES;
//			isNil.getter.code.lines = [NSString stringWithFormat:@"return %@ == nil;", prop.memberName];
//			[category.properties addObject:isNil];
//
//
//			GtCodeGeneratorProperty* isNotNil = [GtCodeGeneratorProperty codeGeneratorProperty];
//			isNotNil.name = [NSString stringWithFormat:@"%@IsNotNil", prop.getterName];
//			isNotNil.type = @"BOOL";
//			isNotNil.isReadOnlyValue = YES;
//			isNotNil.getter.code.lines = [NSString stringWithFormat:@"return %@ != nil;", prop.memberName];
//			[category.properties addObject:isNotNil];


			GtCodeGeneratorProperty* newProp = [[prop copy] autorelease];
			newProp.comment = [NSString stringWithFormat:@"This returns %@. It does NOT create it if it's NIL.", prop.memberName]; 
			newProp.getter.code.lines = [NSString stringWithFormat:@"return %@;", newProp.memberName];
			newProp.isReadOnlyValue = YES;
			newProp.name = [NSString stringWithFormat:@"%@Object", prop.name];
			newProp.canLazyCreateValue = NO;
			newProp.defaultValue = nil;
			[category.properties addObject:newProp];
			}
		}

		
		
		
		// add comment to strings.
		if(GtStringIsNotEmpty(prop.comment))
		{
			GtCodeGeneratorComment* comment = [GtCodeGeneratorComment codeGeneratorComment];
			comment.object = self.typeName;
			comment.commentID = prop.name;
			comment.comment = prop.comment;
			[generator.comments addObject:comment];
		}
	}
	
	return storageProperties;
}

- (BOOL) isPropertyArrayElementType:(NSMutableDictionary*) storageProperties
	name:(NSString*) name
{
	for(NSString* key in storageProperties)
	{
		GtCodeGeneratorProperty* prop = [storageProperties objectForKey:key];
		if(prop.arrayTypes && prop.arrayTypes.count > 0)
		{
			for(GtCodeGeneratorArrayType* propType in prop.arrayTypes)
			{
				if(GtStringsAreEqual(propType.name, name))
				{
					return YES;
				}
			}
		}
	}

	return NO;
}

- (NSString*) superclassNoProtocol
{
	NSRange range = [self.superclass rangeOfString:@"<"];
	return range.length > 0 ? [self.superclass substringToIndex:range.location] : self.superclass;
}

//- (void) addDataTypeStructMethodAndData
//{
//	  GtCodeGeneratorObjectMemberType* desc = [[GtCodeGeneratorObjectMemberType alloc] init];
//	  desc.name = @"s_dataTypeStruct";
//	  desc.type = @"_GtDataTypeStruct";
//	  desc.isStatic = [NSNumber numberWithBool:YES];
//	  
//	  desc.defaultValue = [NSString stringWithFormat:@"GtInitDataTypeStruct(@\"%@\", @\"%@\", %@, @\"%@\", @\"%@:\", %@, %@)",	 
//						   CheckString(self.name), 
//						   GtRemovePointerSplat(self.type), 
//						   @"GtDataTypeObject",
//						   @"",
//						   @"",
//						   self.storageOptions.storageMask, 
//						   @"nil"];
//	  [self.members addUniqueObject:desc];
//	  [desc release];
//	  
//	  
//	  GtCodeGeneratorMethod* method = [[GtCodeGeneratorMethod alloc] init];
//	  method.name = @"dataTypeStruct";
//	  method.returnType = @"GtDataTypeStruct";
//	  method.options.isPrivate = [NSNumber numberWithBool:YES];
//	  [method.code.builder appendLine:@"return &s_dataTypeStruct;"];
//	  [self.methods addUniqueObject:method];
//	  [method release];
//}

//- (void) processStorageProperties:(NSMutableDictionary*) storageProperties
//	arrayDescriptors:(NSMutableArray*) outArrayDescriptors
//	propertyDescriptors:(NSMutableArray*) outPropertyDescriptors
//	wildCardDescriptors:(NSMutableArray*) outWildCardDescriptors
//{
//	GtCodeGeneratorObjectMemberType* myTypeStruct = [GtCodeGeneratorObjectMemberType codeGeneratorObjectMemberType];
//	myTypeStruct.name = @"s_dataTypeStruct";
//	myTypeStruct.typeName = @"GtDataTypeStruct";
//	myTypeStruct.defaultValue = @"GtDataTypeStructZero";
//	myTypeStruct.isStatic = [NSNumber numberWithBool:YES];
//	[self.members addUniqueObject:myTypeStruct];
//	
//	GtCodeGeneratorMethod* myTypeStructMethod = [GtCodeGeneratorMethod codeGeneratorMethod];
//	myTypeStructMethod.name = @"dataTypeStruct";
//	myTypeStructMethod.returnType = @"GtDataTypeStructPtr";
//	myTypeStructMethod.isPrivate = [NSNumber numberWithBool:YES];
//	myTypeStructMethod.isStatic = [NSNumber numberWithBool:YES];
//	myTypeStructMethod.code.lines = @"return &s_dataTypeStruct;";
//	[self.methods addObject:myTypeStructMethod];
//	
//	GtCodeGeneratorMethod* method = [GtCodeGeneratorMethod codeGeneratorMethod];
//	method.name = @"initialize";
//	method.isPrivate = [NSNumber numberWithBool:YES];
//	method.isStatic = [NSNumber numberWithBool:YES];
//	method.returnType = @"void";
//	[self.methods addUniqueObject:method];
//
//	GtStringBuilder* initMethod = [GtStringBuilder stringBuilder];
//	[initMethod appendLineWithFormat:@"static BOOL s_didInitialize = NO;"];
//	[initMethod appendLineWithFormat:@"if(!s_didInitialize) {"];
//	[initMethod tabIn];
//	[initMethod appendLineWithFormat:@"s_didInitialize = YES;"];
//	
//	
////	for(GtCodeGeneratorObjectMemberType* staticVar in self.members)
////	{
////		if([staticVar isKindOfClass:[GtCodeGeneratorObjectMemberType class]])
////		{
////			if(staticVar.isStatic.boolValue)
////			{
////				if(GtStringIsNotEmpty(staticVar.defaultValue))
////				{
////					[initMethod appendLineWithFormat:@"%@ = %@;", 
////						staticVar.name, 
////						staticVar.defaultValue];
////				}
////			}
////		}
////	}
//	
//	NSString* classString = GtIsIdType(GtRemovePointerSplat(self.typeName)) ? 
//		@"nil" : 
//		[NSString stringWithFormat:@"[%@ class]", GtRemovePointerSplat(self.typeName)];
//
//	[initMethod appendLineWithFormat:@"%@ = GtDataTypeStructMake(@\"%@\", %@, GtDataTypeObject, nil, nil, %@, nil);", 
//																									myTypeStruct.name,
//																									   CheckString(self.name), 
//																									  classString, 
//																										self.storageOptions.storageMask];
//	
//	for(NSString* key in storageProperties)
//	{
//		GtCodeGeneratorProperty* prop = [storageProperties objectForKey:key];
//	
//		GtAssertIsValidString(key);
//		GtAssertIsValidString(prop.name);
//		GtAssertIsValidString(prop.type);
//	   
//		if(prop.isStatic.boolValue || prop.isImmutable.boolValue)
//		{
//			continue;
//		}
//	
//		FailIfStringIsEmpty(prop.name, @"name missing");
//		FailIfStringIsEmpty(prop.type, @"type missing");	
//		
////		if(self.canDescribe.boolValue)
//		{
//			// add the static key property
//			GtCodeGeneratorProperty* newProp = [GtCodeGeneratorProperty codeGeneratorProperty];
//			newProp.name = [NSString stringWithFormat:@"%@Key", key];
//			newProp.isImmutable = [NSNumber numberWithBool:YES];
//			newProp.defaultValue = [NSString stringWithFormat:@"@\"%@\"", key];
//			newProp.type = @"NSString";
//			newProp.isStatic = [NSNumber numberWithBool:YES];
//			[self.properties addUniqueObject:newProp];
//		}
//		
//		// figure out storage mask
//		NSString* storageMask = prop.storageOptions.storageMask;
//		
//		NSMutableArray* arrayDescriptors = [NSMutableArray array];
//							
//		// add type descriptor variables
//		if(prop.arrayTypes && prop.arrayTypes.count > 0)
//		{
//			int count = -1;
//			for(GtCodeGeneratorArrayType* type in prop.arrayTypes)
//			{
//				GtCodeGeneratorObjectMemberType* desc = [GtCodeGeneratorObjectMemberType codeGeneratorObjectMemberType];
//				desc.name = [NSString stringWithFormat:@"s_%@ArrayTypeDescriptor%d", prop.name, ++count];
//				desc.typeName = @"GtDataTypeStruct";
//				desc.isStatic = [NSNumber numberWithBool:YES];
//				[arrayDescriptors addUniqueObject:desc];
//			}
//				
//			for(int i = 0; i < arrayDescriptors.count; i++)
//			{
//				GtCodeGeneratorArrayType* arrayType = [prop.arrayTypes objectAtIndex:i];
//				GtAssertIsValidString(arrayType.name);
//				GtAssertIsValidString(arrayType.typeName);
//				
//				GtCodeGeneratorProperty* wildcardProperty = arrayType.wildcardPropertyObject;
//				
//				GtCodeGeneratorVariable* type = [arrayDescriptors objectAtIndex:i];
//				GtAssertNotNil(type);
//				
//				GtCodeGeneratorVariable* nextType = i + 1 < arrayDescriptors.count ? [arrayDescriptors objectAtIndex:i+1] : nil;
////				type.defaultValue = @"GtDataTypeStructZero";
//
//				NSString* classString = GtIsIdType(GtRemovePointerSplat(arrayType.typeName)) ? 
//					@"nil" : 
//					[NSString stringWithFormat:@"[%@ class]", GtRemovePointerSplat(arrayType.typeName)];
//
//				[initMethod appendLineWithFormat:@"%@ = GtDataTypeStructMake(@\"%@\", %@, %@, %@, %@, %@, %@);", 
//						type.name,
//						CheckString(arrayType.name), 
//						classString,
//						CheckString(GtDataTypeIDStringFromDataType(GtDataTypeIDFromString(GtConvertToKnownType(arrayType.originalType)))),
//						(wildcardProperty && GtStringIsNotEmpty(wildcardProperty.name)) ? [NSString stringWithFormat:@"@selector(%@)", wildcardProperty.getterName] : @"nil",
//						(wildcardProperty && GtStringIsNotEmpty(wildcardProperty.name)) ? [NSString stringWithFormat:@"@selector(%@:)", wildcardProperty.setterName] : @"nil",
//						storageMask, 
//						nextType ? [NSString stringWithFormat:@"&%@", nextType.name] : @"nil"];
//			
//				GtKeyValuePair* pair = [GtKeyValuePair keyValuePair:arrayType.name value:type];
//				[outArrayDescriptors addObject:pair];
//				
//				if(wildcardProperty)
//				{
//					[outWildCardDescriptors addObject:pair];
//				}
//			}
//			 
//			for(GtCodeGeneratorVariable* type in [arrayDescriptors reverseObjectEnumerator])
//			{
//				[self.members addUniqueObject:type];
//			}
//		}
//		
//		// if this is true, it means the descriptor was already added and the descriptor was added above.
//		if(![self isPropertyArrayElementType:storageProperties name:key])
//		{
//			GtAssertIsValidString(prop.originalType);
//			
//			GtCodeGeneratorObjectMemberType* desc = [GtCodeGeneratorObjectMemberType codeGeneratorObjectMemberType];
//			desc.name = [NSString stringWithFormat:@"s_%@TypeDescriptor", prop.name];
//			desc.typeName = @"GtDataTypeStruct";
//			desc.isStatic = [NSNumber numberWithBool:YES];
////			desc.defaultValue = @"GtDataTypeStructZero";
//
//	 //		  desc.defaultValue = [NSString stringWithFormat:@"GtInitDataTypeStruct(@\"%@\", @\"%@\", %@, @\"%@\", @\"%@:\", %@, %@)",	
//
//			NSString* classString = GtIsIdType(GtRemovePointerSplat(prop.type)) ? 
//					@"nil" : 
//					[NSString stringWithFormat:@"[%@ class]", GtRemovePointerSplat(prop.type)];
//
//			[initMethod appendLineWithFormat:@"%@ = GtDataTypeStructMake(@\"%@\", %@, %@, @selector(%@), @selector(%@:), %@, %@);",	 
//					desc.name,
//					CheckString(key), 
//					classString, 
//					CheckString(GtDataTypeIDStringFromDataType(GtDataTypeIDFromString(GtConvertToKnownType(prop.originalType)))),
//					CheckString(prop.getterName),
//					CheckString(prop.setterName),
//					CheckString(storageMask), 
//					arrayDescriptors.count > 0 ? [NSString stringWithFormat:@"&%@", [[arrayDescriptors objectAtIndex:0] name]] : @"nil"];
//
//			[outPropertyDescriptors addObject:[GtKeyValuePair keyValuePair:key value:desc]];
//
//			[self.members addUniqueObject:desc];
//		}
//	}
//	
//	
//	
//	[initMethod tabOut];
//	[initMethod appendLine:@"}"];	 
//	method.code.lines = [initMethod toString];
//}

//- (void) addDescriptorsArrayAndAccessorMethods:(NSMutableArray*) onlyPropertyDescriptors
//{
//	if(onlyPropertyDescriptors.count)
//	{ 
//	// add descriptor static array
//		GtCodeGeneratorObjectMemberType* type = [GtCodeGeneratorObjectMemberType codeGeneratorObjectMemberType];
//		type.name = [NSString stringWithFormat:@"s_typeDescriptors[%d]", onlyPropertyDescriptors.count];
//		type.typeName = @"GtDataTypeStructPtr";
//		type.isStatic = [NSNumber numberWithBool:YES];
//		
//		NSMutableString* defaultValue = [NSMutableString stringWithString:@"{"];
//		int count = 0;
//		for(GtKeyValuePair* pair in onlyPropertyDescriptors)
//		{
//			GtCodeGeneratorVariable* type = pair.value;
//		
//			[defaultValue appendFormat:@"%@&%@", count++ > 0 ? @", " : @"", type.name]; 
//		}
//		[defaultValue appendString:@"}"];
//		type.defaultValue = defaultValue; 
//		
//		[self.members addUniqueObject:type];
//		
//	// add propertyDataTypeStructCount method
//		{
//			GtCodeGeneratorMethod* countMethod = [GtCodeGeneratorMethod codeGeneratorMethod];
//			countMethod.name = @"propertyDataTypeStructCount";
//			countMethod.isPrivate = [NSNumber numberWithBool:YES];
//			countMethod.isStatic = [NSNumber numberWithBool:YES];
//			countMethod.returnType = @"NSUInteger";
//			[self.methods addUniqueObject:countMethod];
//	 
//			countMethod.code.lines = [NSString stringWithFormat:@"return %d + [%@ propertyDataTypeStructCount];", onlyPropertyDescriptors.count, [self superclassNoProtocol] ];
//		}
//		
//	// add propertyDataTypeStructByIndex method
//		{
//			GtCodeGeneratorMethod* indexMethod = [GtCodeGeneratorMethod codeGeneratorMethod];
//			indexMethod.name = @"propertyDataTypeStructByIndex";
//			indexMethod.isPrivate = [NSNumber numberWithBool:YES];
//			indexMethod.isStatic = [NSNumber numberWithBool:YES];
//			indexMethod.returnType = @"GtDataTypeStructPtr";
//			[self.methods addUniqueObject:indexMethod];
//			
//			
//			GtCodeGeneratorVariable* parameter = [GtCodeGeneratorVariable codeGeneratorVariable];
//			parameter.name = @"idx";
//			parameter.typeName = @"NSUInteger";
//			[indexMethod.parameters addUniqueObject:parameter];
//			
//			if(onlyPropertyDescriptors.count)
//			{
//				indexMethod.code.lines = [NSString stringWithFormat:
//					@"return idx >= %d ? [%@ propertyDataTypeStructByIndex:idx-%d] : s_typeDescriptors[idx];", 
//						onlyPropertyDescriptors.count, [self superclassNoProtocol], onlyPropertyDescriptors.count];
//			}
//			else
//			{
//				indexMethod.code.lines = @"return nil;";
//			}
//		}
//		
//	// add dataTypeStruct methed
//	}
//}

//- (void) addTypeDescriptorForKeyMethod:(NSMutableArray*) propertyDescriptors
//	wildCardDescriptors:(NSMutableArray*) wildCardDescriptors
//{
//	if(propertyDescriptors.count || wildCardDescriptors.count)
//	{
//		GtCodeGeneratorMethod* method = [GtCodeGeneratorMethod codeGeneratorMethod];
//		method.name = @"propertyDataTypeStructByName";
//		method.isPrivate = [NSNumber numberWithBool:YES];
//		method.isStatic = [NSNumber numberWithBool:YES];
//		method.returnType = @"GtDataTypeStructPtr";
//		[self.methods addUniqueObject:method];
//		
//		GtCodeGeneratorVariable* parameter = [GtCodeGeneratorVariable codeGeneratorVariable];
//		parameter.name = @"key";
//		parameter.typeName = @"NSString";
//		[method.parameters addUniqueObject:parameter];
//		
//		GtStringBuilder* builder = [GtStringBuilder stringBuilder];
//		[builder appendLine:@"static NSDictionary* s_hashTable = nil;"];
//		[builder appendLine:@"if(s_hashTable == nil)"];
//		[builder appendLine:@"{"];
//			[builder tabIn];
//			[builder appendLine:@"@synchronized(self)"];
//			[builder appendLine:@"{"];
//				[builder tabIn];
//				[builder appendLine:@"if(s_hashTable == nil)"];
//				[builder appendLine:@"{"];
//					[builder tabIn];
//					[builder appendLine:@"s_hashTable = [[NSDictionary alloc] initWithObjectsAndKeys:"];
//							[builder tabIn];
//						
//							for(GtKeyValuePair* pair in propertyDescriptors)
//							{
//								GtCodeGeneratorVariable* variable = pair.value;
//							
//								[builder appendLineWithFormat:@"[NSValue valueWithPointer:&%@], @\"%@\", // property accessor", 
//										variable.name,
//										pair.key];
//							}
//							for(GtKeyValuePair* pair in wildCardDescriptors)
//							{
//								GtCodeGeneratorVariable* variable = pair.value;
//								
//								[builder appendLineWithFormat:@"[NSValue valueWithPointer:&%@], @\"%@\", // wildcard accessor", 
//								 variable.name,
//								 pair.key];
//							}
//							
//						
//							[builder appendLine:@"nil];"];
//						[builder tabOut];
//								
//					[builder tabOut];
//				
//				[builder appendLine:@"}"];
//
//				[builder tabOut];
//			[builder appendLine:@"}"];
//			[builder tabOut];
//	
//		[builder appendLine:@"}"];
//	
//		[builder appendLine:@"NSValue* pointerToTypeDefinition = [s_hashTable objectForKey:key];"];
//
///*		  
//		GtCodeGeneratorProperty* defaultProperty = [self defaultProperty:self];
//		if(defaultProperty)
//		{
//			[builder appendLineWithFormat:@"return (GtDataTypeStruct*) (pointerToTypeDefinition == nil) ? &%@ : [pointerToTypeDefinition pointerValue];", [self typeDescriptorNameForProperty:defaultProperty]];
//		}
//		else
//*/		  
//		{
//			[builder appendLineWithFormat:
//				@"return pointerToTypeDefinition != nil ? (GtDataTypeStructPtr) [pointerToTypeDefinition pointerValue] : [%@ propertyDataTypeStructByName:key];",
//				[self superclassNoProtocol]];
//		}
//
//		method.code.lines = [builder toString];
//
//	}
//}

- (BOOL) wantsInitInitializer:(GtCodeGeneratorProperty*) prop
{
	return GtStringIsNotEmpty(prop.defaultValue) && !prop.isImmutable.boolValue && !prop.isStatic.boolValue;
}

- (void) _configInitProperty:(GtCodeGeneratorProperty*) prop
	builder:(GtStringBuilder*) builder
	generator:(GtCodeGenerator*) generator
{
			if(	!prop.isStatic.boolValue && 
				!prop.isImmutable && 
				GtStringIsNotEmpty(prop.defaultValue))
			{
				if([prop isValueProperty:generator] || [prop isEnumProperty:generator])
				{
					[builder appendLineWithFormat:@"self.%@Value = %@;", prop.name, prop.defaultValue];
				}
				else if(GtStringsAreEqual(prop.type, @"NSString"))
				{
					[builder appendLineWithFormat:@"self.%@ = @\"%@\";", prop.name, prop.defaultValue];
				}
				else
				{
					[builder appendLineWithFormat:@"self.%@ = %@;", prop.name, prop.defaultValue];
				}
			}
}

- (void) addInitMethod:(GtObjectiveCCodeGenerator*) generator
{
//	if(self.initLines.count > 0)
	{
		GtCodeGeneratorMethod* method = [GtCodeGeneratorMethod codeGeneratorMethod];
		method.name = @"init";
		method.returnType = @"id";
		method.isPrivate = [NSNumber numberWithBool:YES];
		
//		BOOL callParent = [self.superclass rangeOfString:@"NSObject"].length < 0;
		GtStringBuilder* builder = [GtStringBuilder stringBuilder];
		[builder appendLine:@"if((self = [super init]))"];
		[builder appendLine:@"{"];
		[builder tabIn];
	
		
		for(NSString* line in self.initLines)
		{
			[builder appendLine:line];
		}
		
		for(GtCodeGeneratorProperty* prop in self.properties)
		{	
			[self _configInitProperty:prop builder:builder generator:generator];
		}
		for(GtCodeGeneratorObjectCategory* cat in self.categories)
		{
			for(GtCodeGeneratorProperty* prop in cat.properties)
			{	
				[self _configInitProperty:prop  builder:builder generator:generator];
			}
		}

		
		[builder tabOut];
		[builder appendLine:@"}"];
	
		[builder appendLine:@"return self;"];
		method.code.lines = [builder toString];
		[self.methods addUniqueObject:method];
	}
}	

- (void) addDeallocMethod
{
	BOOL hasDealloc = self.deallocLines.count > 0;
	
	if(!hasDealloc)
	{
		for(GtCodeGeneratorObjectMemberType* type in self.members)
		{
			if(GtDataTypeIsObject(GtDataTypeIDFromString(type.typeName)) && !type.isStatic.boolValue)
			{
				hasDealloc = YES;
				break;
			}
		}
	}

	if(hasDealloc)
	{
		GtCodeGeneratorMethod* method = [GtCodeGeneratorMethod codeGeneratorMethod];
		method.name = @"dealloc";
		method.isPrivate = [NSNumber numberWithBool:YES];

		GtStringBuilder* builder = [GtStringBuilder stringBuilder];
		for(NSString* line in self.deallocLines)
		{
			[builder appendLine:line];
		}

		for(GtCodeGeneratorObjectMemberType* type in self.members)
		{
			FailIfStringIsEmpty(type.name, @"name missing");
			FailIfStringIsEmpty(type.typeName, @"type missing");	
			if(!type.isStatic.boolValue)
			{
				[builder appendLineWithFormat:@"[%@ release];", type.name];
			}
		
		}

		[builder appendLine:@"[super dealloc];"];
		method.code.lines = [builder toString];
		[self.methods addUniqueObject:method];
	}
}

NSInteger compareNamedItems(id lhs, id rhs, void* state)
{
	return [[lhs name] compare:[rhs name]];
}

NSInteger sortProperties(GtCodeGeneratorProperty* lhs, GtCodeGeneratorProperty* rhs, void* state)
{
	if(lhs.isStatic.boolValue && !rhs.isStatic.boolValue)
	{
		return 1;
	}
	if(!lhs.isStatic.boolValue && rhs.isStatic.boolValue)
	{
		return -1;
	}

	return [[lhs name] compare:[rhs name]];
}


- (void) addDependecies:(GtObjectiveCCodeGenerator*) generator
{
	for(GtCodeGeneratorProperty* prop in self.properties)
	{
		[self addDependency:prop.type  generator:generator];
		
		for(GtCodeGeneratorArrayType* type in prop.arrayTypes)
		{
			[self addDependency:type.typeName  generator:generator];
		}
	}
	for(GtCodeGeneratorObjectCategory* cat in self.categories)
	{
		for(GtCodeGeneratorProperty* prop in cat.properties)
		{
			[self addDependency:prop.type  generator:generator];
			
			for(GtCodeGeneratorArrayType* type in prop.arrayTypes)
			{
				[self addDependency:type.typeName  generator:generator];
			}
		}
	}

	for(GtCodeGeneratorTypeDefinition* d in generator.schema.dependencies)
	{
		[self addDependency:d.typeName generator:generator];
	}
}



- (void) configure:(GtObjectiveCCodeGenerator*) generator
{
	FailIfStringIsEmpty(self.typeName, @"Object type is required");


	if(GtStringIsEmpty(self.name))
	{
		self.name = self.typeName;
	}
	
	self.sourceFileName = [NSString stringWithFormat:@"%@.m", self.typeName];
	self.headerFileName = [NSString stringWithFormat:@"%@.h", self.typeName];
	
	if(!self.canLazyCreate)
	{
		self.canLazyCreate = generator.schema.canLazyCreate;
	}
	if(!self.isWildcardArray)
	{
		self.isWildcardArray = generator.schema.isWildcardArray;
	}
	
	GtCodeGeneratorObjectCategory* valueCategory = [GtCodeGeneratorObjectCategory codeGeneratorObjectCategory];
	valueCategory.objectName = self.typeName;
	valueCategory.categoryName = @"ValueProperties";
	[self.categories addObject:valueCategory];

	if(self.canLazyCreateValue)
	{
		GtCodeGeneratorObjectCategory* lazyCategory = [GtCodeGeneratorObjectCategory codeGeneratorObjectCategory];
		lazyCategory.objectName = self.typeName;
		lazyCategory.categoryName = @"ObjectMembers";
		[self.categories addObject:lazyCategory];
	}


//	if(self.canStore.boolValue || self.canStream.boolValue)
//	{
//		self.canDescribe = [NSNumber numberWithBool:YES];
//	}
	
	if(self.isSingleton.boolValue)
	{
		GtCodeGeneratorCodeSnippet* singleton = [GtCodeGeneratorCodeSnippet codeGeneratorCodeSnippet];
		singleton.lines = [NSString stringWithFormat:@"GtSynthesizeSingleton(%@);", self.typeName];
		[self.sourceSnippets addObject:singleton];
	}
	
	BOOL rootClass = NO;
	if(GtStringIsEmpty(self.superclass))
	{
		rootClass = YES;
		self.superclass = @"NSObject";
	}
//	
//	if(GtStringIsEmpty(self.protocols))
//	{	
//		self.protocols = @"NSCopying";
//	}
//	else if([self.protocols rangeOfString:@"NSCopying"].length == 0)
//	{
//		self.protocols = [NSString stringWithFormat:@"%@, NSCopying", self.protocols];
//	}
	
	
	// configure properties
	
	NSMutableDictionary* storageProperties = [self configureAllPropertiesAndReturnStoragePropertyList:generator];
	
	
	for(NSString* key in storageProperties)
	{
		GtCodeGeneratorProperty* prop = [storageProperties objectForKey:key];
	
		GtAssertIsValidString(key);
		GtAssertIsValidString(prop.name);
		GtAssertIsValidString(prop.type);
	   
		if(!prop.isStaticValue && !prop.isImmutableValue )
		{
			FailIfStringIsEmpty(prop.name, @"name missing");
			FailIfStringIsEmpty(prop.type, @"type missing");	
			
			// add the static key property
			GtCodeGeneratorProperty* newProp = [GtCodeGeneratorProperty codeGeneratorProperty];
			newProp.name = [NSString stringWithFormat:@"%@Key", key];
			newProp.isImmutable = [NSNumber numberWithBool:YES];
			newProp.defaultValue = [NSString stringWithFormat:@"@\"%@\"", key];
			newProp.type = @"NSString";
			newProp.isStatic = [NSNumber numberWithBool:YES];
			[self.properties addUniqueObject:newProp];
		}
	}
	
//	if(self.canDescribe.boolValue)
//	{
//		[self addDependency:@"GtDataType"];
//	
//		NSMutableArray* arrayDescriptors = [NSMutableArray array];
//		NSMutableArray* propertyDescriptors = [NSMutableArray array];
//		NSMutableArray* wildCardDescriptors = [NSMutableArray array];
		
//		[self processStorageProperties:storageProperties 
//			arrayDescriptors:arrayDescriptors 
//			propertyDescriptors:propertyDescriptors
//			wildCardDescriptors:wildCardDescriptors];
			
//		[self addDescriptorsArrayAndAccessorMethods:propertyDescriptors];
			
//		[self addTypeDescriptorForKeyMethod:propertyDescriptors wildCardDescriptors:wildCardDescriptors];
//	}
		   
	for(GtCodeGeneratorProperty* prop in self.properties)
	{	
		[prop buildCode:generator object:self];
	}
	for(GtCodeGeneratorObjectCategory* cat in self.categories)
	{
		for(GtCodeGeneratorProperty* prop in cat.properties)
		{	
			[prop buildCode:generator object:self];
		}
	}
	
	[self addInitMethod:generator];
	[self addInitializer:generator];
	[self addDeallocMethod];

	if([self.protocols rangeOfString:@"NSCopying"].length > 0)
	{
		[self addCopyMethod:generator];
		[self addCopySelfToMethod:generator storageProperties:storageProperties];
	}

	if([self.protocols rangeOfString:@"NSCoding"].length > 0)
	{
		[self addDecodeMethod:storageProperties];
		[self addEncodeMethod:storageProperties];
	}
	
	[self addIsEqualMethod:storageProperties];
	
	[self addDescriberMethod:generator];
	[self addObjectInflatorMethod:generator];
	[self addSqlTableMethod:generator];
	
	[self.properties sortUsingFunction:sortProperties context:nil];
	[self.methods sortUsingFunction:compareNamedItems context:nil];
//	  [self.members sortUsingFunction:compareNamedItems context:nil];
	
	[self addDependecies:generator];
	
}


- (void) generateComment:(GtStringBuilder*) builder comment:(NSString*) comment singleLine:(BOOL) singleLine
{
//	GtThrowIfStringEmpty(comment, CodeGenFail, @"Empty Comment", nil);

	if(singleLine)
	{
		[builder appendLineWithFormat:@"// %@", comment];
	}
	else
	{
		[builder appendLine:@"/*"];
		[builder appendLine:comment];
		[builder appendLine:@"*/"];
	}
}

//- (BOOL) shouldAddDependency:(GtCodeGeneratorTypeDefinition*) item generator:(GtCodeGenerator*) generator
//{
//	item = [item stringByReplacingOccurrencesOfString:@"*" withString:@""];
//	
//	if([item hasPrefix:@"NS"] || [item isEqualTo:@"id"])
//	{
//		return NO;
//	}
//	
//	GtCodeGeneratorEnumType* enumType = [generator getEnum:item];
//	if(enumType)
//	{
//		return NO;
//	}
////	  if([generator.schema.externallyDefinedEnums indexOfObject:item] != NSNotFound)
////	  {
////		return NO;
////	  }
//	
//	
//	if([item isEqualToString:self.superclass])
//	{
//		return NO;
//	}
//	GtDataTypeID type = GtDataTypeIDFromString(item);
//	if(type == GtDataTypeObject)
//	{
//		return YES;
//	}
//
//	return NO;
//}

- (void) addSourceIncludes:(GtStringBuilder*) builder 
	generator:(GtCodeGenerator*) generator
{
	[builder appendLineWithFormat:@"#import \"%@\"", self.headerFileName];

	for(GtCodeGeneratorTypeDefinition* dependency in self.dependencies)
	{
//		if([self shouldAddDependency:dependency generator:generator])
		{
			if(GtStringIsNotEmpty(dependency.import))
			{
				[builder appendLineWithFormat:@"#import \"%@\"", dependency.import];
			}
		}
	}

}

- (void) generateSource:(GtObjectiveCCodeGenerator*) generator
{
// generate file header for class
	GtStringBuilder* builder = [GtStringBuilder stringBuilder];

	[generator generateFileHeader:builder fileName:self.sourceFileName disabled:self.disabled.boolValue generated:YES];
	
	if(GtStringIsNotEmpty(self.ifDef))
	{
		[builder appendLineWithFormat:@"#if %@", self.ifDef];
	}
	
	[self addSourceIncludes:builder generator:generator];
	
	[builder appendLine];
	
	[builder appendLineWithFormat:@"@implementation %@", self.typeName];
	
	[builder appendLine];
	
	for(GtCodeGeneratorObjectMemberType* staticVar in self.members)
	{
		if([staticVar isKindOfClass:[GtCodeGeneratorObjectMemberType class]])
		{
			if(staticVar.isStatic.boolValue)
			{
				if(GtStringIsNotEmpty(staticVar.defaultValue))
				{
					NSString* defaultValue = staticVar.defaultValue;
					
					if(GtStringsAreEqual(staticVar.typeName, @"NSString"))
					{
						defaultValue = [NSString stringWithFormat:@"@\"%@\"", defaultValue];
					}

					[builder appendLineWithFormat:@"static %@ %@ = %@;", 
						[generator typeStringForGeneratedCode:staticVar.typeName],
						staticVar.name, 
						defaultValue];
				}
				else
				{
					[builder appendLineWithFormat:@"static %@ %@;", 
						[generator typeStringForGeneratedCode:staticVar.typeName], 
						staticVar.name];
				}
			}
		}
	}
	
	[builder appendLine];
		
	for(GtCodeGeneratorCodeSnippet* snippet in self.sourceSnippets)
	{
		[snippet generate:generator object:self builder:builder];
	}
	
	for(GtCodeGeneratorProperty* prop in self.properties)
	{	
		[prop generateSource:generator object:self builder:builder];
	}
	
	for(GtCodeGeneratorMethod* method in self.methods)
	{
		[method generateSource:generator object:self builder:builder];
	}
	
	[builder appendLine];
	[builder appendLine:@"@end"];

	for(GtCodeGeneratorObjectCategory* category in self.categories)
	{
		[builder appendLine];
		[builder appendLine:[NSString stringWithFormat:@"@implementation %@ (%@) ", category.objectName, category.categoryName]];

		for(GtCodeGeneratorProperty* prop in category.properties)
		{
			[prop generateSource:generator object:self builder:builder];
		}
		
		for(GtCodeGeneratorMethod* method in category.methods)
		{
			[method generateSource:generator object:self builder:builder];
		}
	
		[builder appendLine:[NSString stringWithFormat:@"@end"]];
		[builder appendLine];
	}


	[generator generateFileFooter:builder fileName:self.sourceFileName disabled:self.disabled.boolValue];

	if(GtStringIsNotEmpty(self.ifDef))
	{
		[builder appendLine:@"#endif"];
	}


	GtCodeGeneratorFile* cgFile = [GtCodeGeneratorFile codeGeneratorFile];
	cgFile.name = self.sourceFileName;
	cgFile.contents = [builder toString];
	[generator.files addUniqueObject:cgFile];
}


- (void) generateHeader:(GtObjectiveCCodeGenerator*) generator
{
	//		GtThrowIfNilProperty(obj, headerFileName);
	
		// generate file header for class
	GtStringBuilder* builder = [GtStringBuilder stringBuilder];

	[generator generateFileHeader:builder fileName:self.headerFileName	disabled:self.disabled.boolValue generated:YES];

	if(GtStringIsNotEmpty(generator.schema.comment))
	{
		[self generateComment:builder comment:generator.schema.comment singleLine:NO];
		[builder appendLine:@""];
	}

	if(GtStringIsNotEmpty(self.comment))
	{
		[self generateComment:builder comment:self.comment singleLine:NO];
		[builder appendLine:@""];
	}
	
	[builder appendLine:@""];

	if(GtStringIsNotEmpty(self.ifDef))
	{
		[builder appendLineWithFormat:@"#if %@", self.ifDef];
	}

	if(![self.superclass hasPrefix:@"NS"])
	{
		[builder appendLineWithFormat:@"#import \"%@.h\"", self.superclass];
	}
	
	for(GtCodeGeneratorTypeDefinition* dependency in self.dependencies)
	{
//		if( [self shouldAddDependency:dependency generator:generator])
		{
			if(GtStringIsNotEmpty(dependency.import) && !dependency.importIsPrivateValue)
			{
				if(GtStringsAreEqual(dependency.dataType, @"object"))
				{
					[builder appendLineWithFormat:@"@class %@;", dependency.typeName];
				}
				else
				{
					[builder appendLineWithFormat:@"#import \"%@\"", dependency.import];
				}
			}
		
//			if([dependency hasSuffix:@".h"])
//			{
//				[builder appendLineWithFormat:@"#import \"%@\"", dependency];
//			}
//			else
//			{
//				[builder appendLineWithFormat:@"@class %@;", dependency];
//			}
		}
	}

	[builder appendLine];
	
	[builder appendLine:@"// --------------------------------------------------------------------"];
	[builder appendLineWithFormat:@"// %@", self.typeName];
	[builder appendLine:@"// --------------------------------------------------------------------"];

	NSString* protocols = @"";

	if(GtStringIsNotEmpty(self.protocols))
	{
		protocols = [NSString stringWithFormat:@"<%@>", self.protocols];
	}

	[builder appendLine:[NSString stringWithFormat:@"@interface %@ : %@%@{ ", 
		self.typeName, 
		self.superclass,
		protocols]];
	[builder appendLine:@"@private"];
	
	[builder tabIn];
	
	for(GtCodeGeneratorObjectMemberType* type in self.members)
	{
		if(!type.isStatic.boolValue)
		{
			FailIfStringIsEmpty(type.name, @"Expection name for object member for object: %@", self.typeName);
			FailIfStringIsEmpty(type.typeName, @"Expection type for object member for object: %@", self.typeName);
			[builder appendLineWithFormat:@"%@ %@;", [generator typeStringForGeneratedCode:type.typeName], type.name];
		}
	
	}
	[builder tabOut];
		
		
	[builder appendLine:[NSString stringWithFormat:@"} "]];

	[builder appendLine];
		
	if(self.isSingleton.boolValue)
	{
		[builder appendLineWithFormat:@"GtSingletonProperty(%@); // See GtSingleton.h/m ", GtRemovePointerSplat(self.typeName)];
		[builder appendLine];
	}

	for(GtCodeGeneratorProperty* prop in self.properties)
	{
		[prop generateDeclaration:generator object:self builder:builder];
	}
	
	for(GtCodeGeneratorMethod* method in self.methods)
	{
		if(!method.isPrivate.boolValue)
		{
			[method generateDeclaration:generator object:self builder:builder];
		}
	}

	[builder appendLine];
	[builder appendLine:[NSString stringWithFormat:@"@end"]];


	for(GtCodeGeneratorObjectCategory* category in self.categories)
	{
		[builder appendLine];
		[builder appendLine:[NSString stringWithFormat:@"@interface %@ (%@) ", category.objectName, category.categoryName]];

		for(GtCodeGeneratorProperty* prop in category.properties)
		{
			[prop generateDeclaration:generator object:self builder:builder];
		}
		
		for(GtCodeGeneratorMethod* method in category.methods)
		{
			if(!method.isPrivate.boolValue)
			{
				[method generateDeclaration:generator object:self builder:builder];
			}
		}
	
		[builder appendLine:[NSString stringWithFormat:@"@end"]];
		[builder appendLine];
	}

	[generator generateFileFooter:builder fileName:self.headerFileName	disabled:self.disabled.boolValue];

	if(GtStringIsNotEmpty(self.ifDef))
	{
		[builder appendLine:@"#endif"];
	}


	GtCodeGeneratorFile* cgFile = [GtCodeGeneratorFile codeGeneratorFile];
	cgFile.name = self.headerFileName;
	cgFile.contents = [builder toString];
	[generator.files addUniqueObject:cgFile];
}

- (void) generate:(GtObjectiveCCodeGenerator*) generator
{
	[self generateHeader:generator];
	[self generateSource:generator];
}

@end
