//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookAuthenticationResponse.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


@class GtFacebookNetworkSession;

// --------------------------------------------------------------------
// GtFacebookAuthenticationResponse
// --------------------------------------------------------------------
@interface GtFacebookAuthenticationResponse : NSObject<NSCopying, NSCoding>{ 
@private
	GtFacebookNetworkSession* m_session;
	NSURL* m_redirectURL;
} 


@property (readwrite, retain, nonatomic) NSURL* redirectURL;

@property (readwrite, retain, nonatomic) GtFacebookNetworkSession* session;

+ (NSString*) redirectURLKey;

+ (NSString*) sessionKey;

+ (GtFacebookAuthenticationResponse*) facebookAuthenticationResponse; 

@end

@interface GtFacebookAuthenticationResponse (ValueProperties) 
@end

