//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlComplexType.h
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


#import "GtWsdlSequenceArray.h"
@class GtWsdlChoiceArray;
@class GtWsdlComplexContent;

// --------------------------------------------------------------------
// GtWsdlComplexType
// --------------------------------------------------------------------
@interface GtWsdlComplexType : GtWsdlSequenceArray{ 
@private
	NSString* m_name;
	GtWsdlChoiceArray* m_choice;
	GtWsdlComplexContent* m_complexContent;
} 


@property (readwrite, retain, nonatomic) GtWsdlChoiceArray* choice;
// Getter will create m_choice if nil. Alternately, use the choiceObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) GtWsdlComplexContent* complexContent;
// Getter will create m_complexContent if nil. Alternately, use the complexContentObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* name;

+ (NSString*) choiceKey;

+ (NSString*) complexContentKey;

+ (NSString*) nameKey;

+ (GtWsdlComplexType*) wsdlComplexType; 

@end

@interface GtWsdlComplexType (ValueProperties) 
@end


@interface GtWsdlComplexType (ObjectMembers) 

@property (readonly, retain, nonatomic) GtWsdlChoiceArray* choiceObject;
// This returns m_choice. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) GtWsdlComplexContent* complexContentObject;
// This returns m_complexContent. It does NOT create it if it's NIL.

- (void) createChoiceIfNil; 

- (void) createComplexContentIfNil; 
@end

