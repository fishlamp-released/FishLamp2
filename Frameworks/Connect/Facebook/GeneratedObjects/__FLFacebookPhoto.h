// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookPhoto.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


#import "FLFacebookNamedObject.h"
@class FLFacebookNamedObject;
@class FLFacebookTag;

// --------------------------------------------------------------------
// FLFacebookPhoto
// --------------------------------------------------------------------
@interface FLFacebookPhoto : FLFacebookNamedObject<NSCopying, NSCoding>{ 
@private
    FLFacebookNamedObject* __from;
    NSDate* __updated_time;
    NSDate* __created_time;
    NSString* __link;
    NSString* __icon;
    NSString* __source;
    NSNumber* __height;
    NSNumber* __width;
    NSMutableArray* __tags;
} 


@property (readwrite, strong, nonatomic) NSDate* created_time;

@property (readwrite, strong, nonatomic) FLFacebookNamedObject* from;

@property (readwrite, strong, nonatomic) NSNumber* height;

@property (readwrite, strong, nonatomic) NSString* icon;

@property (readwrite, strong, nonatomic) NSString* link;

@property (readwrite, strong, nonatomic) NSString* source;

@property (readwrite, strong, nonatomic) NSMutableArray* tags;
/// Type: FLFacebookTag*, forKey: tag

@property (readwrite, strong, nonatomic) NSDate* updated_time;

@property (readwrite, strong, nonatomic) NSNumber* width;

+ (NSString*) created_timeKey;

+ (NSString*) fromKey;

+ (NSString*) heightKey;

+ (NSString*) iconKey;

+ (NSString*) linkKey;

+ (NSString*) sourceKey;

+ (NSString*) tagsKey;

+ (NSString*) updated_timeKey;

+ (NSString*) widthKey;

+ (FLFacebookPhoto*) facebookPhoto; 

@end

@interface FLFacebookPhoto (ValueProperties) 

@property (readwrite, assign, nonatomic) int heightValue;

@property (readwrite, assign, nonatomic) int widthValue;
@end

// [/Generated]
