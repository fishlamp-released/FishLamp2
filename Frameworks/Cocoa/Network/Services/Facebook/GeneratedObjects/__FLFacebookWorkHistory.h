// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookWorkHistory.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


#import "FLFacebookNamedObject.h"
@class FLFacebookNamedObject;

// --------------------------------------------------------------------
// FLFacebookWorkHistory
// --------------------------------------------------------------------
@interface FLFacebookWorkHistory : FLFacebookNamedObject<NSCopying, NSCoding>{ 
@private
    FLFacebookNamedObject* __employer;
    FLFacebookNamedObject* __location;
    FLFacebookNamedObject* __position;
    NSDate* __start_date;
    NSDate* __end_date;
} 


@property (readwrite, strong, nonatomic) FLFacebookNamedObject* employer;

@property (readwrite, strong, nonatomic) NSDate* end_date;

@property (readwrite, strong, nonatomic) FLFacebookNamedObject* location;

@property (readwrite, strong, nonatomic) FLFacebookNamedObject* position;

@property (readwrite, strong, nonatomic) NSDate* start_date;

+ (NSString*) employerKey;

+ (NSString*) end_dateKey;

+ (NSString*) locationKey;

+ (NSString*) positionKey;

+ (NSString*) start_dateKey;

+ (FLFacebookWorkHistory*) facebookWorkHistory; 

@end

@interface FLFacebookWorkHistory (ValueProperties) 
@end

// [/Generated]
