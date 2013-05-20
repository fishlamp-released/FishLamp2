//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorKeyValuePair.h
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// GtCodeGeneratorKeyValuePair
// --------------------------------------------------------------------
@interface GtCodeGeneratorKeyValuePair : NSObject<NSCopying>{ 
@private
	NSString* m_key;
	NSString* m_value;
} 


@property (readwrite, retain, nonatomic) NSString* key;

@property (readwrite, retain, nonatomic) NSString* value;

+ (NSString*) keyKey;

+ (NSString*) valueKey;

+ (GtCodeGeneratorKeyValuePair*) codeGeneratorKeyValuePair; 

@end

@interface GtCodeGeneratorKeyValuePair (ValueProperties) 
@end


@interface GtCodeGeneratorKeyValuePair (ObjectMembers) 
@end

