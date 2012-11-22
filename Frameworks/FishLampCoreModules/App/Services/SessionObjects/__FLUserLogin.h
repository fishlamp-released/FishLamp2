// [Generated]
//
// This file was generated at 5/31/12 5:54 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLUserLogin.h
// Project: FishLamp
// Schema: FLGeneratedCoreObject
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// FLUserLogin
// --------------------------------------------------------------------
@interface FLUserLogin : NSObject<NSCopying, NSCoding>{ 
@private
    NSString* __userGuid;
    NSString* __userName;
    NSString* __password;
    NSNumber* __isAuthenticated;
    NSString* __authToken;
    NSString* __email;
    NSNumber* __authTokenLastUpdateTime;
    NSNumber* __userValue;
} 


@property (readwrite, strong, nonatomic) NSString* authToken;

@property (readwrite, strong, nonatomic) NSNumber* authTokenLastUpdateTime;

@property (readwrite, strong, nonatomic) NSString* email;

@property (readwrite, strong, nonatomic) NSNumber* isAuthenticated;

@property (readwrite, strong, nonatomic) NSString* password;

@property (readwrite, strong, nonatomic) NSString* userGuid;

@property (readwrite, strong, nonatomic) NSString* userName;

@property (readwrite, strong, nonatomic) NSNumber* userValue;

+ (NSString*) authTokenKey;

+ (NSString*) authTokenLastUpdateTimeKey;

+ (NSString*) emailKey;

+ (NSString*) isAuthenticatedKey;

+ (NSString*) passwordKey;

+ (NSString*) userGuidKey;

+ (NSString*) userNameKey;

+ (NSString*) userValueKey;

+ (FLUserLogin*) userLogin; 

@end

@interface FLUserLogin (ValueProperties) 

@property (readwrite, assign, nonatomic) BOOL isAuthenticatedValue;

@property (readwrite, assign, nonatomic) double authTokenLastUpdateTimeValue;

@property (readwrite, assign, nonatomic) long userValueValue;
@end

// [/Generated]
