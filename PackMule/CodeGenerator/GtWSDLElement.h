//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlElement.h
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


@class GtWsdlComplexType;

// --------------------------------------------------------------------
// GtWsdlElement
// --------------------------------------------------------------------
@interface GtWsdlElement : NSObject{ 
@private
	NSString* m_minOccurs;
	NSString* m_maxOccurs;
	NSString* m_name;
	NSString* m_type;
	NSString* m_ref;
	NSNumber* m_nillable;
	GtWsdlComplexType* m_complexType;
} 


@property (readwrite, retain, nonatomic) GtWsdlComplexType* complexType;
// Getter will create m_complexType if nil. Alternately, use the complexTypeObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* maxOccurs;

@property (readwrite, retain, nonatomic) NSString* minOccurs;

@property (readwrite, retain, nonatomic) NSString* name;

@property (readwrite, retain, nonatomic) NSNumber* nillable;

@property (readwrite, retain, nonatomic) NSString* ref;

@property (readwrite, retain, nonatomic) NSString* type;

+ (NSString*) complexTypeKey;

+ (NSString*) maxOccursKey;

+ (NSString*) minOccursKey;

+ (NSString*) nameKey;

+ (NSString*) nillableKey;

+ (NSString*) refKey;

+ (NSString*) typeKey;

+ (GtWsdlElement*) wsdlElement; 

@end

@interface GtWsdlElement (ValueProperties) 

@property (readwrite, assign, nonatomic) BOOL nillableValue;
@end


@interface GtWsdlElement (ObjectMembers) 

@property (readonly, retain, nonatomic) GtWsdlComplexType* complexTypeObject;
// This returns m_complexType. It does NOT create it if it's NIL.

- (void) createComplexTypeIfNil; 
@end

