//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlOperation.h
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


@class GtWsdlInputOutput;
@class GtWsdlOperation;

// --------------------------------------------------------------------
// GtWsdlOperation
// --------------------------------------------------------------------
@interface GtWsdlOperation : NSObject{ 
@private
	NSString* m_name;
	NSString* m_location;
	NSString* m_soapAction;
	NSString* m_style;
	NSString* m_documentation;
	GtWsdlInputOutput* m_input;
	GtWsdlInputOutput* m_output;
	GtWsdlOperation* m_operation;
} 


@property (readwrite, retain, nonatomic) NSString* documentation;

@property (readwrite, retain, nonatomic) GtWsdlInputOutput* input;
// Getter will create m_input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* location;

@property (readwrite, retain, nonatomic) NSString* name;

@property (readwrite, retain, nonatomic) GtWsdlOperation* operation;
// Getter will create m_operation if nil. Alternately, use the operationObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) GtWsdlInputOutput* output;
// Getter will create m_output if nil. Alternately, use the outputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* soapAction;

@property (readwrite, retain, nonatomic) NSString* style;

+ (NSString*) documentationKey;

+ (NSString*) inputKey;

+ (NSString*) locationKey;

+ (NSString*) nameKey;

+ (NSString*) operationKey;

+ (NSString*) outputKey;

+ (NSString*) soapActionKey;

+ (NSString*) styleKey;

+ (GtWsdlOperation*) wsdlOperation; 

@end

@interface GtWsdlOperation (ValueProperties) 
@end


@interface GtWsdlOperation (ObjectMembers) 

@property (readonly, retain, nonatomic) GtWsdlInputOutput* inputObject;
// This returns m_input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) GtWsdlInputOutput* outputObject;
// This returns m_output. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) GtWsdlOperation* operationObject;
// This returns m_operation. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 

- (void) createOperationIfNil; 
@end

