// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookCheckin.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


#import "FLFacebookObject.h"
@class FLFacebookObject;
@class FLFacebookDataList;
@class FLFacebookPlace;
@class FLFacebookNamedObject;

// --------------------------------------------------------------------
// FLFacebookCheckin
// --------------------------------------------------------------------
@interface FLFacebookCheckin : FLFacebookObject<NSCopying, NSCoding>{ 
@private
    FLFacebookObject* __from;
    FLFacebookDataList* __tags;
    FLFacebookPlace* __place;
    NSString* __message;
    FLFacebookNamedObject* __application;
    NSDate* __created_time;
} 


@property (readwrite, strong, nonatomic) FLFacebookNamedObject* application;

@property (readwrite, strong, nonatomic) NSDate* created_time;

@property (readwrite, strong, nonatomic) FLFacebookObject* from;

@property (readwrite, strong, nonatomic) NSString* message;

@property (readwrite, strong, nonatomic) FLFacebookPlace* place;

@property (readwrite, strong, nonatomic) FLFacebookDataList* tags;

+ (NSString*) applicationKey;

+ (NSString*) created_timeKey;

+ (NSString*) fromKey;

+ (NSString*) messageKey;

+ (NSString*) placeKey;

+ (NSString*) tagsKey;

+ (FLFacebookCheckin*) facebookCheckin; 

@end

@interface FLFacebookCheckin (ValueProperties) 
@end

// [/Generated]
