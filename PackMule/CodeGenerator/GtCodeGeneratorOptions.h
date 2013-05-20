//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorOptions.h
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


@class GtCodeGeneratorDefine;

// --------------------------------------------------------------------
// GtCodeGeneratorOptions
// --------------------------------------------------------------------
@interface GtCodeGeneratorOptions : NSObject<NSCopying>{ 
@private
	NSNumber* m_disabled;
	NSString* m_typePrefix;
	NSString* m_comment;
	GtCodeGeneratorDefine* m_globalDefine;
	NSNumber* m_generateAllIncludesFile;
	NSString* m_objectsFolderName;
	NSString* m_codeFileFolderName;
} 


@property (readwrite, retain, nonatomic) NSString* codeFileFolderName;

@property (readwrite, retain, nonatomic) NSString* comment;

@property (readwrite, retain, nonatomic) NSNumber* disabled;
// don't compile this object is set to YES

@property (readwrite, retain, nonatomic) NSNumber* generateAllIncludesFile;
// set this to YES to create an includes file that includes all the generated headers

@property (readwrite, retain, nonatomic) GtCodeGeneratorDefine* globalDefine;
// Getter will create m_globalDefine if nil. Alternately, use the globalDefineObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* objectsFolderName;
// folder to generated the files to. By default this is the same as the xml schema file

@property (readwrite, retain, nonatomic) NSString* typePrefix;

+ (NSString*) codeFileFolderNameKey;

+ (NSString*) commentKey;

+ (NSString*) disabledKey;

+ (NSString*) generateAllIncludesFileKey;

+ (NSString*) globalDefineKey;

+ (NSString*) objectsFolderNameKey;

+ (NSString*) typePrefixKey;

+ (GtCodeGeneratorOptions*) codeGeneratorOptions; 

@end

@interface GtCodeGeneratorOptions (ValueProperties) 

@property (readwrite, assign, nonatomic) BOOL disabledValue;
// don't compile this object is set to YES

@property (readwrite, assign, nonatomic) BOOL generateAllIncludesFileValue;
// set this to YES to create an includes file that includes all the generated headers
@end


@interface GtCodeGeneratorOptions (ObjectMembers) 

@property (readonly, retain, nonatomic) GtCodeGeneratorDefine* globalDefineObject;
// This returns m_globalDefine. It does NOT create it if it's NIL.

- (void) createGlobalDefineIfNil; 
@end

