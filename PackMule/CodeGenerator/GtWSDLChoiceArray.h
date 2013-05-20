//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlChoiceArray.h
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


@class GtWsdlElement;

// --------------------------------------------------------------------
// GtWsdlChoiceArray
// --------------------------------------------------------------------
@interface GtWsdlChoiceArray : NSObject{ 
@private
	NSString* m_minOccurs;
	NSString* m_maxOccurs;
	NSMutableArray* m_elements;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* elements;
// Getter will create m_elements if nil. Alternately, use the elementsObject property, which will not lazy create it.
// Type: GtWsdlElement*, forKey: element

@property (readwrite, retain, nonatomic) NSString* maxOccurs;

@property (readwrite, retain, nonatomic) NSString* minOccurs;

+ (NSString*) elementsKey;

+ (NSString*) maxOccursKey;

+ (NSString*) minOccursKey;

+ (GtWsdlChoiceArray*) wsdlChoiceArray; 

@end

@interface GtWsdlChoiceArray (ValueProperties) 
@end


@interface GtWsdlChoiceArray (ObjectMembers) 

@property (readonly, retain, nonatomic) NSMutableArray* elementsObject;
// This returns m_elements. It does NOT create it if it's NIL.
// Type: GtWsdlElement*, forKey: element

- (void) createElementsIfNil; 
@end

