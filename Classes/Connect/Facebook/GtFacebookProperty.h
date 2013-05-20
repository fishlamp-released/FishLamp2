//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookProperty.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//



// --------------------------------------------------------------------
// GtFacebookProperty
// --------------------------------------------------------------------
@interface GtFacebookProperty : NSObject<NSCopying, NSCoding>{ 
@private
	NSString* m_text;
	NSString* m_name;
	NSString* m_href;
} 


@property (readwrite, retain, nonatomic) NSString* href;

@property (readwrite, retain, nonatomic) NSString* name;

@property (readwrite, retain, nonatomic) NSString* text;

+ (NSString*) hrefKey;

+ (NSString*) nameKey;

+ (NSString*) textKey;

+ (GtFacebookProperty*) facebookProperty; 

@end

@interface GtFacebookProperty (ValueProperties) 
@end

