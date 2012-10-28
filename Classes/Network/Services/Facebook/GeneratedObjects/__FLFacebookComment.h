// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookComment.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


#import "FLFacebookObject.h"
@class FLFacebookNamedObject;

// --------------------------------------------------------------------
// FLFacebookComment
// --------------------------------------------------------------------
@interface FLFacebookComment : FLFacebookObject<NSCopying, NSCoding>{ 
@private
    NSDate* __created_time;
    NSString* __message;
    FLFacebookNamedObject* __from;
    NSNumber* __likes;
} 


@property (readwrite, strong, nonatomic) NSDate* created_time;

@property (readwrite, strong, nonatomic) FLFacebookNamedObject* from;

@property (readwrite, strong, nonatomic) NSNumber* likes;

@property (readwrite, strong, nonatomic) NSString* message;

+ (NSString*) created_timeKey;

+ (NSString*) fromKey;

+ (NSString*) likesKey;

+ (NSString*) messageKey;

+ (FLFacebookComment*) facebookComment; 

@end

@interface FLFacebookComment (ValueProperties) 

@property (readwrite, assign, nonatomic) int likesValue;
@end

// [/Generated]
