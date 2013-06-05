// 
// FLFacebookInsights.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/28/13 2:04 PM with PackMule (3.0.0.1)
// 
// Project: FishLamp Connect
// Schema: FishLampFacebook
// 
// Copyright 2013 (c) GreenTongue Software, LLC
// 

#import "FLFacebookNamedObject.h"
@class FLObjectDescriber;
@class FLFacebookInsight;
@interface FLFacebookInsights : FLFacebookNamedObject {
@private
    NSString* _period;
    NSMutableArray* _values;
}

@property (readwrite, strong, nonatomic) NSString* period;
@property (readwrite, strong, nonatomic) NSMutableArray* values;
+(FLFacebookInsights*) facebookInsights;
@end