//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlSequenceArray.h
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


@class GtWsdlElement;

// --------------------------------------------------------------------
// GtWsdlSequenceArray
// --------------------------------------------------------------------
@interface GtWsdlSequenceArray : NSObject{ 
@private
	NSString* m_minOccurs;
	NSString* m_maxOccurs;
	NSMutableArray* m_sequence;
} 


@property (readwrite, retain, nonatomic) NSString* maxOccurs;

@property (readwrite, retain, nonatomic) NSString* minOccurs;

@property (readwrite, retain, nonatomic) NSMutableArray* sequence;
// Getter will create m_sequence if nil. Alternately, use the sequenceObject property, which will not lazy create it.
// Type: GtWsdlElement*, forKey: element

+ (NSString*) maxOccursKey;

+ (NSString*) minOccursKey;

+ (NSString*) sequenceKey;

+ (GtWsdlSequenceArray*) wsdlSequenceArray; 

@end

@interface GtWsdlSequenceArray (ValueProperties) 
@end


@interface GtWsdlSequenceArray (ObjectMembers) 

@property (readonly, retain, nonatomic) NSMutableArray* sequenceObject;
// This returns m_sequence. It does NOT create it if it's NIL.
// Type: GtWsdlElement*, forKey: element

- (void) createSequenceIfNil; 
@end

