//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorObjectMemberType.h
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


#import "GtCodeGeneratorVariable.h"

// --------------------------------------------------------------------
// GtCodeGeneratorObjectMemberType
// --------------------------------------------------------------------
@interface GtCodeGeneratorObjectMemberType : GtCodeGeneratorVariable<NSCopying>{ 
@private
	NSNumber* m_isStatic;
} 


@property (readwrite, retain, nonatomic) NSNumber* isStatic;

+ (NSString*) isStaticKey;

+ (GtCodeGeneratorObjectMemberType*) codeGeneratorObjectMemberType; 

@end

@interface GtCodeGeneratorObjectMemberType (ValueProperties) 

@property (readwrite, assign, nonatomic) BOOL isStaticValue;
@end


@interface GtCodeGeneratorObjectMemberType (ObjectMembers) 
@end

