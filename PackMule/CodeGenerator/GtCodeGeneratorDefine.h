//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorDefine.h
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// GtCodeGeneratorDefine
// --------------------------------------------------------------------
@interface GtCodeGeneratorDefine : NSObject<NSCopying>{ 
@private
	NSString* m_define;
	NSString* m_value;
	NSNumber* m_isString;
	NSString* m_comment;
} 


@property (readwrite, retain, nonatomic) NSString* comment;

@property (readwrite, retain, nonatomic) NSString* define;

@property (readwrite, retain, nonatomic) NSNumber* isString;

@property (readwrite, retain, nonatomic) NSString* value;

+ (NSString*) commentKey;

+ (NSString*) defineKey;

+ (NSString*) isStringKey;

+ (NSString*) valueKey;

+ (GtCodeGeneratorDefine*) codeGeneratorDefine; 

@end

@interface GtCodeGeneratorDefine (ValueProperties) 

@property (readwrite, assign, nonatomic) BOOL isStringValue;
@end


@interface GtCodeGeneratorDefine (ObjectMembers) 
@end

