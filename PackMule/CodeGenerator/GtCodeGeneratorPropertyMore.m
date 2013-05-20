//
//	GtCodeGeneratorObjectPropertyMore.m
//	PackMule
//
//	Created by Mike Fullerton on 4/18/10.
//	Copyright 2010 Greentongue Software. All rights reserved.
//

#import "GtCodeGeneratorPropertyMore.h"
#import "GtCodeGeneratorMethodMore.h"
#import "GtCodeGeneratorEnumTypeMore.h"
#import "GtCodeGeneratorTypeDefinition+More.h"

@implementation GtCodeGeneratorProperty (More)

- (NSString*) getterName
{
	return self.name;
}

- (NSString*) setterName
{
	return [NSString stringWithFormat:@"set%@", [self.name stringWithUpperCaseFirstLetter]]; 
}

- (BOOL) isEnumProperty:(GtCodeGenerator*) generator
{
	
	if( [generator getEnum:self.type] != nil || GtStringIsNotEmpty(self.enumTypeObject.typeName)) 
	{
		return YES;
	}

	GtCodeGeneratorTypeDefinition* type = [generator typeForName:self.type];
	if(type)
	{
		return GtStringsAreEqual(type.dataType, @"enum");
	}
	
	return NO;
}


- (BOOL) isValueProperty:(GtCodeGenerator*) generator
{
	GtDataTypeID typeId = GtDataTypeIDFromString(self.originalType);
	GtCodeGeneratorTypeDefinition* type = [generator typeForName:self.type];
	return	([self isEnumProperty:generator] || type.dataTypeIsEnum || GtDataTypeIsNumber(typeId) || GtDataTypeIsValue(typeId));
}

- ( GtCodeGeneratorVariable*) addVariableToObject:(GtCodeGeneratorObject*) obj
{
	if(!self.isImmutable.boolValue /*&& GtStringIsEmpty(self.wildcardPropertyName)*/)
	{
		FailIfStringIsEmpty(self.name, @"name missing");
		FailIfStringIsEmpty(self.type, @"type missing");	
	
		if(GtStringIsEmpty(self.memberName))
		{
			self.memberName = [NSString stringWithFormat:@"m_%@", self.name];
		}
	
		GtCodeGeneratorObjectMemberType* type = [GtCodeGeneratorObjectMemberType codeGeneratorObjectMemberType];
		type.typeName = self.type;
		type.name = self.memberName;
		type.defaultValue = self.defaultValue;
		type.isStatic = self.isStatic;
		[obj.members addObject:type];
		return type;
	}
	
	return nil;
}

- (BOOL) canCreateMemberData:(GtCodeGenerator*) generator
{
	return	!self.isImmutable.boolValue &&
			![self isEnumProperty:generator] &&
			GtDataTypeIDFromString(self.originalType) == GtDataTypeObject && !GtIsIdType(self.type);
			
}	
   
- (BOOL) willLazyCreate:(GtCodeGenerator*) generator
{
	return	[self canCreateMemberData:generator] && self.canLazyCreateValue;
}	
 
- (void) generateSource:(GtObjectiveCCodeGenerator*) generator object:(GtCodeGeneratorObject*) obj builder:(GtStringBuilder*) builder
{
	if(	!self.isStaticValue && 
		!self.isImmutable &&
		((!self.isReadOnly && !self.setter.hasLines) || !self.getter.hasLines))
	{
		[builder appendLineWithFormat:@"@synthesize %@ = %@;", self.name, self.memberName];
	}
	if(self.getter.hasLines)
	{
		[self.getter generateSource:generator object:obj builder:builder];
	}
	if(self.setter.hasLines && !self.isReadOnly)
	{
		[self.setter generateSource:generator object:obj builder:builder];
	}
}

- (void) addComment:(GtStringBuilder*) builder
{
	if(GtStringIsNotEmpty(self.comment))
	{
		[builder appendLineWithFormat:@"// %@", self.comment];
	}
}

- (void) generateDeclaration:(GtObjectiveCCodeGenerator*) generator object:(GtCodeGeneratorObject*) obj builder:(GtStringBuilder*) builder
{
	if(!self.isPrivate.boolValue)
	{
		FailIfStringIsEmpty(self.name, @"prop name is empty");
		FailIfStringIsEmpty(self.type, @"type is empty");

		NSString* dataType = self.type; // [self dataTypeForCode:generator];
		
		[builder appendLine];
		
		if(self.isStatic.boolValue)
		{
			// can't use @property for static properties, so declare them manually
			
			[builder appendLineWithFormat:@"+ (%@) %@;", [generator typeStringForGeneratedCode:dataType], self.getterName];
			 
			[self addComment:builder];
			
			if(!self.isReadOnly.boolValue && !self.isImmutable.boolValue)
			{
				[builder appendLineWithFormat:@"+ (void) %@:(%@) %@;", self.setterName, [generator typeStringForGeneratedCode:dataType], self.name];
			}
		}
		else
		{
			NSString* generatedType = [generator typeStringForGeneratedCode:dataType];

//			if([self willLazyCreate:generator])
//			{
//				[builder appendLineWithFormat:@"- (void) %@:(%@) value;", self.setterName, generatedType];
//				[builder appendLineWithFormat:@"- (%@) %@:(BOOL) lazyCreateIfNeeded;",  generatedType, self.getterName];
//			}
//			else
			{
				BOOL isRetainProperty = [generatedType rangeOfString:@"*"].length > 0;
				
				[builder appendLineWithFormat:@"@property (%@, %@, nonatomic) %@ %@;", 
					(self.isReadOnly.boolValue || self.isImmutable.boolValue ? @"readonly" : @"readwrite"), 
					(isRetainProperty ? @"retain" : @"assign"),
					generatedType, self.getterName];
			}
			[self addComment:builder];
			
			if(self.arrayTypes.count > 0)
			{
				for(GtCodeGeneratorVariable* type in self.arrayTypes)
				{
					[builder appendLineWithFormat:@"// Type: %@, forKey: %@", 
						[generator typeStringForGeneratedCode:GtObjcObjectTypeStringFromString(type.typeName)], type.name];
				}
			}
			
		}
		
	}
}

- (NSString*) initializerString
{
	if(GtDataTypeIDFromString(self.type) == GtDataTypeString && ![self.defaultValue hasPrefix:@"@\""])
	{
		return [NSString stringWithFormat:@"@\"%@\"", self.defaultValue];
	}

	return self.defaultValue;
}

- (void) addVariablesToParentObject:(GtCodeGeneratorObject*) obj
{
	if(!self.hasCustomCode.boolValue && !self.isImmutable.boolValue)
	{	
		[self addVariableToObject:obj];
	}
} 

- (void) addSetter
{
	GtCodeGeneratorVariable* parameter = [GtCodeGeneratorVariable codeGeneratorVariable];
	parameter.name = @"value";
	parameter.typeName = self.type;
	[self.setter.parameters addObject:parameter];

	self.setter.code.lines = [NSString stringWithFormat:@"GtAssignObject(%@, value);", self.memberName];
} 
  
- (void) buildCode:(GtObjectiveCCodeGenerator*) generator object:(GtCodeGeneratorObject*) obj
{	
	FailIfStringIsEmpty(self.name, @"property has no name");
	FailIfStringIsEmpty(self.type, @"property has no type");
	
	NSString* typeString = self.type; 
   
	if(self.isImmutableValue)
	{
		if(!self.getter.hasLines)
		{
			self.getter.code.lines = [NSString stringWithFormat:@"return %@;", self.initializerString];	   
		}
	}
	else if(self.isStaticValue)
	{
		BOOL setGetter = self.getter.hasLines;
		BOOL setSetter = self.setter.hasLines;

//		if([self willLazyCreate:generator] && ![self getter:NO])
//		{
////			if(GtStringIsEmpty(self.comment))
////			{
////				self.comment = @"";
////			}
////			else
////			{
////				self.comment = [NSString stringWithFormat:@"%@\n// LazyCreate: YES", self.comment]; 
////			}
//		
//			FailIfStringIsEmpty(self.memberName, @"property has no member name");
//			GtStringBuilder* builder = [GtStringBuilder stringBuilder];
//

//			
////			[builder appendLineWithFormat:@"GtAssert(%@ != nil, @\"Previously lazy created object is nil\");", self.memberName];
//
////			[builder appendLine:@"// LazyCreate if needed"];
////			[builder appendLineWithFormat:@"if(!%@ && lazyCreateIfNeeded)", self.memberName];
////			[builder appendLine:@"{"];
////			[builder tabIn];
////			[builder appendLineWithFormat:@"%@ = [[%@ alloc] init];", self.memberName, GtRemovePointerSplat(typeString)];
////			[builder tabOut];
////			[builder appendLine:@"}"];
//			
//			[builder appendLineWithFormat:@"return [self %@:YES];", self.getterName];
//			self.getter.code.lines = [builder toString];
//			setGetter = YES;
//		}
	   
		if(!setGetter && !setSetter && !self.isReadOnly.boolValue)
		{
			FailIfStringIsEmpty(self.memberName, @"property has no member name");

			self.getter.code.lines = [NSString stringWithFormat:@"return %@;", self.memberName];
			
			[self addSetter]; 
		
			setGetter = YES;
			setSetter = YES;
		}
		
		if(!setGetter)
		{
			FailIfStringIsEmpty(self.memberName, @"property has no member name");
			self.getter.code.lines = [NSString stringWithFormat:@"return %@;", self.memberName];
			setGetter = YES;
		}
		
		if(!setSetter && !self.isReadOnly.boolValue)
		{
			FailIfStringIsEmpty(self.memberName, @"property has no member name");
			[self addSetter]; 
			setSetter = YES;
		}
	}
	
	self.getter.name = self.getterName;
	self.getter.isPrivate = [NSNumber numberWithBool:self.isPrivate.boolValue || self.isImmutable.boolValue];
	self.getter.returnType = typeString;
	self.getter.isStatic = self.isStatic;
	self.getter.comment = self.comment;

	self.setter.name = self.setterName;
	self.setter.isPrivate = [NSNumber numberWithBool:self.isPrivate.boolValue || self.isImmutable.boolValue];
	self.setter.isStatic = self.isStatic;
}

@end
