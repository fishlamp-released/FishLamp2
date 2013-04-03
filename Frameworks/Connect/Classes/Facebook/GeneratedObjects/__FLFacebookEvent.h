// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookEvent.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


#import "FLFacebookNamedObject.h"

// --------------------------------------------------------------------
// FLFacebookEvent
// --------------------------------------------------------------------
@interface FLFacebookEvent : FLFacebookNamedObject<NSCopying, NSCoding>{ 
@private
    NSString* __owner;
    NSString* __description;
    NSDate* __start_time;
    NSDate* __end_time;
    NSString* __location;
    NSString* __venue;
    NSString* __privacy;
    NSDate* __updated_time;
} 


@property (readwrite, strong, nonatomic) NSString* description;

@property (readwrite, strong, nonatomic) NSDate* end_time;

@property (readwrite, strong, nonatomic) NSString* location;

@property (readwrite, strong, nonatomic) NSString* owner;

@property (readwrite, strong, nonatomic) NSString* privacy;

@property (readwrite, strong, nonatomic) NSDate* start_time;

@property (readwrite, strong, nonatomic) NSDate* updated_time;

@property (readwrite, strong, nonatomic) NSString* venue;

+ (NSString*) descriptionKey;

+ (NSString*) end_timeKey;

+ (NSString*) locationKey;

+ (NSString*) ownerKey;

+ (NSString*) privacyKey;

+ (NSString*) start_timeKey;

+ (NSString*) updated_timeKey;

+ (NSString*) venueKey;

+ (FLFacebookEvent*) facebookEvent; 

@end

@interface FLFacebookEvent (ValueProperties) 
@end

// [/Generated]
