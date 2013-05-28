//
//  FLObjcCodeGenerator+Types.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 3/16/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#if REFACTOR
#import "FLObjcCodeGenerator.h"
#import "FLCodeDataType.h"

@interface FLObjcCodeGenerator (Types)

// prefixing
- (NSString*) prefixedTypeName:(NSString*) typeName;
- (BOOL) prefixedTypeNamesAreEqual:(NSString*) lhs rhs:(NSString*) rhs;
- (NSString*) prefixedTypeNameForKnownType:(NSString*) type ;
- (void) addPrefixToObjects:(NSArray*) objects;
- (NSString*) removeTypePrefixFromString:(NSString*) name;

// objects
- (FLCodeObject*) objectForTypeName:(NSString*) type;
- (void) addDependency:(NSString*) name forObject:(FLCodeObject*) object;

// type definitions
- (FLCodeTypeDefinition*) typeDefinitionForTypeName:(NSString*) typeName;
- (void) addTypeDefinition:(FLCodeTypeDefinition*) definition;
- (BOOL) dataTypeIsEnum:(FLCodeTypeDefinition*) typeDef;
- (BOOL) dataTypeIsObject:(FLCodeTypeDefinition*) typeDef;

// enums
- (BOOL) dataTypeIsValue:(FLCodeTypeDefinition*) typeDef;
- (NSString*) enumLookupObjectName;
- (NSString*) toStringFromEnumFunctionName:(NSString*) typeName;
- (NSString*) toEnumFromStringFunctionName:(NSString*) typeName;
- (NSString*) fullyQualifiedEnumName:(FLCodeEnumType*) theEnumType withEnum:(FLCodeEnum*) theEnum;
- (NSString*) enumFromStringFunctionName;
- (FLCodeEnumType*) enumTypeForTypeName:(NSString*) typeName;

// object property
- (NSString*) getterNameForProperty:(FLCodeProperty*) property;
- (NSString*) setterNameForProperty:(FLCodeProperty*) property;;
- (BOOL) willLazyCreate:(FLCodeProperty*) property;
- (BOOL) canCreateMemberDataForProperty:(FLCodeProperty*) property;
- (BOOL) isValueProperty:(FLCodeProperty*) property;
- (BOOL) isEnumProperty:(FLCodeProperty*) property;
- (FLCodeObjectCategory*) categoryByName:(NSString*) name forObject:(FLCodeObject*) object;	

// misc
- (NSString*) typeStringForGeneratedCode:(NSString*) typeName;

- (FLCodeDataType*) typeFromObjcString:(NSString*) typeString;

@end
#endif