// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookEmployer.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


#import "FLFacebookNamedObject.h"

// --------------------------------------------------------------------
// FLFacebookEmployer
// --------------------------------------------------------------------
@interface FLFacebookEmployer : FLFacebookNamedObject<NSCopying, NSCoding>{ 
@private
    NSString* __employer;
    NSString* __location;
    NSString* __position;
    NSDate* __start_date;
    NSDate* __end_date;
} 


@property (readwrite, strong, nonatomic) NSString* employer;

@property (readwrite, strong, nonatomic) NSDate* end_date;

@property (readwrite, strong, nonatomic) NSString* location;

@property (readwrite, strong, nonatomic) NSString* position;

@property (readwrite, strong, nonatomic) NSDate* start_date;

+ (NSString*) employerKey;

+ (NSString*) end_dateKey;

+ (NSString*) locationKey;

+ (NSString*) positionKey;

+ (NSString*) start_dateKey;

+ (FLFacebookEmployer*) facebookEmployer; 

@end

@interface FLFacebookEmployer (ValueProperties) 
@end

// [/Generated]
