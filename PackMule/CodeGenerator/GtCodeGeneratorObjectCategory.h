//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorObjectCategory.h
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


@class GtCodeGeneratorMethod;
@class GtCodeGeneratorProperty;

// --------------------------------------------------------------------
// GtCodeGeneratorObjectCategory
// --------------------------------------------------------------------
@interface GtCodeGeneratorObjectCategory : NSObject<NSCopying>{ 
@private
	NSString* m_objectName;
	NSString* m_categoryName;
	NSMutableArray* m_properties;
	NSMutableArray* m_methods;
} 


@property (readwrite, retain, nonatomic) NSString* categoryName;
// name of the type, e.g. bagelCount

@property (readwrite, retain, nonatomic) NSMutableArray* methods;
// Getter will create m_methods if nil. Alternately, use the methodsObject property, which will not lazy create it.
// Type: GtCodeGeneratorMethod*, forKey: method

@property (readwrite, retain, nonatomic) NSString* objectName;
// name of the type, e.g. bagelCount

@property (readwrite, retain, nonatomic) NSMutableArray* properties;
// Getter will create m_properties if nil. Alternately, use the propertiesObject property, which will not lazy create it.
// Type: GtCodeGeneratorProperty*, forKey: property

+ (NSString*) categoryNameKey;

+ (NSString*) methodsKey;

+ (NSString*) objectNameKey;

+ (NSString*) propertiesKey;

+ (GtCodeGeneratorObjectCategory*) codeGeneratorObjectCategory; 

@end

@interface GtCodeGeneratorObjectCategory (ValueProperties) 
@end


@interface GtCodeGeneratorObjectCategory (ObjectMembers) 

@property (readonly, retain, nonatomic) NSMutableArray* propertiesObject;
// This returns m_properties. It does NOT create it if it's NIL.
// Type: GtCodeGeneratorProperty*, forKey: property

@property (readonly, retain, nonatomic) NSMutableArray* methodsObject;
// This returns m_methods. It does NOT create it if it's NIL.
// Type: GtCodeGeneratorMethod*, forKey: method

- (void) createPropertiesIfNil; 

- (void) createMethodsIfNil; 
@end

