//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorFile.h
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// GtCodeGeneratorFile
// --------------------------------------------------------------------
@interface GtCodeGeneratorFile : NSObject<NSCopying>{ 
@private
	NSString* m_name;
	NSString* m_contents;
} 


@property (readwrite, retain, nonatomic) NSString* contents;

@property (readwrite, retain, nonatomic) NSString* name;

+ (NSString*) contentsKey;

+ (NSString*) nameKey;

+ (GtCodeGeneratorFile*) codeGeneratorFile; 

@end

@interface GtCodeGeneratorFile (ValueProperties) 
@end


@interface GtCodeGeneratorFile (ObjectMembers) 
@end

