// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookPrivacy.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// FLFacebookPrivacy
// --------------------------------------------------------------------
@interface FLFacebookPrivacy : NSObject<NSCopying, NSCoding>{ 
@private
    NSString* __value;
    NSString* __friends;
    NSString* __networks;
    NSString* __deny;
    NSString* __description;
} 


@property (readwrite, strong, nonatomic) NSString* deny;

@property (readwrite, strong, nonatomic) NSString* description;

@property (readwrite, strong, nonatomic) NSString* friends;

@property (readwrite, strong, nonatomic) NSString* networks;

@property (readwrite, strong, nonatomic) NSString* value;

+ (NSString*) denyKey;

+ (NSString*) descriptionKey;

+ (NSString*) friendsKey;

+ (NSString*) networksKey;

+ (NSString*) valueKey;

+ (FLFacebookPrivacy*) facebookPrivacy; 

@end

@interface FLFacebookPrivacy (ValueProperties) 
@end

// [/Generated]
