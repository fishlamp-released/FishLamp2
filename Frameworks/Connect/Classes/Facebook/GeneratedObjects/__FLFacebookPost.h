// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookPost.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


#import "FLFacebookNamedObject.h"
@class FLFacebookNamedObject;
@class FLFacebookNamedObjectList;
@class FLFacebookPrivacy;
@class FLFacebookCommentList;
@class FLFacebookAction;
@class FLFacebookProperty;

// --------------------------------------------------------------------
// FLFacebookPost
// --------------------------------------------------------------------
@interface FLFacebookPost : FLFacebookNamedObject<NSCopying, NSCoding>{ 
@private
    NSString* __object_id;
    FLFacebookNamedObject* __from;
    FLFacebookNamedObjectList* __to;
    NSString* __message;
    NSString* __picture;
    NSString* __link;
    NSString* __caption;
    NSString* __description;
    NSString* __source;
    NSString* __icon;
    NSMutableArray* __properties;
    FLFacebookNamedObject* __application;
    FLFacebookPrivacy* __privacy;
    FLFacebookCommentList* __comments;
    FLFacebookNamedObjectList* __likes;
    NSMutableArray* __actions;
    NSString* __type;
    NSDate* __updated_time;
    NSDate* __created_time;
} 


@property (readwrite, strong, nonatomic) NSMutableArray* actions;
/// Type: FLFacebookAction*, forKey: action

@property (readwrite, strong, nonatomic) FLFacebookNamedObject* application;

@property (readwrite, strong, nonatomic) NSString* caption;

@property (readwrite, strong, nonatomic) FLFacebookCommentList* comments;

@property (readwrite, strong, nonatomic) NSDate* created_time;

@property (readwrite, strong, nonatomic) NSString* description;

@property (readwrite, strong, nonatomic) FLFacebookNamedObject* from;

@property (readwrite, strong, nonatomic) NSString* icon;

@property (readwrite, strong, nonatomic) FLFacebookNamedObjectList* likes;

@property (readwrite, strong, nonatomic) NSString* link;

@property (readwrite, strong, nonatomic) NSString* message;

@property (readwrite, strong, nonatomic) NSString* object_id;

@property (readwrite, strong, nonatomic) NSString* picture;

@property (readwrite, strong, nonatomic) FLFacebookPrivacy* privacy;

@property (readwrite, strong, nonatomic) NSMutableArray* properties;
/// Type: FLFacebookProperty*, forKey: property

@property (readwrite, strong, nonatomic) NSString* source;

@property (readwrite, strong, nonatomic) FLFacebookNamedObjectList* to;

@property (readwrite, strong, nonatomic) NSString* type;

@property (readwrite, strong, nonatomic) NSDate* updated_time;

+ (NSString*) actionsKey;

+ (NSString*) applicationKey;

+ (NSString*) captionKey;

+ (NSString*) commentsKey;

+ (NSString*) created_timeKey;

+ (NSString*) descriptionKey;

+ (NSString*) fromKey;

+ (NSString*) iconKey;

+ (NSString*) likesKey;

+ (NSString*) linkKey;

+ (NSString*) messageKey;

+ (NSString*) object_idKey;

+ (NSString*) pictureKey;

+ (NSString*) privacyKey;

+ (NSString*) propertiesKey;

+ (NSString*) sourceKey;

+ (NSString*) toKey;

+ (NSString*) typeKey;

+ (NSString*) updated_timeKey;

+ (FLFacebookPost*) facebookPost; 

@end

@interface FLFacebookPost (ValueProperties) 
@end

// [/Generated]
