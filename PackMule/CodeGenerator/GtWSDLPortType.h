//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlPortType.h
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


@class GtWsdlServiceAddress;
@class GtWsdlOperation;

// --------------------------------------------------------------------
// GtWsdlPortType
// --------------------------------------------------------------------
@interface GtWsdlPortType : NSObject{ 
@private
	NSString* m_name;
	NSString* m_binding;
	GtWsdlServiceAddress* m_address;
	NSMutableArray* m_operations;
} 


@property (readwrite, retain, nonatomic) GtWsdlServiceAddress* address;
// Getter will create m_address if nil. Alternately, use the addressObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* binding;

@property (readwrite, retain, nonatomic) NSString* name;

@property (readwrite, retain, nonatomic) NSMutableArray* operations;
// Getter will create m_operations if nil. Alternately, use the operationsObject property, which will not lazy create it.
// Type: GtWsdlOperation*, forKey: operation

+ (NSString*) addressKey;

+ (NSString*) bindingKey;

+ (NSString*) nameKey;

+ (NSString*) operationsKey;

+ (GtWsdlPortType*) wsdlPortType; 

@end

@interface GtWsdlPortType (ValueProperties) 
@end


@interface GtWsdlPortType (ObjectMembers) 

@property (readonly, retain, nonatomic) GtWsdlServiceAddress* addressObject;
// This returns m_address. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) NSMutableArray* operationsObject;
// This returns m_operations. It does NOT create it if it's NIL.
// Type: GtWsdlOperation*, forKey: operation

- (void) createAddressIfNil; 

- (void) createOperationsIfNil; 
@end

