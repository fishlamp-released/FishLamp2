// 
// FLFacebookPost.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// 
// Project: FishLamp Connect
// Schema: FishLampFacebook
// 
// Generated by: Mike Fullerton @ 5/12/13 8:01 PM with PackMule (3.0.0.1)
// 
// Organization: GreenTongue Software, LLC
// 
// Copywrite (C) 2013 GreenTongue Software, LLC. All rights reserved.
// 
#import "FLModelObject.h"
@class FLFacebookCommentList
@class FLFacebookNamedObject
@class FLFacebookNamedObjectList
@class FLFacebookPrivacy
@interface FLFacebookPost : FLModelObject {
@private
    NSString* _description;
    FLFacebookCommentList* _comments;
    NSString* _caption;
    NSString* _message;
    NSMutableArray* _actions;
    NSDate* _created_time;
    NSString* _picture;
    FLFacebookNamedObject* _from;
    FLFacebookNamedObject* _application;
    NSString* _source;
    NSString* _link;
    FLFacebookNamedObjectList* _likes;
    NSString* _type;
    NSString* _icon;
    NSDate* _updated_time;
    NSMutableArray* _properties;
    NSString* _object_id;
    FLFacebookPrivacy* _privacy;
    FLFacebookNamedObjectList* _to;
}

@property (readwrite, strong, nonatomic) NSString* description;
@property (readwrite, strong, nonatomic) FLFacebookCommentList* comments;
@property (readwrite, strong, nonatomic) NSString* caption;
@property (readwrite, strong, nonatomic) NSString* message;
@property (readwrite, strong, nonatomic) NSMutableArray* actions;
@property (readwrite, strong, nonatomic) NSDate* created_time;
@property (readwrite, strong, nonatomic) NSString* picture;
@property (readwrite, strong, nonatomic) FLFacebookNamedObject* from;
@property (readwrite, strong, nonatomic) FLFacebookNamedObject* application;
@property (readwrite, strong, nonatomic) NSString* source;
@property (readwrite, strong, nonatomic) NSString* link;
@property (readwrite, strong, nonatomic) FLFacebookNamedObjectList* likes;
@property (readwrite, strong, nonatomic) NSString* type;
@property (readwrite, strong, nonatomic) NSString* icon;
@property (readwrite, strong, nonatomic) NSDate* updated_time;
@property (readwrite, strong, nonatomic) NSMutableArray* properties;
@property (readwrite, strong, nonatomic) NSString* object_id;
@property (readwrite, strong, nonatomic) FLFacebookPrivacy* privacy;
@property (readwrite, strong, nonatomic) FLFacebookNamedObjectList* to;
+(FLFacebookPost) post;
@end
