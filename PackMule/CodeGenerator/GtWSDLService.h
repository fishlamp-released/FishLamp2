//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlService.h
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


@class GtWsdlPortType;

// --------------------------------------------------------------------
// GtWsdlService
// --------------------------------------------------------------------
@interface GtWsdlService : NSObject{ 
@private
	NSString* m_name;
	NSString* m_documentation;
	NSMutableArray* m_ports;
} 


@property (readwrite, retain, nonatomic) NSString* documentation;

@property (readwrite, retain, nonatomic) NSString* name;

@property (readwrite, retain, nonatomic) NSMutableArray* ports;
// Getter will create m_ports if nil. Alternately, use the portsObject property, which will not lazy create it.
// Type: GtWsdlPortType*, forKey: port

+ (NSString*) documentationKey;

+ (NSString*) nameKey;

+ (NSString*) portsKey;

+ (GtWsdlService*) wsdlService; 

@end

@interface GtWsdlService (ValueProperties) 
@end


@interface GtWsdlService (ObjectMembers) 

@property (readonly, retain, nonatomic) NSMutableArray* portsObject;
// This returns m_ports. It does NOT create it if it's NIL.
// Type: GtWsdlPortType*, forKey: port

- (void) createPortsIfNil; 
@end

