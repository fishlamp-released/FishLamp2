// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookInsight.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// FLFacebookInsight
// --------------------------------------------------------------------
@interface FLFacebookInsight : NSObject{ 
@private
    NSNumber* __value;
    NSDate* __end_time;
} 


@property (readwrite, strong, nonatomic) NSDate* end_time;

@property (readwrite, strong, nonatomic) NSNumber* value;

+ (NSString*) end_timeKey;

+ (NSString*) valueKey;

+ (FLFacebookInsight*) facebookInsight; 

@end

@interface FLFacebookInsight (ValueProperties) 

@property (readwrite, assign, nonatomic) int valueValue;
@end

// [/Generated]
