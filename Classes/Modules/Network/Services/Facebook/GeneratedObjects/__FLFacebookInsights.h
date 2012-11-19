// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookInsights.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


#import "FLFacebookNamedObject.h"
@class FLFacebookInsight;

// --------------------------------------------------------------------
// FLFacebookInsights
// --------------------------------------------------------------------
@interface FLFacebookInsights : FLFacebookNamedObject<NSCopying, NSCoding>{ 
@private
    NSString* __period;
    NSMutableArray* __values;
} 


@property (readwrite, strong, nonatomic) NSString* period;

@property (readwrite, strong, nonatomic) NSMutableArray* values;
/// Type: FLFacebookInsight*, forKey: insights

+ (NSString*) periodKey;

+ (NSString*) valuesKey;

+ (FLFacebookInsights*) facebookInsights; 

@end

@interface FLFacebookInsights (ValueProperties) 
@end

// [/Generated]
