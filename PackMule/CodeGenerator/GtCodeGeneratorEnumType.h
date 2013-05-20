//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorEnumType.h
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


#import "GtCodeGeneratorType.h"
@class GtCodeGeneratorEnum;

// --------------------------------------------------------------------
// GtCodeGeneratorEnumType
// --------------------------------------------------------------------
@interface GtCodeGeneratorEnumType : GtCodeGeneratorType<NSCopying>{ 
@private
	NSMutableArray* m_enums;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* enums;
// Getter will create m_enums if nil. Alternately, use the enumsObject property, which will not lazy create it.
// Type: GtCodeGeneratorEnum*, forKey: enum

+ (NSString*) enumsKey;

+ (GtCodeGeneratorEnumType*) codeGeneratorEnumType; 

@end

@interface GtCodeGeneratorEnumType (ValueProperties) 
@end


@interface GtCodeGeneratorEnumType (ObjectMembers) 

@property (readonly, retain, nonatomic) NSMutableArray* enumsObject;
// This returns m_enums. It does NOT create it if it's NIL.
// Type: GtCodeGeneratorEnum*, forKey: enum

- (void) createEnumsIfNil; 
@end

