// 
// ZFSetPhotoSetTitlePhotoHttpGetIn.h
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
@interface ZFSetPhotoSetTitlePhotoHttpGetIn : FLModelObject {
@private
    NSString* _photoId;
    NSString* _photoSetId;
}

@property (readwrite, strong, nonatomic) NSString* photoId;
@property (readwrite, strong, nonatomic) NSString* photoSetId;
+ (ZFSetPhotoSetTitlePhotoHttpGetIn*) setPhotoSetTitlePhotoHttpGetIn;
@end
