// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookNetworkSession.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// FLFacebookNetworkSession
// --------------------------------------------------------------------
@interface FLFacebookNetworkSession : NSObject<NSCopying, NSCoding>{ 
@private
    NSString* __userId;
    NSString* __appId;
    NSString* __access_token;
    NSDate* __expiration_date;
    NSMutableArray* __permissions;
} 


@property (readwrite, strong, nonatomic) NSString* access_token;

@property (readwrite, strong, nonatomic) NSString* appId;

@property (readwrite, strong, nonatomic) NSDate* expiration_date;

@property (readwrite, strong, nonatomic) NSMutableArray* permissions;
/// Type: NSString*, forKey: permission

@property (readwrite, strong, nonatomic) NSString* userId;

+ (NSString*) access_tokenKey;

+ (NSString*) appIdKey;

+ (NSString*) expiration_dateKey;

+ (NSString*) permissionsKey;

+ (NSString*) userIdKey;

+ (FLFacebookNetworkSession*) facebookNetworkSession; 

@end

@interface FLFacebookNetworkSession (ValueProperties) 
@end

// [/Generated]
