// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookStatusMessage.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


#import "FLFacebookObject.h"
@class FLFacebookNamedObject;

// --------------------------------------------------------------------
// FLFacebookStatusMessage
// --------------------------------------------------------------------
@interface FLFacebookStatusMessage : FLFacebookObject<NSCopying, NSCoding>{ 
@private
    FLFacebookNamedObject* __from;
    NSString* __message;
    NSDate* __updated_time;
} 


@property (readwrite, strong, nonatomic) FLFacebookNamedObject* from;

@property (readwrite, strong, nonatomic) NSString* message;

@property (readwrite, strong, nonatomic) NSDate* updated_time;

+ (NSString*) fromKey;

+ (NSString*) messageKey;

+ (NSString*) updated_timeKey;

+ (FLFacebookStatusMessage*) facebookStatusMessage; 

@end

@interface FLFacebookStatusMessage (ValueProperties) 
@end

// [/Generated]
