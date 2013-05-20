//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorStorageOptions.h
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// GtCodeGeneratorStorageOptions
// --------------------------------------------------------------------
@interface GtCodeGeneratorStorageOptions : NSObject<NSCopying>{ 
@private
	NSNumber* m_isStorable;
	NSNumber* m_isPrimaryKey;
	NSNumber* m_isIndexed;
	NSNumber* m_isUnique;
	NSNumber* m_isRequired;
} 


@property (readwrite, retain, nonatomic) NSNumber* isIndexed;
// set this property to be indexed for fast searches on it

@property (readwrite, retain, nonatomic) NSNumber* isPrimaryKey;
// set this property to be a primary key in the data store

@property (readwrite, retain, nonatomic) NSNumber* isRequired;
// make sure this value isn't empty in the data store

@property (readwrite, retain, nonatomic) NSNumber* isStorable;
// this defaults to NO. Note that storage options are ignored if the parent object is not storable.

@property (readwrite, retain, nonatomic) NSNumber* isUnique;
// make sure this value is unique is the data store for this type

+ (NSString*) isIndexedKey;

+ (NSString*) isPrimaryKeyKey;

+ (NSString*) isRequiredKey;

+ (NSString*) isStorableKey;

+ (NSString*) isUniqueKey;

+ (GtCodeGeneratorStorageOptions*) codeGeneratorStorageOptions; 

@end

@interface GtCodeGeneratorStorageOptions (ValueProperties) 

@property (readwrite, assign, nonatomic) BOOL isStorableValue;
// this defaults to NO. Note that storage options are ignored if the parent object is not storable.

@property (readwrite, assign, nonatomic) BOOL isPrimaryKeyValue;
// set this property to be a primary key in the data store

@property (readwrite, assign, nonatomic) BOOL isIndexedValue;
// set this property to be indexed for fast searches on it

@property (readwrite, assign, nonatomic) BOOL isUniqueValue;
// make sure this value is unique is the data store for this type

@property (readwrite, assign, nonatomic) BOOL isRequiredValue;
// make sure this value isn't empty in the data store
@end


@interface GtCodeGeneratorStorageOptions (ObjectMembers) 
@end

