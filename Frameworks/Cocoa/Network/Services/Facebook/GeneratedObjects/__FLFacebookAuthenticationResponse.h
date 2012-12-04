// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookAuthenticationResponse.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


@class FLFacebookNetworkSession;

// --------------------------------------------------------------------
// FLFacebookAuthenticationResponse
// --------------------------------------------------------------------
@interface FLFacebookAuthenticationResponse : NSObject<NSCopying, NSCoding>{ 
@private
    FLFacebookNetworkSession* __session;
    NSURL* __redirectURL;
} 


@property (readwrite, strong, nonatomic) NSURL* redirectURL;

@property (readwrite, strong, nonatomic) FLFacebookNetworkSession* session;

+ (NSString*) redirectURLKey;

+ (NSString*) sessionKey;

+ (FLFacebookAuthenticationResponse*) facebookAuthenticationResponse; 

@end

@interface FLFacebookAuthenticationResponse (ValueProperties) 
@end

// [/Generated]
