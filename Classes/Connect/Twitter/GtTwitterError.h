//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtTwitterError.h
//	Project: FishLamp
//	Schema: Twitter
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//



// --------------------------------------------------------------------
// GtTwitterError
// --------------------------------------------------------------------
@interface GtTwitterError : NSObject<NSCopying, NSCoding>{ 
@private
	NSString* m_error;
	NSString* m_request;
} 


@property (readwrite, retain, nonatomic) NSString* error;

@property (readwrite, retain, nonatomic) NSString* request;

+ (NSString*) errorKey;

+ (NSString*) requestKey;

+ (GtTwitterError*) twitterError; 

@end

@interface GtTwitterError (ValueProperties) 
@end

