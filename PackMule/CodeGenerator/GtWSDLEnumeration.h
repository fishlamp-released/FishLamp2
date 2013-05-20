//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlEnumeration.h
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// GtWsdlEnumeration
// --------------------------------------------------------------------
@interface GtWsdlEnumeration : NSObject{ 
@private
	NSString* m_value;
} 


@property (readwrite, retain, nonatomic) NSString* value;

+ (NSString*) valueKey;

+ (GtWsdlEnumeration*) wsdlEnumeration; 

@end

@interface GtWsdlEnumeration (ValueProperties) 
@end


@interface GtWsdlEnumeration (ObjectMembers) 
@end

