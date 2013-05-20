//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlSchema.h
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


#import "GtWsdlElementBaseType.h"
@class GtWsdlImport;

// --------------------------------------------------------------------
// GtWsdlSchema
// --------------------------------------------------------------------
@interface GtWsdlSchema : GtWsdlElementBaseType{ 
@private
	NSString* m_elementFormDefault;
	NSString* m_targetNamespace;
	NSMutableArray* m_imports;
} 


@property (readwrite, retain, nonatomic) NSString* elementFormDefault;

@property (readwrite, retain, nonatomic) NSMutableArray* imports;
// Getter will create m_imports if nil. Alternately, use the importsObject property, which will not lazy create it.
// Type: GtWsdlImport*, forKey: import

@property (readwrite, retain, nonatomic) NSString* targetNamespace;

+ (NSString*) elementFormDefaultKey;

+ (NSString*) importsKey;

+ (NSString*) targetNamespaceKey;

+ (GtWsdlSchema*) wsdlSchema; 

@end

@interface GtWsdlSchema (ValueProperties) 
@end


@interface GtWsdlSchema (ObjectMembers) 

@property (readonly, retain, nonatomic) NSMutableArray* importsObject;
// This returns m_imports. It does NOT create it if it's NIL.
// Type: GtWsdlImport*, forKey: import

- (void) createImportsIfNil; 
@end

