//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlImport.h
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// GtWsdlImport
// --------------------------------------------------------------------
@interface GtWsdlImport : NSObject{ 
@private
	NSString* m_import;
	NSString* m_namespace;
} 


@property (readwrite, retain, nonatomic) NSString* import;

@property (readwrite, retain, nonatomic) NSString* namespace;

+ (NSString*) importKey;

+ (NSString*) namespaceKey;

+ (GtWsdlImport*) wsdlImport; 

@end

@interface GtWsdlImport (ValueProperties) 
@end


@interface GtWsdlImport (ObjectMembers) 
@end

