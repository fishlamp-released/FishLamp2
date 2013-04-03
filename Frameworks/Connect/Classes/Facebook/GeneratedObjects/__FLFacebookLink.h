// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookLink.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


#import "FLFacebookNamedObject.h"
@class FLFacebookObject;

// --------------------------------------------------------------------
// FLFacebookLink
// --------------------------------------------------------------------
@interface FLFacebookLink : FLFacebookNamedObject<NSCopying, NSCoding>{ 
@private
    FLFacebookObject* __from;
    NSString* __link;
    NSString* __caption;
    NSString* __description;
    NSString* __icon;
    NSString* __picture;
    NSString* __message;
    NSDate* __created_time;
} 


@property (readwrite, strong, nonatomic) NSString* caption;

@property (readwrite, strong, nonatomic) NSDate* created_time;

@property (readwrite, strong, nonatomic) NSString* description;

@property (readwrite, strong, nonatomic) FLFacebookObject* from;

@property (readwrite, strong, nonatomic) NSString* icon;

@property (readwrite, strong, nonatomic) NSString* link;

@property (readwrite, strong, nonatomic) NSString* message;

@property (readwrite, strong, nonatomic) NSString* picture;

+ (NSString*) captionKey;

+ (NSString*) created_timeKey;

+ (NSString*) descriptionKey;

+ (NSString*) fromKey;

+ (NSString*) iconKey;

+ (NSString*) linkKey;

+ (NSString*) messageKey;

+ (NSString*) pictureKey;

+ (FLFacebookLink*) facebookLink; 

@end

@interface FLFacebookLink (ValueProperties) 
@end

// [/Generated]
