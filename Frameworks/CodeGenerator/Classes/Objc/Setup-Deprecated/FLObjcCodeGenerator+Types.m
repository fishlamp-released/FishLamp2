//
//  FLObjcCodeGenerator+Types.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 3/16/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//
#if REFACTOR

#import "FLObjcCodeGenerator+Types.h"
#import "FLCodeGeneratorErrors.h"
#import "FLCodeDataType+ObjC.h"
#import "FLObjcUtilities.h"
@interface FLObjcCodeGenerator (TypesPrivate)
// enums

//- (NSString*) fullyQualifiedEnumTypeName:(FLCodeEnumType*) enumType;
//- (NSString*) fullyQualifiedEnumName:(NSString*) parentName enum:(FLCodeEnum*) theEnum;
//- (NSString*) fullyQualifiedEnumTypeName:(FLCodeEnumType*) theEnumType withEnum:(FLCodeEnum*) theEnum;

// object
- (void) setTypeName:(NSString*) type forObject:(FLCodeObject*) object;
- (FLCodeVariable*) memberByName:(NSString*) memberName forObject:(FLCodeObject*) object;
- (NSString*) typeDescriptorNameForProperty:(NSString*) name forObject:(FLCodeObject*) object;



// storage options
- (NSString*) storageMaskForStorageOptions:(FLCodeStorageOptions*) option;

// data types



// data type utils


- (void) addDependency:(FLCodeTypeDefinition*) dependency;

- (void) renamePropertyTypes:(NSString*) oldName newName:(NSString*) newName;

@end

@implementation FLObjcCodeGenerator (Types)

- (NSString*) enumFromStringFunctionName {
	return [NSString stringWithFormat:@"_%@EnumFromString", self.project.schemaName];
}

- (NSString*) enumLookupObjectName {
	return [NSString stringWithFormat:@"%@EnumLookup", [self prefixedTypeName:self.project.schemaName]];
}

- (NSString*) toStringFromEnumFunctionName:(NSString*) typeName {
	return [NSString stringWithFormat:@"stringFrom%@", [[self removeTypePrefixFromString:typeName] stringWithUpperCaseFirstLetter]];
}

- (NSString*) toEnumFromStringFunctionName:(NSString*) typeName {
	return [NSString stringWithFormat:@"%@FromString", [[self removeTypePrefixFromString:typeName] stringWithLowercaseFirstLetter]];
}


- (NSString*) fullyQualifiedEnumTypeName:(FLCodeEnumType*) enumType {
	return [self prefixedTypeName:enumType.typeName];
}

- (NSString*) fullyQualifiedEnumName:(FLCodeEnumType*) theEnumType withEnum:(FLCodeEnum*) theEnum{
	return [NSString stringWithFormat:@"%@%@", [self prefixedTypeName:theEnumType.typeName], theEnum.name];
}


- (NSString*) typeStringForGeneratedCode:(NSString*) typeName
{
	FLCodeTypeDefinition* type = [self typeDefinitionForTypeName:typeName];
    if(!type) {
        FLThrowErrorCodeWithComment( FLErrorDomain, FLErrorCodeUnknownTypeErrorCode, @"Unknown Type: %@", type);
    }
	
	return [self dataTypeIsObject:type] ? [NSString stringWithFormat:@"%@*", typeName] : typeName;
}

- (void) setTypeName:(NSString*) type forObject:(FLCodeObject*) object {
	[object setTypeName:type];
	
	if(FLStringIsEmpty(object.name)) {
		object.name = type;
	}
}

- (FLCodeVariable*) memberByName:(NSString*) memberName forObject:(FLCodeObject*) object {
	for(FLCodeObjectMemberType* member in object.members) {
		if([member.name isEqualToString:memberName]) {
			return member;
		}
	}
	return nil;
}


- (FLCodeObjectCategory*) categoryByName:(NSString*) name forObject:(FLCodeObject*) object {	
	for(FLCodeObjectCategory* cat in object.categories) {
		if(FLStringsAreEqual(name, cat.categoryName)) {
			return cat;
		}
	}

	return nil;
}

- (NSString*) typeDescriptorNameForProperty:(NSString*) name forObject:(FLCodeObject*) object {
	return [NSString stringWithFormat:@"s_%@TypeDescriptor", name];
}

- (NSString*) getterNameForProperty:(FLCodeProperty*) property{
	return property.name;
}

- (NSString*) setterNameForProperty:(FLCodeProperty*) property{
	return [NSString stringWithFormat:@"set%@", [property.name stringWithUpperCaseFirstLetter]];
}

- (BOOL) isEnumProperty:(FLCodeProperty*) property{

	if( [self enumTypeForTypeName:property.type] != nil || FLStringIsNotEmpty(property.enumTypeObject.typeName)) {
		return YES;
	}

	FLCodeTypeDefinition* type = [self typeDefinitionForTypeName:property.type];
	if(type) {
		return [self dataTypeIsEnum:type];
	}

    FLThrowErrorCodeWithComment( FLErrorDomain, FLErrorCodeUnknownTypeErrorCode, @"Unknown Type: %@", property.type);

	return NO;
}

- (BOOL) isValueProperty:(FLCodeProperty*) property{
	
    
//	FLCodeTypeDefinition* typeDef = [self typeDefinitionForTypeName:property.type];
//    if(!typeDef) {
//        FLThrowErrorCodeWithComment( FLErrorDomain, FLErrorCodeUnknownTypeErrorCode, @"Unknown Type: %@", property.type);
//    }
//
//    FLCodeDataType* type = [self typeFromObjcString:property.typeUnmodified];
//    
//	return [self isEnumProperty:property] || [self dataTypeIsEnum:typeDef] || type.isNumber || type.isValue;

    FLAssertFailed();

    return NO;
}

   
- (BOOL) willLazyCreate:(FLCodeProperty*) property{
	return	[self canCreateMemberDataForProperty:property] && [property canLazyCreate];
}

- (BOOL) canCreateMemberDataForProperty:(FLCodeProperty*) property{
FLAssertFailed();
    return NO;

//	FLCodeDataType* type = [self typeFromObjcString:property.typeUnmodified];
//    
//    return	!property.isImmutable &&
//			![self isEnumProperty:property] &&
//            type.isObject && !type.isKnownObjectType;
            
//			FLTypeIsObject(FLTypeFromString(property.typeUnmodified)) && !FLIsIdType(property.type);
}

- (NSString*) storageMaskForStorageOptions:(FLCodeStorageOptions*) option {
	NSMutableString* storageMask = [NSMutableString string];

	if(!option.isStorable) {
		[storageMask appendString:@"FLStorageAttributeNotStored"];
	}
	else {
		[storageMask appendString:@"FLStorageAttributeStored"];
	}
	
    if(option.isPrimaryKey) {
		[storageMask appendString:@"|FLStorageAttributePrimaryKey"];
	}
	
    if(option.isIndexed) {
		[storageMask appendString:@"|FLStorageAttributeIndexed"];
	}
	
    if(option.isRequired) {
		[storageMask appendString:@"|FLStorageAttributeRequired"];
	}
	
    if(option.isUnique) {
		[storageMask appendString:@"|FLStorageAttributeUnique"];
	}
	
	return storageMask;
}

- (BOOL) dataTypeIsEnum:(FLCodeTypeDefinition*) typeDef {
	return [typeDef dataTypeAsEnum] == FLCodeTypeEnum;
}

- (BOOL) dataTypeIsObject:(FLCodeTypeDefinition*) typeDef {
	return FLStringIsEmpty(typeDef.dataType) || [typeDef dataTypeAsEnum] == FLCodeDataTypeObject;
}

- (BOOL) dataTypeIsValue:(FLCodeTypeDefinition*) typeDef {
	return [typeDef dataTypeAsEnum] == FLCodeDataTypeValue;
}


- (BOOL) prefixedTypeNamesAreEqual:(NSString*) lhs rhs:(NSString*) rhs {
    return FLStringsAreEqualCaseInsensitive(lhs, rhs) ||
           FLStringsAreEqualCaseInsensitive(lhs, [self prefixedTypeName:rhs]) ||
           FLStringsAreEqualCaseInsensitive([self prefixedTypeName:lhs], rhs);
}

- (NSString*) prefixedTypeNameForKnownType:(NSString*) type  {
    FLConfirmStringIsNotEmpty(type);
    
    NSString* outType = type;
    
    FLCodeTypeDefinition* def = [self typeDefinitionForTypeName:type];
    if(!def) {
        outType = [self prefixedTypeName:type];
        
        FLConfirmStringIsNotEmpty(outType);

        def = [self typeDefinitionForTypeName:outType];
        if(!def) {
            FLThrowErrorCodeWithComment( FLErrorDomain, FLErrorCodeUnknownTypeErrorCode, @"Can't find definition for either: %@ or %@", type, outType);
        }
    }

    return outType;
}


- (void) addPrefixToObjects:(NSArray*) objects  {
	if(FLStringIsNotEmpty(self.project.generatorOptions.typePrefix)) {	
		NSString* prefix = self.project.generatorOptions.typePrefix;

		for(FLCodeObject* obj in objects) {
			if(![obj.typeName hasPrefix:prefix]) {
				NSString* newType = [NSString stringWithFormat:@"%@%@", prefix, obj.typeName];
				[self renamePropertyTypes:obj.typeName newName:newType];
				obj.typeName = newType;
			}
		}
	}
}

- (NSString*) removeTypePrefixFromString:(NSString*) name  {
	NSString* prefix = self.project.generatorOptions.typePrefix;
	if(FLStringIsEmpty(prefix)) {
		return name;
	}
	
	return [name substringFromIndex:[name rangeOfString:prefix].length];
}

- (FLCodeEnumType*) enumTypeForTypeName:(NSString*) typeName  {

	for(FLCodeEnumType* enumType in self.project.enumTypes) {
		NSString* lhs = [self prefixedTypeName:typeName];
		NSString* rhs = [self prefixedTypeName:enumType.typeName];
	
		if([lhs isEqualToString:rhs]) {
			return enumType;
		}			 
	}

	return nil;
}

// TODO: abstract this for other languages?
- (NSString*) prefixedTypeName:(NSString*) typeName  {

    NSString* prefix = _project.generatorOptions.typePrefix;
	if(!FLStringIsEmpty(prefix ) &&
		[typeName rangeOfString:prefix].location != 0) {

		return [NSString stringWithFormat:@"%@%@", prefix, [typeName stringWithUpperCaseFirstLetter]];
	}
	
	return typeName;
}

- (void) renamePropertyTypes:(NSString*) old newName:(NSString*) new {
	for(FLCodeObject* obj in self.project.objects) {
		for(FLCodeProperty* prop in obj.properties) {
			if([prop.type isEqualToString:old]) {
				prop.type = new;
			}
			
			for(FLCodeVariable* arrayType in prop.arrayTypes) {
				if([arrayType.typeName isEqualToString:old]) {
					arrayType.typeName = new;
				}
			}
		}
		
		if([obj.superclass isEqualToString:old]) {
			obj.superclass = new;
		}
	}
	
	for(FLCodeArray* array in self.project.arrays) {
		for(FLCodeVariable* arrayType in array.types) {
			if([arrayType.typeName isEqualToString:old]) {
				arrayType.typeName = new;
			}
		}
	}
}

- (FLCodeTypeDefinition*) typeDefinitionForTypeName:(NSString*) typeName  {
                                        
	for(FLCodeTypeDefinition* type in self.project.typeDefinitions) {
		if( FLStringsAreEqualCaseInsensitive(type.typeName, typeName)) {
			return type;
		}
	}
   
	return nil;
}



- (FLCodeObject*) objectForTypeName:(NSString*) type  {
	for(FLCodeObject* bizObj in self.project.objects) {
		if(FLStringsAreEqualCaseInsensitive(bizObj.typeName, type)){
			return bizObj;
		}
	}
	
	return nil;
}

- (void) addDependency:(FLCodeTypeDefinition*) dependency  {
	for(FLCodeTypeDefinition* aDef in self.project.dependencies) {
		if(FLStringsAreEqualCaseInsensitive(aDef.typeName, dependency.typeName)) {
			return;
		}
	}	

	[self.project.dependencies addObject:dependency];
}

- (void) addDependency:(NSString*) item forObject:(FLCodeObject*) object{
	    
    FLConfirmStringIsNotEmpty(item);
    
    // check to see if we've already added this dependency
    for(FLCodeTypeDefinition* aDef in object.dependencies) {
		if(FLStringsAreEqual(aDef.typeName, item)) {
			return;
		}
	}	

    FLCodeTypeDefinition* def = [self typeDefinitionForTypeName:item];
    if(!def) {
        FLThrowErrorCodeWithComment(FLErrorDomain, FLErrorCodeUnknownTypeErrorCode, @"Unknown Type: %@", item);
    }

	[object.dependencies addUniqueObject:def];
}

- (void) addTypeDefinition:(FLCodeTypeDefinition*) definition  {
	for(FLCodeTypeDefinition* aDef in self.project.typeDefinitions) {
		if(FLStringsAreEqualCaseInsensitive(aDef.typeName, definition.typeName) ) {
			return;
		}
	}	

	[self.project.typeDefinitions addObject:definition];
}

- (FLCodeDataType*) typeFromObjcString:(NSString*) typeString {

    return nil;
}



@end
#endif
