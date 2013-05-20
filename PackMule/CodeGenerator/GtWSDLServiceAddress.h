//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlServiceAddress.h
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// GtWsdlServiceAddress
// --------------------------------------------------------------------
@interface GtWsdlServiceAddress : NSObject{ 
@private
	NSString* m_location;
} 


@property (readwrite, retain, nonatomic) NSString* location;

+ (NSString*) locationKey;

+ (GtWsdlServiceAddress*) wsdlServiceAddress; 

@end

@interface GtWsdlServiceAddress (ValueProperties) 
@end


@interface GtWsdlServiceAddress (ObjectMembers) 
@end

