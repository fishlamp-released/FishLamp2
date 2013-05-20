//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorCodeSnippet.h
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
represents a block of code
*/



// --------------------------------------------------------------------
// GtCodeGeneratorCodeSnippet
// --------------------------------------------------------------------
@interface GtCodeGeneratorCodeSnippet : NSObject<NSCopying>{ 
@private
	NSString* m_scopedBy;
	NSString* m_name;
	NSString* m_comment;
	NSString* m_lines;
} 


@property (readwrite, retain, nonatomic) NSString* comment;
// a comment about this snippet

@property (readwrite, retain, nonatomic) NSString* lines;

@property (readwrite, retain, nonatomic) NSString* name;
// name of snippet (used for file)

@property (readwrite, retain, nonatomic) NSString* scopedBy;

+ (NSString*) commentKey;

+ (NSString*) linesKey;

+ (NSString*) nameKey;

+ (NSString*) scopedByKey;

+ (GtCodeGeneratorCodeSnippet*) codeGeneratorCodeSnippet; 

@end

@interface GtCodeGeneratorCodeSnippet (ValueProperties) 
@end


@interface GtCodeGeneratorCodeSnippet (ObjectMembers) 
@end

