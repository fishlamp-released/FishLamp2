//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlBinding.h
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


@class GtWsdlBinding;
@class GtWsdlOperation;

// --------------------------------------------------------------------
// GtWsdlBinding
// --------------------------------------------------------------------
@interface GtWsdlBinding : NSObject{ 
@private
	NSString* m_name;
	NSString* m_transport;
	NSString* m_verb;
	NSString* m_type;
	NSMutableArray* m_bindings;
	NSMutableArray* m_operations;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* bindings;
// Getter will create m_bindings if nil. Alternately, use the bindingsObject property, which will not lazy create it.
// Type: GtWsdlBinding*, forKey: binding

@property (readwrite, retain, nonatomic) NSString* name;

@property (readwrite, retain, nonatomic) NSMutableArray* operations;
// Getter will create m_operations if nil. Alternately, use the operationsObject property, which will not lazy create it.
// Type: GtWsdlOperation*, forKey: operation

@property (readwrite, retain, nonatomic) NSString* transport;

@property (readwrite, retain, nonatomic) NSString* type;

@property (readwrite, retain, nonatomic) NSString* verb;

+ (NSString*) bindingsKey;

+ (NSString*) nameKey;

+ (NSString*) operationsKey;

+ (NSString*) transportKey;

+ (NSString*) typeKey;

+ (NSString*) verbKey;

+ (GtWsdlBinding*) wsdlBinding; 

@end

@interface GtWsdlBinding (ValueProperties) 
@end


@interface GtWsdlBinding (ObjectMembers) 

@property (readonly, retain, nonatomic) NSMutableArray* bindingsObject;
// This returns m_bindings. It does NOT create it if it's NIL.
// Type: GtWsdlBinding*, forKey: binding

@property (readonly, retain, nonatomic) NSMutableArray* operationsObject;
// This returns m_operations. It does NOT create it if it's NIL.
// Type: GtWsdlOperation*, forKey: operation

- (void) createBindingsIfNil; 

- (void) createOperationsIfNil; 
@end

