// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookGroup.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


#import "FLFacebookNamedObject.h"

// --------------------------------------------------------------------
// FLFacebookGroup
// --------------------------------------------------------------------
@interface FLFacebookGroup : FLFacebookNamedObject<NSCopying, NSCoding>{ 
@private
    NSString* __owner;
    NSString* __icon;
    NSString* __description;
    NSString* __link;
    NSString* __privacy;
    NSDate* __updated_time;
} 


@property (readwrite, strong, nonatomic) NSString* description;

@property (readwrite, strong, nonatomic) NSString* icon;

@property (readwrite, strong, nonatomic) NSString* link;

@property (readwrite, strong, nonatomic) NSString* owner;

@property (readwrite, strong, nonatomic) NSString* privacy;

@property (readwrite, strong, nonatomic) NSDate* updated_time;

+ (NSString*) descriptionKey;

+ (NSString*) iconKey;

+ (NSString*) linkKey;

+ (NSString*) ownerKey;

+ (NSString*) privacyKey;

+ (NSString*) updated_timeKey;

+ (FLFacebookGroup*) facebookGroup; 

@end

@interface FLFacebookGroup (ValueProperties) 
@end

// [/Generated]
