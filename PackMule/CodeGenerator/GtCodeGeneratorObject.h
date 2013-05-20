//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorObject.h
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


#import "GtCodeGeneratorType.h"
@class GtCodeGeneratorStorageOptions;
@class GtCodeGeneratorObjectCategory;
@class GtCodeGeneratorTypeDefinition;
@class GtCodeGeneratorVariable;
@class GtCodeGeneratorMethod;
@class GtCodeGeneratorProperty;
@class GtCodeGeneratorCodeSnippet;

// --------------------------------------------------------------------
// GtCodeGeneratorObject
// --------------------------------------------------------------------
@interface GtCodeGeneratorObject : GtCodeGeneratorType<NSCopying>{ 
@private
	NSString* m_protocols;
	NSString* m_name;
	GtCodeGeneratorStorageOptions* m_storageOptions;
	NSString* m_comment;
	NSString* m_superclass;
	NSNumber* m_disabled;
	NSNumber* m_canLazyCreate;
	NSNumber* m_isWildcardArray;
	NSString* m_ifDef;
	NSNumber* m_isSingleton;
	NSMutableArray* m_properties;
	NSMutableArray* m_dependencies;
	NSMutableArray* m_members;
	NSMutableArray* m_methods;
	NSMutableArray* m_sourceSnippets;
	NSMutableArray* m_initLines;
	NSMutableArray* m_deallocLines;
	NSMutableArray* m_categories;
	NSString* m_sourceFileName;
	NSString* m_headerFileName;
} 


@property (readwrite, retain, nonatomic) NSNumber* canLazyCreate;

@property (readwrite, retain, nonatomic) NSMutableArray* categories;
// Getter will create m_categories if nil. Alternately, use the categoriesObject property, which will not lazy create it.
// Type: GtCodeGeneratorObjectCategory*, forKey: category

@property (readwrite, retain, nonatomic) NSString* comment;
// comment for this object

@property (readwrite, retain, nonatomic) NSMutableArray* deallocLines;
// Getter will create m_deallocLines if nil. Alternately, use the deallocLinesObject property, which will not lazy create it.
// Type: NSString*, forKey: deallocLine

@property (readwrite, retain, nonatomic) NSMutableArray* dependencies;
// Getter will create m_dependencies if nil. Alternately, use the dependenciesObject property, which will not lazy create it.
// Type: GtCodeGeneratorTypeDefinition*, forKey: dependency

@property (readwrite, retain, nonatomic) NSNumber* disabled;
// don't compile this object is set to YES

@property (readwrite, retain, nonatomic) NSString* headerFileName;
// used by the code generator, don't set this yourself

@property (readwrite, retain, nonatomic) NSString* ifDef;

@property (readwrite, retain, nonatomic) NSMutableArray* initLines;
// Getter will create m_initLines if nil. Alternately, use the initLinesObject property, which will not lazy create it.
// Type: NSString*, forKey: initLine

@property (readwrite, retain, nonatomic) NSNumber* isSingleton;
// if set to YES the standard FishLamp singleton objects will be generated for this object

@property (readwrite, retain, nonatomic) NSNumber* isWildcardArray;

@property (readwrite, retain, nonatomic) NSMutableArray* members;
// Getter will create m_members if nil. Alternately, use the membersObject property, which will not lazy create it.
// Type: GtCodeGeneratorVariable*, forKey: member

@property (readwrite, retain, nonatomic) NSMutableArray* methods;
// Getter will create m_methods if nil. Alternately, use the methodsObject property, which will not lazy create it.
// Type: GtCodeGeneratorMethod*, forKey: method

@property (readwrite, retain, nonatomic) NSString* name;
// name of the type, e.g. bagelCount

@property (readwrite, retain, nonatomic) NSMutableArray* properties;
// Getter will create m_properties if nil. Alternately, use the propertiesObject property, which will not lazy create it.
// Type: GtCodeGeneratorProperty*, forKey: property

@property (readwrite, retain, nonatomic) NSString* protocols;
// comma delimeted string

@property (readwrite, retain, nonatomic) NSString* sourceFileName;
// used by the code generator, don't set this yourself

@property (readwrite, retain, nonatomic) NSMutableArray* sourceSnippets;
// Getter will create m_sourceSnippets if nil. Alternately, use the sourceSnippetsObject property, which will not lazy create it.
// Type: GtCodeGeneratorCodeSnippet*, forKey: code

@property (readwrite, retain, nonatomic) GtCodeGeneratorStorageOptions* storageOptions;
// Getter will create m_storageOptions if nil. Alternately, use the storageOptionsObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* superclass;
// superclass for the object. by default this is set to NSObject

+ (NSString*) canLazyCreateKey;

+ (NSString*) categoriesKey;

+ (NSString*) commentKey;

+ (NSString*) deallocLinesKey;

+ (NSString*) dependenciesKey;

+ (NSString*) disabledKey;

+ (NSString*) headerFileNameKey;

+ (NSString*) ifDefKey;

+ (NSString*) initLinesKey;

+ (NSString*) isSingletonKey;

+ (NSString*) isWildcardArrayKey;

+ (NSString*) membersKey;

+ (NSString*) methodsKey;

+ (NSString*) nameKey;

+ (NSString*) propertiesKey;

+ (NSString*) protocolsKey;

+ (NSString*) sourceFileNameKey;

+ (NSString*) sourceSnippetsKey;

+ (NSString*) storageOptionsKey;

+ (NSString*) superclassKey;

+ (GtCodeGeneratorObject*) codeGeneratorObject; 

@end

@interface GtCodeGeneratorObject (ValueProperties) 

@property (readwrite, assign, nonatomic) BOOL disabledValue;
// don't compile this object is set to YES

@property (readwrite, assign, nonatomic) BOOL canLazyCreateValue;

@property (readwrite, assign, nonatomic) BOOL isWildcardArrayValue;

@property (readwrite, assign, nonatomic) BOOL isSingletonValue;
// if set to YES the standard FishLamp singleton objects will be generated for this object
@end


@interface GtCodeGeneratorObject (ObjectMembers) 

@property (readonly, retain, nonatomic) GtCodeGeneratorStorageOptions* storageOptionsObject;
// This returns m_storageOptions. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) NSMutableArray* propertiesObject;
// This returns m_properties. It does NOT create it if it's NIL.
// Type: GtCodeGeneratorProperty*, forKey: property

@property (readonly, retain, nonatomic) NSMutableArray* dependenciesObject;
// This returns m_dependencies. It does NOT create it if it's NIL.
// Type: GtCodeGeneratorTypeDefinition*, forKey: dependency

@property (readonly, retain, nonatomic) NSMutableArray* membersObject;
// This returns m_members. It does NOT create it if it's NIL.
// Type: GtCodeGeneratorVariable*, forKey: member

@property (readonly, retain, nonatomic) NSMutableArray* methodsObject;
// This returns m_methods. It does NOT create it if it's NIL.
// Type: GtCodeGeneratorMethod*, forKey: method

@property (readonly, retain, nonatomic) NSMutableArray* sourceSnippetsObject;
// This returns m_sourceSnippets. It does NOT create it if it's NIL.
// Type: GtCodeGeneratorCodeSnippet*, forKey: code

@property (readonly, retain, nonatomic) NSMutableArray* initLinesObject;
// This returns m_initLines. It does NOT create it if it's NIL.
// Type: NSString*, forKey: initLine

@property (readonly, retain, nonatomic) NSMutableArray* deallocLinesObject;
// This returns m_deallocLines. It does NOT create it if it's NIL.
// Type: NSString*, forKey: deallocLine

@property (readonly, retain, nonatomic) NSMutableArray* categoriesObject;
// This returns m_categories. It does NOT create it if it's NIL.
// Type: GtCodeGeneratorObjectCategory*, forKey: category

- (void) createStorageOptionsIfNil; 

- (void) createPropertiesIfNil; 

- (void) createDependenciesIfNil; 

- (void) createMembersIfNil; 

- (void) createMethodsIfNil; 

- (void) createSourceSnippetsIfNil; 

- (void) createInitLinesIfNil; 

- (void) createDeallocLinesIfNil; 

- (void) createCategoriesIfNil; 
@end

