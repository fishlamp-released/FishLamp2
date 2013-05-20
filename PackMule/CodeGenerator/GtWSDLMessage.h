//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlMessage.h
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


@class GtWsdlPart;

// --------------------------------------------------------------------
// GtWsdlMessage
// --------------------------------------------------------------------
@interface GtWsdlMessage : NSObject{ 
@private
	NSString* m_name;
	NSMutableArray* m_parts;
} 


@property (readwrite, retain, nonatomic) NSString* name;

@property (readwrite, retain, nonatomic) NSMutableArray* parts;
// Getter will create m_parts if nil. Alternately, use the partsObject property, which will not lazy create it.
// Type: GtWsdlPart*, forKey: part

+ (NSString*) nameKey;

+ (NSString*) partsKey;

+ (GtWsdlMessage*) wsdlMessage; 

@end

@interface GtWsdlMessage (ValueProperties) 
@end


@interface GtWsdlMessage (ObjectMembers) 

@property (readonly, retain, nonatomic) NSMutableArray* partsObject;
// This returns m_parts. It does NOT create it if it's NIL.
// Type: GtWsdlPart*, forKey: part

- (void) createPartsIfNil; 
@end

