//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorProperty.h
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


@class GtCodeGeneratorStorageOptions;
@class GtCodeGeneratorMethod;
@class GtCodeGeneratorEnumType;
@class GtCodeGeneratorArrayType;

// --------------------------------------------------------------------
// GtCodeGeneratorProperty
// --------------------------------------------------------------------
@interface GtCodeGeneratorProperty : NSObject<NSCopying>{ 
@private
	NSString* m_name;
	NSString* m_type;
	GtCodeGeneratorStorageOptions* m_storageOptions;
	NSString* m_memberName;
	NSString* m_defaultValue;
	NSString* m_comment;
	GtCodeGeneratorMethod* m_getter;
	GtCodeGeneratorMethod* m_setter;
	NSMutableArray* m_arrayTypes;
	NSNumber* m_canLazyCreate;
	NSNumber* m_isPrivate;
	NSNumber* m_isReadOnly;
	NSNumber* m_isImmutable;
	NSNumber* m_isStatic;
	NSNumber* m_useForEquality;
	NSNumber* m_isWildcardArray;
	NSString* m_originalType;
	NSString* m_originalName;
	GtCodeGeneratorEnumType* m_enumType;
	NSNumber* m_hasCustomCode;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* arrayTypes;
// Getter will create m_arrayTypes if nil. Alternately, use the arrayTypesObject property, which will not lazy create it.
// Type: GtCodeGeneratorArrayType*, forKey: arrayType

@property (readwrite, retain, nonatomic) NSNumber* canLazyCreate;
// automatically create the data (if it's an object) when the property getter is called and the value is nil

@property (readwrite, retain, nonatomic) NSString* comment;
// comment about this property

@property (readwrite, retain, nonatomic) NSString* defaultValue;

@property (readwrite, retain, nonatomic) GtCodeGeneratorEnumType* enumType;
// Getter will create m_enumType if nil. Alternately, use the enumTypeObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) GtCodeGeneratorMethod* getter;
// Getter will create m_getter if nil. Alternately, use the getterObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSNumber* hasCustomCode;
// Properties by default have member data associated with them, set this to YES to disable this.

@property (readwrite, retain, nonatomic) NSNumber* isImmutable;
// immutable means readonly, and directly return the default value without storing it in a member variable

@property (readwrite, retain, nonatomic) NSNumber* isPrivate;
// don't declare the property in the file header (good for overriding superclass methods)

@property (readwrite, retain, nonatomic) NSNumber* isReadOnly;
// make this property readonly

@property (readwrite, retain, nonatomic) NSNumber* isStatic;
// is this property a class method e.g. + (void) foo

@property (readwrite, retain, nonatomic) NSNumber* isWildcardArray;

@property (readwrite, retain, nonatomic) NSString* memberName;
// set member name. this is the same as the property name by default, but can be anything

@property (readwrite, retain, nonatomic) NSString* name;

@property (readwrite, retain, nonatomic) NSString* originalName;
// internal use only

@property (readwrite, retain, nonatomic) NSString* originalType;
// internal use only

@property (readwrite, retain, nonatomic) GtCodeGeneratorMethod* setter;
// Getter will create m_setter if nil. Alternately, use the setterObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) GtCodeGeneratorStorageOptions* storageOptions;
// Getter will create m_storageOptions if nil. Alternately, use the storageOptionsObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* type;

@property (readwrite, retain, nonatomic) NSNumber* useForEquality;

+ (NSString*) arrayTypesKey;

+ (NSString*) canLazyCreateKey;

+ (NSString*) commentKey;

+ (NSString*) defaultValueKey;

+ (NSString*) enumTypeKey;

+ (NSString*) getterKey;

+ (NSString*) hasCustomCodeKey;

+ (NSString*) isImmutableKey;

+ (NSString*) isPrivateKey;

+ (NSString*) isReadOnlyKey;

+ (NSString*) isStaticKey;

+ (NSString*) isWildcardArrayKey;

+ (NSString*) memberNameKey;

+ (NSString*) nameKey;

+ (NSString*) originalNameKey;

+ (NSString*) originalTypeKey;

+ (NSString*) setterKey;

+ (NSString*) storageOptionsKey;

+ (NSString*) typeKey;

+ (NSString*) useForEqualityKey;

+ (GtCodeGeneratorProperty*) codeGeneratorProperty; 

@end

@interface GtCodeGeneratorProperty (ValueProperties) 

@property (readwrite, assign, nonatomic) BOOL canLazyCreateValue;
// automatically create the data (if it's an object) when the property getter is called and the value is nil

@property (readwrite, assign, nonatomic) BOOL isPrivateValue;
// don't declare the property in the file header (good for overriding superclass methods)

@property (readwrite, assign, nonatomic) BOOL isReadOnlyValue;
// make this property readonly

@property (readwrite, assign, nonatomic) BOOL isImmutableValue;
// immutable means readonly, and directly return the default value without storing it in a member variable

@property (readwrite, assign, nonatomic) BOOL isStaticValue;
// is this property a class method e.g. + (void) foo

@property (readwrite, assign, nonatomic) BOOL useForEqualityValue;

@property (readwrite, assign, nonatomic) BOOL isWildcardArrayValue;

@property (readwrite, assign, nonatomic) BOOL hasCustomCodeValue;
// Properties by default have member data associated with them, set this to YES to disable this.
@end


@interface GtCodeGeneratorProperty (ObjectMembers) 

@property (readonly, retain, nonatomic) GtCodeGeneratorStorageOptions* storageOptionsObject;
// This returns m_storageOptions. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) GtCodeGeneratorMethod* getterObject;
// This returns m_getter. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) GtCodeGeneratorMethod* setterObject;
// This returns m_setter. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) NSMutableArray* arrayTypesObject;
// This returns m_arrayTypes. It does NOT create it if it's NIL.
// Type: GtCodeGeneratorArrayType*, forKey: arrayType

@property (readonly, retain, nonatomic) GtCodeGeneratorEnumType* enumTypeObject;
// This returns m_enumType. It does NOT create it if it's NIL.

- (void) createStorageOptionsIfNil; 

- (void) createGetterIfNil; 

- (void) createSetterIfNil; 

- (void) createArrayTypesIfNil; 

- (void) createEnumTypeIfNil; 
@end

