//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlInputOutput.h
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


@class GtWsdlMessageBody;
@class GtWsdlContent;
@class GtWsdlMime;

// --------------------------------------------------------------------
// GtWsdlInputOutput
// --------------------------------------------------------------------
@interface GtWsdlInputOutput : NSObject{ 
@private
	NSString* m_message;
	NSString* m_type;
	GtWsdlMessageBody* m_body;
	GtWsdlContent* m_content;
	NSString* m_urlEncoded;
	GtWsdlMime* m_mimeXml;
} 


@property (readwrite, retain, nonatomic) GtWsdlMessageBody* body;
// Getter will create m_body if nil. Alternately, use the bodyObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) GtWsdlContent* content;
// Getter will create m_content if nil. Alternately, use the contentObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* message;

@property (readwrite, retain, nonatomic) GtWsdlMime* mimeXml;
// Getter will create m_mimeXml if nil. Alternately, use the mimeXmlObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* type;

@property (readwrite, retain, nonatomic) NSString* urlEncoded;

+ (NSString*) bodyKey;

+ (NSString*) contentKey;

+ (NSString*) messageKey;

+ (NSString*) mimeXmlKey;

+ (NSString*) typeKey;

+ (NSString*) urlEncodedKey;

+ (GtWsdlInputOutput*) wsdlInputOutput; 

@end

@interface GtWsdlInputOutput (ValueProperties) 
@end


@interface GtWsdlInputOutput (ObjectMembers) 

@property (readonly, retain, nonatomic) GtWsdlMessageBody* bodyObject;
// This returns m_body. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) GtWsdlContent* contentObject;
// This returns m_content. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) GtWsdlMime* mimeXmlObject;
// This returns m_mimeXml. It does NOT create it if it's NIL.

- (void) createBodyIfNil; 

- (void) createContentIfNil; 

- (void) createMimeXmlIfNil; 
@end

