// 
// ZFCreateVideoFromUrlHttpPostIn.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/30/13 4:42 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLModelObject.h"
@interface ZFCreateVideoFromUrlHttpPostIn : FLModelObject {
@private
    NSString* _url;
    NSString* _galleryId;
    NSString* _cookies;
}

@property (readwrite, strong, nonatomic) NSString* url;
@property (readwrite, strong, nonatomic) NSString* galleryId;
@property (readwrite, strong, nonatomic) NSString* cookies;
+(ZFCreateVideoFromUrlHttpPostIn*) createVideoFromUrlHttpPostIn;
@end
