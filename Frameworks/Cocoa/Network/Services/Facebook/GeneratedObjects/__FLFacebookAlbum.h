// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookAlbum.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


#import "FLFacebookNamedObject.h"
@class FLFacebookNamedObject;

// --------------------------------------------------------------------
// FLFacebookAlbum
// --------------------------------------------------------------------
@interface FLFacebookAlbum : FLFacebookNamedObject<NSCopying, NSCoding>{ 
@private
    NSString* __description;
    FLFacebookNamedObject* __from;
    NSString* __location;
    NSString* __link;
    NSString* __cover_photo;
    NSString* __privacy;
    NSString* __count;
    NSString* __type;
    NSDate* __created_time;
    NSDate* __updated_time;
} 


@property (readwrite, strong, nonatomic) NSString* count;

@property (readwrite, strong, nonatomic) NSString* cover_photo;

@property (readwrite, strong, nonatomic) NSDate* created_time;

@property (readwrite, strong, nonatomic) NSString* description;

@property (readwrite, strong, nonatomic) FLFacebookNamedObject* from;

@property (readwrite, strong, nonatomic) NSString* link;

@property (readwrite, strong, nonatomic) NSString* location;

@property (readwrite, strong, nonatomic) NSString* privacy;

@property (readwrite, strong, nonatomic) NSString* type;

@property (readwrite, strong, nonatomic) NSDate* updated_time;

+ (NSString*) countKey;

+ (NSString*) cover_photoKey;

+ (NSString*) created_timeKey;

+ (NSString*) descriptionKey;

+ (NSString*) fromKey;

+ (NSString*) linkKey;

+ (NSString*) locationKey;

+ (NSString*) privacyKey;

+ (NSString*) typeKey;

+ (NSString*) updated_timeKey;

+ (FLFacebookAlbum*) facebookAlbum; 

@end

@interface FLFacebookAlbum (ValueProperties) 
@end

// [/Generated]
