// 
// ZFCreateVideoFromUrl.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/2/13 4:12 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLModelObject.h"


@interface ZFCreateVideoFromUrl : FLModelObject {
@private
    NSString* _url;
    long _galleryId;
    NSString* _cookies;
}

@property (readwrite, strong, nonatomic) NSString* cookies;
@property (readwrite, assign, nonatomic) long galleryId;
@property (readwrite, strong, nonatomic) NSString* url;

+ (ZFCreateVideoFromUrl*) createVideoFromUrl;

@end
