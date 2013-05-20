//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlElementBaseType.h
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


@class GtWsdlComplexType;
@class GtWsdlElement;
@class GtWsdlSimpleType;

// --------------------------------------------------------------------
// GtWsdlElementBaseType
// --------------------------------------------------------------------
@interface GtWsdlElementBaseType : NSObject{ 
@private
	NSMutableArray* m_elements;
	NSMutableArray* m_simpleTypes;
	NSMutableArray* m_complexTypes;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* complexTypes;
// Getter will create m_complexTypes if nil. Alternately, use the complexTypesObject property, which will not lazy create it.
// Type: GtWsdlComplexType*, forKey: complexType

@property (readwrite, retain, nonatomic) NSMutableArray* elements;
// Getter will create m_elements if nil. Alternately, use the elementsObject property, which will not lazy create it.
// Type: GtWsdlElement*, forKey: element

@property (readwrite, retain, nonatomic) NSMutableArray* simpleTypes;
// Getter will create m_simpleTypes if nil. Alternately, use the simpleTypesObject property, which will not lazy create it.
// Type: GtWsdlSimpleType*, forKey: simpleType

+ (NSString*) complexTypesKey;

+ (NSString*) elementsKey;

+ (NSString*) simpleTypesKey;

+ (GtWsdlElementBaseType*) wsdlElementBaseType; 

@end

@interface GtWsdlElementBaseType (ValueProperties) 
@end


@interface GtWsdlElementBaseType (ObjectMembers) 

@property (readonly, retain, nonatomic) NSMutableArray* elementsObject;
// This returns m_elements. It does NOT create it if it's NIL.
// Type: GtWsdlElement*, forKey: element

@property (readonly, retain, nonatomic) NSMutableArray* simpleTypesObject;
// This returns m_simpleTypes. It does NOT create it if it's NIL.
// Type: GtWsdlSimpleType*, forKey: simpleType

@property (readonly, retain, nonatomic) NSMutableArray* complexTypesObject;
// This returns m_complexTypes. It does NOT create it if it's NIL.
// Type: GtWsdlComplexType*, forKey: complexType

- (void) createElementsIfNil; 

- (void) createSimpleTypesIfNil; 

- (void) createComplexTypesIfNil; 
@end

