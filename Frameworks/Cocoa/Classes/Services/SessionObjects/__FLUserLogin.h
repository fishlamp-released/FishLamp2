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

#import "FLModelObject.h"

// --------------------------------------------------------------------
// FLUserLogin
// --------------------------------------------------------------------
@interface FLUserLogin : FLModelObject { 
@private
    NSString* __userGuid;
    NSString* __userName;
    NSString* __password;
    BOOL __isAuthenticated;
    NSString* __authToken;
    NSString* __email;
    NSTimeInterval __authTokenLastUpdateTime;
} 

@property (readwrite, strong, nonatomic) NSString* authToken;
@property (readwrite, assign, nonatomic) NSTimeInterval authTokenLastUpdateTime;
@property (readwrite, strong, nonatomic) NSString* email;
@property (readwrite, assign, nonatomic) BOOL isAuthenticated;
@property (readwrite, strong, nonatomic) NSString* password;
@property (readwrite, strong, nonatomic) NSString* userGuid;
@property (readwrite, strong, nonatomic) NSString* userName;

+ (id) userLogin; 

@end

@interface FLUserLogin (ValueProperties) 

@property (readwrite, assign, nonatomic) BOOL isAuthenticatedValue;

@property (readwrite, assign, nonatomic) double authTokenLastUpdateTimeValue;

@property (readwrite, assign, nonatomic) long userValueValue;
@end

// [/Generated]
