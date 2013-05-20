//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlDefinitions.h
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


@class GtWsdlService;
@class GtWsdlBinding;
@class GtWsdlMessage;
@class GtWsdlPortType;
@class GtWsdlSchema;

// --------------------------------------------------------------------
// GtWsdlDefinitions
// --------------------------------------------------------------------
@interface GtWsdlDefinitions : NSObject{ 
@private
	NSMutableArray* m_types;
	NSMutableArray* m_messages;
	NSMutableArray* m_portTypes;
	NSMutableArray* m_bindings;
	GtWsdlService* m_service;
	NSString* m_targetNamespace;
	NSString* m_documentation;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* bindings;
// Getter will create m_bindings if nil. Alternately, use the bindingsObject property, which will not lazy create it.
// Type: GtWsdlBinding*, forKey: binding

@property (readwrite, retain, nonatomic) NSString* documentation;

@property (readwrite, retain, nonatomic) NSMutableArray* messages;
// Getter will create m_messages if nil. Alternately, use the messagesObject property, which will not lazy create it.
// Type: GtWsdlMessage*, forKey: message

@property (readwrite, retain, nonatomic) NSMutableArray* portTypes;
// Getter will create m_portTypes if nil. Alternately, use the portTypesObject property, which will not lazy create it.
// Type: GtWsdlPortType*, forKey: portType

@property (readwrite, retain, nonatomic) GtWsdlService* service;
// Getter will create m_service if nil. Alternately, use the serviceObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* targetNamespace;

@property (readwrite, retain, nonatomic) NSMutableArray* types;
// Getter will create m_types if nil. Alternately, use the typesObject property, which will not lazy create it.
// Type: GtWsdlSchema*, forKey: schema

+ (NSString*) bindingsKey;

+ (NSString*) documentationKey;

+ (NSString*) messagesKey;

+ (NSString*) portTypesKey;

+ (NSString*) serviceKey;

+ (NSString*) targetNamespaceKey;

+ (NSString*) typesKey;

+ (GtWsdlDefinitions*) wsdlDefinitions; 

@end

@interface GtWsdlDefinitions (ValueProperties) 
@end


@interface GtWsdlDefinitions (ObjectMembers) 

@property (readonly, retain, nonatomic) NSMutableArray* typesObject;
// This returns m_types. It does NOT create it if it's NIL.
// Type: GtWsdlSchema*, forKey: schema

@property (readonly, retain, nonatomic) NSMutableArray* messagesObject;
// This returns m_messages. It does NOT create it if it's NIL.
// Type: GtWsdlMessage*, forKey: message

@property (readonly, retain, nonatomic) NSMutableArray* portTypesObject;
// This returns m_portTypes. It does NOT create it if it's NIL.
// Type: GtWsdlPortType*, forKey: portType

@property (readonly, retain, nonatomic) NSMutableArray* bindingsObject;
// This returns m_bindings. It does NOT create it if it's NIL.
// Type: GtWsdlBinding*, forKey: binding

@property (readonly, retain, nonatomic) GtWsdlService* serviceObject;
// This returns m_service. It does NOT create it if it's NIL.

- (void) createTypesIfNil; 

- (void) createMessagesIfNil; 

- (void) createPortTypesIfNil; 

- (void) createBindingsIfNil; 

- (void) createServiceIfNil; 
@end

