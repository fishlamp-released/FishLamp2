//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorComment.h
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
don't use this object directly, used internally
*/



// --------------------------------------------------------------------
// GtCodeGeneratorComment
// --------------------------------------------------------------------
@interface GtCodeGeneratorComment : NSObject<NSCopying>{ 
@private
	NSString* m_object;
	NSString* m_commentID;
	NSString* m_comment;
} 


@property (readwrite, retain, nonatomic) NSString* comment;

@property (readwrite, retain, nonatomic) NSString* commentID;

@property (readwrite, retain, nonatomic) NSString* object;

+ (NSString*) commentIDKey;

+ (NSString*) commentKey;

+ (NSString*) objectKey;

+ (GtCodeGeneratorComment*) codeGeneratorComment; 

@end

@interface GtCodeGeneratorComment (ValueProperties) 
@end


@interface GtCodeGeneratorComment (ObjectMembers) 
@end

