// 
// ZFCreateQuickBlogPost.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/30/13 6:24 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLModelObject.h"
@class FLObjectDescriber;
@interface ZFCreateQuickBlogPost : FLModelObject {
@private
    NSMutableArray* _keywords;
    long _photoId;
    NSDate* _publishDate;
    NSString* _url;
    NSString* _title;
    NSString* _caption;
}

@property (readwrite, strong, nonatomic) NSMutableArray* keywords;
@property (readwrite, assign, nonatomic) long photoId;
@property (readwrite, strong, nonatomic) NSDate* publishDate;
@property (readwrite, strong, nonatomic) NSString* url;
@property (readwrite, strong, nonatomic) NSString* title;
@property (readwrite, strong, nonatomic) NSString* caption;
+ (ZFCreateQuickBlogPost*) createQuickBlogPost;
@end
