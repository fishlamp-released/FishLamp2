// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookMessage.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


#import "FLFacebookObject.h"
@class FLFacebookEmailObject;

// --------------------------------------------------------------------
// FLFacebookMessage
// --------------------------------------------------------------------
@interface FLFacebookMessage : FLFacebookObject<NSCopying, NSCoding>{ 
@private
    FLFacebookEmailObject* __from;
    FLFacebookEmailObject* __to;
    NSString* __message;
    NSDate* __created_time;
} 


@property (readwrite, strong, nonatomic) NSDate* created_time;

@property (readwrite, strong, nonatomic) FLFacebookEmailObject* from;

@property (readwrite, strong, nonatomic) NSString* message;

@property (readwrite, strong, nonatomic) FLFacebookEmailObject* to;

+ (NSString*) created_timeKey;

+ (NSString*) fromKey;

+ (NSString*) messageKey;

+ (NSString*) toKey;

+ (FLFacebookMessage*) facebookMessage; 

@end

@interface FLFacebookMessage (ValueProperties) 
@end

// [/Generated]
