//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorTypeDefinition.h
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// GtCodeGeneratorTypeDefinition
// --------------------------------------------------------------------
@interface GtCodeGeneratorTypeDefinition : NSObject<NSCopying>{ 
@private
	NSString* m_dataType;
	NSString* m_typeName;
	NSString* m_import;
	NSNumber* m_importIsPrivate;
} 


@property (readwrite, retain, nonatomic) NSString* dataType;
// the dataType of the type, e.g. object, struct, int, array

@property (readwrite, retain, nonatomic) NSString* import;

@property (readwrite, retain, nonatomic) NSNumber* importIsPrivate;

@property (readwrite, retain, nonatomic) NSString* typeName;
// name of the type, e.g. MyObject

+ (NSString*) dataTypeKey;

+ (NSString*) importIsPrivateKey;

+ (NSString*) importKey;

+ (NSString*) typeNameKey;

+ (GtCodeGeneratorTypeDefinition*) codeGeneratorTypeDefinition; 

@end

@interface GtCodeGeneratorTypeDefinition (ValueProperties) 

@property (readwrite, assign, nonatomic) BOOL importIsPrivateValue;
@end


@interface GtCodeGeneratorTypeDefinition (ObjectMembers) 
@end

