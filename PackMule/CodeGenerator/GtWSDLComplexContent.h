//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlComplexContent.h
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


@class GtWsdlExtension;
@class GtWsdlRestrictionArray;

// --------------------------------------------------------------------
// GtWsdlComplexContent
// --------------------------------------------------------------------
@interface GtWsdlComplexContent : NSObject{ 
@private
	NSString* m_mixed;
	GtWsdlExtension* m_extension;
	GtWsdlRestrictionArray* m_restriction;
} 


@property (readwrite, retain, nonatomic) GtWsdlExtension* extension;
// Getter will create m_extension if nil. Alternately, use the extensionObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* mixed;

@property (readwrite, retain, nonatomic) GtWsdlRestrictionArray* restriction;
// Getter will create m_restriction if nil. Alternately, use the restrictionObject property, which will not lazy create it.

+ (NSString*) extensionKey;

+ (NSString*) mixedKey;

+ (NSString*) restrictionKey;

+ (GtWsdlComplexContent*) wsdlComplexContent; 

@end

@interface GtWsdlComplexContent (ValueProperties) 
@end


@interface GtWsdlComplexContent (ObjectMembers) 

@property (readonly, retain, nonatomic) GtWsdlExtension* extensionObject;
// This returns m_extension. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) GtWsdlRestrictionArray* restrictionObject;
// This returns m_restriction. It does NOT create it if it's NIL.

- (void) createExtensionIfNil; 

- (void) createRestrictionIfNil; 
@end

