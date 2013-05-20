//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorType.h
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
represents a type an name
*/



// --------------------------------------------------------------------
// GtCodeGeneratorType
// --------------------------------------------------------------------
@interface GtCodeGeneratorType : NSObject<NSCopying>{ 
@private
	NSString* m_typeName;
	NSString* m_defaultValue;
	NSString* m_originalType;
} 


@property (readwrite, retain, nonatomic) NSString* defaultValue;

@property (readwrite, retain, nonatomic) NSString* originalType;

@property (readwrite, retain, nonatomic) NSString* typeName;
// name of the type, e.g. MyObject

+ (NSString*) defaultValueKey;

+ (NSString*) originalTypeKey;

+ (NSString*) typeNameKey;

+ (GtCodeGeneratorType*) codeGeneratorType; 

@end

@interface GtCodeGeneratorType (ValueProperties) 
@end


@interface GtCodeGeneratorType (ObjectMembers) 
@end

