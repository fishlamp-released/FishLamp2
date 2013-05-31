// [Generated]
//
// This file was generated at 7/10/12 5:37 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeProject.h
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLModelObject.h"


@class FLCodeCompany;
@class FLCodeCodeLicense;
@class FLCodeGeneratorOptions;
@class FLCodeArray;
@class FLCodeDefine;
@class FLCodeTypeDefinition;
@class FLCodeEnumType;
@class FLCodeImport;
@class FLCodeObject;

// FLCodeProject
@interface FLCodeProject : FLModelObject { 
@private
    FLCodeCompany* __organization;
    FLCodeCodeLicense* __license;
    NSString* __projectName;
    NSString* __schemaName;
    BOOL __isWildcardArray;
    BOOL __disabled;
    BOOL __canLazyCreate;
    NSString* __ifDef;
    NSString* __comment;
    FLCodeGeneratorOptions* __generatorOptions;
    NSMutableArray* __enumTypes;
    NSMutableArray* __objects;
    NSMutableArray* __dependencies;
    NSMutableArray* __defines;
    NSMutableArray* __arrays;
    NSMutableArray* __imports;
    NSMutableArray* __typeDefinitions;
    NSURL* __projectPath;
}

/// @brief: Getter will create __arrays if nil. Alternately, use the arraysObject property, which will not lazy create it.
@property (readwrite, strong, nonatomic) NSMutableArray* arrays;
/// Type: FLCodeArray*, forKey: array

@property (readwrite, assign, nonatomic) BOOL canLazyCreate;

@property (readwrite, strong, nonatomic) NSString* comment;

/// @brief: Getter will create __defines if nil. Alternately, use the definesObject property, which will not lazy create it.
@property (readwrite, strong, nonatomic) NSMutableArray* defines;
/// Type: FLCodeDefine*, forKey: define

/// @brief: Getter will create __dependencies if nil. Alternately, use the dependenciesObject property, which will not lazy create it.
@property (readwrite, strong, nonatomic) NSMutableArray* dependencies;
/// Type: FLCodeTypeDefinition*, forKey: dependency

/// @brief: don't compile this object is set to YES
@property (readwrite, assign, nonatomic) BOOL disabled;

/// @brief: Getter will create __enumTypes if nil. Alternately, use the enumTypesObject property, which will not lazy create it.
@property (readwrite, strong, nonatomic) NSMutableArray* enumTypes;
/// Type: FLCodeEnumType*, forKey: enumType

/// @brief: Getter will create __generatorOptions if nil. Alternately, use the generatorOptionsObject property, which will not lazy create it.
@property (readwrite, strong, nonatomic) FLCodeGeneratorOptions* generatorOptions;

@property (readwrite, strong, nonatomic) NSString* ifDef;

/// @brief: Getter will create __imports if nil. Alternately, use the importsObject property, which will not lazy create it.
@property (readwrite, strong, nonatomic) NSMutableArray* imports;
/// Type: FLCodeImport*, forKey: import

@property (readwrite, assign, nonatomic) BOOL isWildcardArray;

/// @brief: Getter will create __license if nil. Alternately, use the licenseObject property, which will not lazy create it.
@property (readwrite, strong, nonatomic) FLCodeCodeLicense* license;

/// @brief: Getter will create __objects if nil. Alternately, use the objectsObject property, which will not lazy create it.
@property (readwrite, strong, nonatomic) NSMutableArray* objects;
/// Type: FLCodeObject*, forKey: object

/// @brief: Getter will create __organization if nil. Alternately, use the organizationObject property, which will not lazy create it.
@property (readwrite, strong, nonatomic) FLCodeCompany* organization;

@property (readwrite, strong, nonatomic) NSString* projectName;

@property (readwrite, strong, nonatomic) NSURL* projectPath;

/// @brief: name of the project for the file headers
@property (readwrite, strong, nonatomic) NSString* schemaName;

/// @brief: Getter will create __typeDefinitions if nil. Alternately, use the typeDefinitionsObject property, which will not lazy create it.
@property (readwrite, strong, nonatomic) NSMutableArray* typeDefinitions;
/// Type: FLCodeTypeDefinition*, forKey: typeDefinition


+ (FLCodeProject*) project; 


/// @brief: This returns __organization. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) FLCodeCompany* organizationObject;

/// @brief: This returns __license. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) FLCodeCodeLicense* licenseObject;

/// @brief: This returns __generatorOptions. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) FLCodeGeneratorOptions* generatorOptionsObject;

/// @brief: This returns __enumTypes. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) NSMutableArray* enumTypesObject;
/// Type: FLCodeEnumType*, forKey: enumType

/// @brief: This returns __objects. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) NSMutableArray* objectsObject;
/// Type: FLCodeObject*, forKey: object

/// @brief: This returns __dependencies. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) NSMutableArray* dependenciesObject;
/// Type: FLCodeTypeDefinition*, forKey: dependency

/// @brief: This returns __defines. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) NSMutableArray* definesObject;
/// Type: FLCodeDefine*, forKey: define

/// @brief: This returns __arrays. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) NSMutableArray* arraysObject;
/// Type: FLCodeArray*, forKey: array

/// @brief: This returns __imports. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) NSMutableArray* importsObject;
/// Type: FLCodeImport*, forKey: import

/// @brief: This returns __typeDefinitions. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) NSMutableArray* typeDefinitionsObject;
/// Type: FLCodeTypeDefinition*, forKey: typeDefinition

- (void) createOrganizationIfNil; 

- (void) createLicenseIfNil; 

- (void) createGeneratorOptionsIfNil; 

- (void) createEnumTypesIfNil; 

- (void) createObjectsIfNil; 

- (void) createDependenciesIfNil; 

- (void) createDefinesIfNil; 

- (void) createArraysIfNil; 

- (void) createImportsIfNil; 

- (void) createTypeDefinitionsIfNil; 
@end

// [/Generated]
