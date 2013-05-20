//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlRestrictionArray.h
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


#import "GtWsdlSequenceArray.h"
@class GtWsdlElement;
@class GtWsdlEnumeration;

// --------------------------------------------------------------------
// GtWsdlRestrictionArray
// --------------------------------------------------------------------
@interface GtWsdlRestrictionArray : GtWsdlSequenceArray{ 
@private
	NSString* m_base;
	NSMutableArray* m_enumerations;
	NSMutableArray* m_elements;
} 


@property (readwrite, retain, nonatomic) NSString* base;

@property (readwrite, retain, nonatomic) NSMutableArray* elements;
// Getter will create m_elements if nil. Alternately, use the elementsObject property, which will not lazy create it.
// Type: GtWsdlElement*, forKey: element

@property (readwrite, retain, nonatomic) NSMutableArray* enumerations;
// Getter will create m_enumerations if nil. Alternately, use the enumerationsObject property, which will not lazy create it.
// Type: GtWsdlEnumeration*, forKey: enumeration

+ (NSString*) baseKey;

+ (NSString*) elementsKey;

+ (NSString*) enumerationsKey;

+ (GtWsdlRestrictionArray*) wsdlRestrictionArray; 

@end

@interface GtWsdlRestrictionArray (ValueProperties) 
@end


@interface GtWsdlRestrictionArray (ObjectMembers) 

@property (readonly, retain, nonatomic) NSMutableArray* enumerationsObject;
// This returns m_enumerations. It does NOT create it if it's NIL.
// Type: GtWsdlEnumeration*, forKey: enumeration

@property (readonly, retain, nonatomic) NSMutableArray* elementsObject;
// This returns m_elements. It does NOT create it if it's NIL.
// Type: GtWsdlElement*, forKey: element

- (void) createEnumerationsIfNil; 

- (void) createElementsIfNil; 
@end

