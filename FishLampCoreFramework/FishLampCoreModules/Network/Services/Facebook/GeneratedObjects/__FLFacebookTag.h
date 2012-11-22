// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookTag.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


@class FLFacebookNamedObject;

// --------------------------------------------------------------------
// FLFacebookTag
// --------------------------------------------------------------------
@interface FLFacebookTag : NSObject{ 
@private
    FLFacebookNamedObject* __user;
    NSNumber* __x;
    NSNumber* __y;
} 


@property (readwrite, strong, nonatomic) FLFacebookNamedObject* user;

@property (readwrite, strong, nonatomic) NSNumber* x;

@property (readwrite, strong, nonatomic) NSNumber* y;

+ (NSString*) userKey;

+ (NSString*) xKey;

+ (NSString*) yKey;

+ (FLFacebookTag*) facebookTag; 

@end

@interface FLFacebookTag (ValueProperties) 

@property (readwrite, assign, nonatomic) int xValue;

@property (readwrite, assign, nonatomic) int yValue;
@end

// [/Generated]
