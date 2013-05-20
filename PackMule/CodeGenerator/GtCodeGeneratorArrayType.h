//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorArrayType.h
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


#import "GtCodeGeneratorVariable.h"
@class GtCodeGeneratorProperty;

// --------------------------------------------------------------------
// GtCodeGeneratorArrayType
// --------------------------------------------------------------------
@interface GtCodeGeneratorArrayType : GtCodeGeneratorVariable<NSCopying>{ 
@private
	GtCodeGeneratorProperty* m_wildcardProperty;
} 


@property (readwrite, retain, nonatomic) GtCodeGeneratorProperty* wildcardProperty;
// Getter will create m_wildcardProperty if nil. Alternately, use the wildcardPropertyObject property, which will not lazy create it.

+ (NSString*) wildcardPropertyKey;

+ (GtCodeGeneratorArrayType*) codeGeneratorArrayType; 

@end

@interface GtCodeGeneratorArrayType (ValueProperties) 
@end


@interface GtCodeGeneratorArrayType (ObjectMembers) 

@property (readonly, retain, nonatomic) GtCodeGeneratorProperty* wildcardPropertyObject;
// This returns m_wildcardProperty. It does NOT create it if it's NIL.

- (void) createWildcardPropertyIfNil; 
@end

