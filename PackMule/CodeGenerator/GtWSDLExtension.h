//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlExtension.h
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


#import "GtWsdlSequenceArray.h"

// --------------------------------------------------------------------
// GtWsdlExtension
// --------------------------------------------------------------------
@interface GtWsdlExtension : GtWsdlSequenceArray{ 
@private
	NSString* m_base;
} 


@property (readwrite, retain, nonatomic) NSString* base;

+ (NSString*) baseKey;

+ (GtWsdlExtension*) wsdlExtension; 

@end

@interface GtWsdlExtension (ValueProperties) 
@end


@interface GtWsdlExtension (ObjectMembers) 
@end

