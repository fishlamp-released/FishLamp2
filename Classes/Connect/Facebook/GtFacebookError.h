//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookError.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//



// --------------------------------------------------------------------
// GtFacebookError
// --------------------------------------------------------------------
@interface GtFacebookError : NSObject<NSCopying, NSCoding>{ 
@private
	NSString* m_error_reason;
	NSString* m_error;
	NSString* m_error_description;
	NSString* m_externalUrl;
} 


@property (readwrite, retain, nonatomic) NSString* error;

@property (readwrite, retain, nonatomic) NSString* error_description;

@property (readwrite, retain, nonatomic) NSString* error_reason;

@property (readwrite, retain, nonatomic) NSString* externalUrl;

+ (NSString*) errorKey;

+ (NSString*) error_descriptionKey;

+ (NSString*) error_reasonKey;

+ (NSString*) externalUrlKey;

+ (GtFacebookError*) facebookError; 

@end

@interface GtFacebookError (ValueProperties) 
@end

