//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorMethod.h
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


@class GtCodeGeneratorCodeSnippet;
@class GtCodeGeneratorVariable;

// --------------------------------------------------------------------
// GtCodeGeneratorMethod
// --------------------------------------------------------------------
@interface GtCodeGeneratorMethod : NSObject<NSCopying>{ 
@private
	NSNumber* m_isStatic;
	NSNumber* m_isPrivate;
	NSString* m_returnType;
	NSString* m_name;
	NSString* m_comment;
	GtCodeGeneratorCodeSnippet* m_code;
	NSMutableArray* m_parameters;
} 


@property (readwrite, retain, nonatomic) GtCodeGeneratorCodeSnippet* code;
// Getter will create m_code if nil. Alternately, use the codeObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* comment;
// comment about this method

@property (readwrite, retain, nonatomic) NSNumber* isPrivate;
// don't show the declaration in the header for this method

@property (readwrite, retain, nonatomic) NSNumber* isStatic;
// is this a class method, e.g. + (void) foo

@property (readwrite, retain, nonatomic) NSString* name;
// name of the method

@property (readwrite, retain, nonatomic) NSMutableArray* parameters;
// Getter will create m_parameters if nil. Alternately, use the parametersObject property, which will not lazy create it.
// Type: GtCodeGeneratorVariable*, forKey: parameter

@property (readwrite, retain, nonatomic) NSString* returnType;
// return type of the method, by default this is void

+ (NSString*) codeKey;

+ (NSString*) commentKey;

+ (NSString*) isPrivateKey;

+ (NSString*) isStaticKey;

+ (NSString*) nameKey;

+ (NSString*) parametersKey;

+ (NSString*) returnTypeKey;

+ (GtCodeGeneratorMethod*) codeGeneratorMethod; 

@end

@interface GtCodeGeneratorMethod (ValueProperties) 

@property (readwrite, assign, nonatomic) BOOL isStaticValue;
// is this a class method, e.g. + (void) foo

@property (readwrite, assign, nonatomic) BOOL isPrivateValue;
// don't show the declaration in the header for this method
@end


@interface GtCodeGeneratorMethod (ObjectMembers) 

@property (readonly, retain, nonatomic) GtCodeGeneratorCodeSnippet* codeObject;
// This returns m_code. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) NSMutableArray* parametersObject;
// This returns m_parameters. It does NOT create it if it's NIL.
// Type: GtCodeGeneratorVariable*, forKey: parameter

- (void) createCodeIfNil; 

- (void) createParametersIfNil; 
@end

