//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlPart.h
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// GtWsdlPart
// --------------------------------------------------------------------
@interface GtWsdlPart : NSObject{ 
@private
	NSString* m_name;
	NSString* m_element;
	NSString* m_type;
} 


@property (readwrite, retain, nonatomic) NSString* element;

@property (readwrite, retain, nonatomic) NSString* name;

@property (readwrite, retain, nonatomic) NSString* type;

+ (NSString*) elementKey;

+ (NSString*) nameKey;

+ (NSString*) typeKey;

+ (GtWsdlPart*) wsdlPart; 

@end

@interface GtWsdlPart (ValueProperties) 
@end


@interface GtWsdlPart (ObjectMembers) 
@end

