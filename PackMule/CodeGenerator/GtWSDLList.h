//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlList.h
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


@class GtWsdlSimpleType;

// --------------------------------------------------------------------
// GtWsdlList
// --------------------------------------------------------------------
@interface GtWsdlList : NSObject{ 
@private
	GtWsdlSimpleType* m_simpleType;
} 


@property (readwrite, retain, nonatomic) GtWsdlSimpleType* simpleType;
// Getter will create m_simpleType if nil. Alternately, use the simpleTypeObject property, which will not lazy create it.

+ (NSString*) simpleTypeKey;

+ (GtWsdlList*) wsdlList; 

@end

@interface GtWsdlList (ValueProperties) 
@end


@interface GtWsdlList (ObjectMembers) 

@property (readonly, retain, nonatomic) GtWsdlSimpleType* simpleTypeObject;
// This returns m_simpleType. It does NOT create it if it's NIL.

- (void) createSimpleTypeIfNil; 
@end

