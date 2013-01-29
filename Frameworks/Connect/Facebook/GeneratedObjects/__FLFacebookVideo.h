// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookVideo.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


#import "FLFacebookNamedObject.h"
@class FLFacebookNamedObject;
@class FLFacebookTag;

// --------------------------------------------------------------------
// FLFacebookVideo
// --------------------------------------------------------------------
@interface FLFacebookVideo : FLFacebookNamedObject<NSCopying, NSCoding>{ 
@private
    FLFacebookNamedObject* __from;
    NSDate* __updated_time;
    NSDate* __created_time;
    NSString* __embed_html;
    NSString* __icon;
    NSString* __source;
    NSMutableArray* __tags;
} 


@property (readwrite, strong, nonatomic) NSDate* created_time;

@property (readwrite, strong, nonatomic) NSString* embed_html;

@property (readwrite, strong, nonatomic) FLFacebookNamedObject* from;

@property (readwrite, strong, nonatomic) NSString* icon;

@property (readwrite, strong, nonatomic) NSString* source;

@property (readwrite, strong, nonatomic) NSMutableArray* tags;
/// Type: FLFacebookTag*, forKey: tag

@property (readwrite, strong, nonatomic) NSDate* updated_time;

+ (NSString*) created_timeKey;

+ (NSString*) embed_htmlKey;

+ (NSString*) fromKey;

+ (NSString*) iconKey;

+ (NSString*) sourceKey;

+ (NSString*) tagsKey;

+ (NSString*) updated_timeKey;

+ (FLFacebookVideo*) facebookVideo; 

@end

@interface FLFacebookVideo (ValueProperties) 
@end

// [/Generated]
