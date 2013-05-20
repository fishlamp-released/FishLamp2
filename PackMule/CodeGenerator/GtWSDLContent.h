//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlContent.h
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// GtWsdlContent
// --------------------------------------------------------------------
@interface GtWsdlContent : NSObject{ 
@private
	NSString* m_type;
} 


@property (readwrite, retain, nonatomic) NSString* type;

+ (NSString*) typeKey;

+ (GtWsdlContent*) wsdlContent; 

@end

@interface GtWsdlContent (ValueProperties) 
@end


@interface GtWsdlContent (ObjectMembers) 
@end

