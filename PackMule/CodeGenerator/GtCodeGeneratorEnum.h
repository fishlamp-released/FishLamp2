//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorEnum.h
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// GtCodeGeneratorEnum
// --------------------------------------------------------------------
@interface GtCodeGeneratorEnum : NSObject<NSCopying>{ 
@private
	NSString* m_name;
	NSNumber* m_value;
	NSString* m_stringValue;
} 


@property (readwrite, retain, nonatomic) NSString* name;
// This is the name of the enum, e.g. kFoo

@property (readwrite, retain, nonatomic) NSString* stringValue;
// This is the string optional value of the define

@property (readwrite, retain, nonatomic) NSNumber* value;
// This is the optional value of the enum, e.g. 5

+ (NSString*) nameKey;

+ (NSString*) stringValueKey;

+ (NSString*) valueKey;

+ (GtCodeGeneratorEnum*) codeGeneratorEnum; 

@end

@interface GtCodeGeneratorEnum (ValueProperties) 

@property (readwrite, assign, nonatomic) int valueValue;
// This is the optional value of the enum, e.g. 5
@end


@interface GtCodeGeneratorEnum (ObjectMembers) 
@end

