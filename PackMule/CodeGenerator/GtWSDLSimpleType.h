//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlSimpleType.h
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


@class GtWsdlRestrictionArray;
@class GtWsdlList;

// --------------------------------------------------------------------
// GtWsdlSimpleType
// --------------------------------------------------------------------
@interface GtWsdlSimpleType : NSObject{ 
@private
	NSString* m_name;
	GtWsdlRestrictionArray* m_restriction;
	GtWsdlList* m_list;
} 


@property (readwrite, retain, nonatomic) GtWsdlList* list;
// Getter will create m_list if nil. Alternately, use the listObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* name;

@property (readwrite, retain, nonatomic) GtWsdlRestrictionArray* restriction;
// Getter will create m_restriction if nil. Alternately, use the restrictionObject property, which will not lazy create it.

+ (NSString*) listKey;

+ (NSString*) nameKey;

+ (NSString*) restrictionKey;

+ (GtWsdlSimpleType*) wsdlSimpleType; 

@end

@interface GtWsdlSimpleType (ValueProperties) 
@end


@interface GtWsdlSimpleType (ObjectMembers) 

@property (readonly, retain, nonatomic) GtWsdlRestrictionArray* restrictionObject;
// This returns m_restriction. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) GtWsdlList* listObject;
// This returns m_list. It does NOT create it if it's NIL.

- (void) createRestrictionIfNil; 

- (void) createListIfNil; 
@end

