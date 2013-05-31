// 
// ZFSetPhotoSetTitlePhoto.h
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
@interface ZFSetPhotoSetTitlePhoto : FLModelObject {
@private
    long _photoId;
    long _photoSetId;
}

@property (readwrite, assign, nonatomic) long photoId;
@property (readwrite, assign, nonatomic) long photoSetId;
+ (ZFSetPhotoSetTitlePhoto*) setPhotoSetTitlePhoto;
@end
