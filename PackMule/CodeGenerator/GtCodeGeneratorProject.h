//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorProject.h
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


@class GtCodeGeneratorOptions;
@class GtCodeGeneratorArray;
@class GtCodeGeneratorDefine;
@class GtCodeGeneratorTypeDefinition;
@class GtCodeGeneratorEnumType;
@class GtCodeGeneratorProject;
@class GtCodeGeneratorObject;

// --------------------------------------------------------------------
// GtCodeGeneratorProject
// --------------------------------------------------------------------
@interface GtCodeGeneratorProject : NSObject<NSCopying>{ 
@private
	NSString* m_projectName;
	NSString* m_companyName;
	NSString* m_schemaName;
	NSNumber* m_isWildcardArray;
	NSNumber* m_disabled;
	NSNumber* m_canLazyCreate;
	NSString* m_ifDef;
	NSString* m_fileUrl;
	NSString* m_comment;
	GtCodeGeneratorOptions* m_generatorOptions;
	NSMutableArray* m_enumTypes;
	NSMutableArray* m_objects;
	NSMutableArray* m_dependencies;
	NSMutableArray* m_defines;
	NSMutableArray* m_arrays;
	NSMutableArray* m_imports;
	NSMutableArray* m_typeDefinitions;
	NSString* m_parentProjectPath;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* arrays;
// Getter will create m_arrays if nil. Alternately, use the arraysObject property, which will not lazy create it.
// Type: GtCodeGeneratorArray*, forKey: array

@property (readwrite, retain, nonatomic) NSNumber* canLazyCreate;

@property (readwrite, retain, nonatomic) NSString* comment;

@property (readwrite, retain, nonatomic) NSString* companyName;
// name of the company for the file headers

@property (readwrite, retain, nonatomic) NSMutableArray* defines;
// Getter will create m_defines if nil. Alternately, use the definesObject property, which will not lazy create it.
// Type: GtCodeGeneratorDefine*, forKey: define

@property (readwrite, retain, nonatomic) NSMutableArray* dependencies;
// Getter will create m_dependencies if nil. Alternately, use the dependenciesObject property, which will not lazy create it.
// Type: GtCodeGeneratorTypeDefinition*, forKey: dependency

@property (readwrite, retain, nonatomic) NSNumber* disabled;
// don't compile this object is set to YES

@property (readwrite, retain, nonatomic) NSMutableArray* enumTypes;
// Getter will create m_enumTypes if nil. Alternately, use the enumTypesObject property, which will not lazy create it.
// Type: GtCodeGeneratorEnumType*, forKey: enumType

@property (readwrite, retain, nonatomic) NSString* fileUrl;

@property (readwrite, retain, nonatomic) GtCodeGeneratorOptions* generatorOptions;
// Getter will create m_generatorOptions if nil. Alternately, use the generatorOptionsObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* ifDef;

@property (readwrite, retain, nonatomic) NSMutableArray* imports;
// Getter will create m_imports if nil. Alternately, use the importsObject property, which will not lazy create it.
// Type: GtCodeGeneratorProject*, forKey: import

@property (readwrite, retain, nonatomic) NSNumber* isWildcardArray;

@property (readwrite, retain, nonatomic) NSMutableArray* objects;
// Getter will create m_objects if nil. Alternately, use the objectsObject property, which will not lazy create it.
// Type: GtCodeGeneratorObject*, forKey: object

@property (readwrite, retain, nonatomic) NSString* parentProjectPath;

@property (readwrite, retain, nonatomic) NSString* projectName;

@property (readwrite, retain, nonatomic) NSString* schemaName;
// name of the project for the file headers

@property (readwrite, retain, nonatomic) NSMutableArray* typeDefinitions;
// Getter will create m_typeDefinitions if nil. Alternately, use the typeDefinitionsObject property, which will not lazy create it.
// Type: GtCodeGeneratorTypeDefinition*, forKey: typeDefinition

+ (NSString*) arraysKey;

+ (NSString*) canLazyCreateKey;

+ (NSString*) commentKey;

+ (NSString*) companyNameKey;

+ (NSString*) definesKey;

+ (NSString*) dependenciesKey;

+ (NSString*) disabledKey;

+ (NSString*) enumTypesKey;

+ (NSString*) fileUrlKey;

+ (NSString*) generatorOptionsKey;

+ (NSString*) ifDefKey;

+ (NSString*) importsKey;

+ (NSString*) isWildcardArrayKey;

+ (NSString*) objectsKey;

+ (NSString*) parentProjectPathKey;

+ (NSString*) projectNameKey;

+ (NSString*) schemaNameKey;

+ (NSString*) typeDefinitionsKey;

+ (GtCodeGeneratorProject*) codeGeneratorProject; 

@end

@interface GtCodeGeneratorProject (ValueProperties) 

@property (readwrite, assign, nonatomic) BOOL isWildcardArrayValue;

@property (readwrite, assign, nonatomic) BOOL disabledValue;
// don't compile this object is set to YES

@property (readwrite, assign, nonatomic) BOOL canLazyCreateValue;
@end


@interface GtCodeGeneratorProject (ObjectMembers) 

@property (readonly, retain, nonatomic) GtCodeGeneratorOptions* generatorOptionsObject;
// This returns m_generatorOptions. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) NSMutableArray* enumTypesObject;
// This returns m_enumTypes. It does NOT create it if it's NIL.
// Type: GtCodeGeneratorEnumType*, forKey: enumType

@property (readonly, retain, nonatomic) NSMutableArray* objectsObject;
// This returns m_objects. It does NOT create it if it's NIL.
// Type: GtCodeGeneratorObject*, forKey: object

@property (readonly, retain, nonatomic) NSMutableArray* dependenciesObject;
// This returns m_dependencies. It does NOT create it if it's NIL.
// Type: GtCodeGeneratorTypeDefinition*, forKey: dependency

@property (readonly, retain, nonatomic) NSMutableArray* definesObject;
// This returns m_defines. It does NOT create it if it's NIL.
// Type: GtCodeGeneratorDefine*, forKey: define

@property (readonly, retain, nonatomic) NSMutableArray* arraysObject;
// This returns m_arrays. It does NOT create it if it's NIL.
// Type: GtCodeGeneratorArray*, forKey: array

@property (readonly, retain, nonatomic) NSMutableArray* importsObject;
// This returns m_imports. It does NOT create it if it's NIL.
// Type: GtCodeGeneratorProject*, forKey: import

@property (readonly, retain, nonatomic) NSMutableArray* typeDefinitionsObject;
// This returns m_typeDefinitions. It does NOT create it if it's NIL.
// Type: GtCodeGeneratorTypeDefinition*, forKey: typeDefinition

- (void) createGeneratorOptionsIfNil; 

- (void) createEnumTypesIfNil; 

- (void) createObjectsIfNil; 

- (void) createDependenciesIfNil; 

- (void) createDefinesIfNil; 

- (void) createArraysIfNil; 

- (void) createImportsIfNil; 

- (void) createTypeDefinitionsIfNil; 
@end

