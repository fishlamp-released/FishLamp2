//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorArray.h
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


@class GtCodeGeneratorArrayType;

// --------------------------------------------------------------------
// GtCodeGeneratorArray
// --------------------------------------------------------------------
@interface GtCodeGeneratorArray : NSObject<NSCopying>{ 
@private
	NSString* m_name;
	NSMutableArray* m_types;
} 


@property (readwrite, retain, nonatomic) NSString* name;

@property (readwrite, retain, nonatomic) NSMutableArray* types;
// Getter will create m_types if nil. Alternately, use the typesObject property, which will not lazy create it.
// Type: GtCodeGeneratorArrayType*, forKey: arrayType

+ (NSString*) nameKey;

+ (NSString*) typesKey;

+ (GtCodeGeneratorArray*) codeGeneratorArray; 

@end

@interface GtCodeGeneratorArray (ValueProperties) 
@end


@interface GtCodeGeneratorArray (ObjectMembers) 

@property (readonly, retain, nonatomic) NSMutableArray* typesObject;
// This returns m_types. It does NOT create it if it's NIL.
// Type: GtCodeGeneratorArrayType*, forKey: arrayType

- (void) createTypesIfNil; 
@end

