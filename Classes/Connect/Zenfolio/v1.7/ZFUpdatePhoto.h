// 
// ZFUpdatePhoto.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/30/13 2:36 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLModelObject.h"
@class ZFPhotoUpdater;
@interface ZFUpdatePhoto : FLModelObject {
@private
    long _photoId;
    ZFPhotoUpdater* _updater;
}

@property (readwrite, assign, nonatomic) long photoId;
@property (readwrite, strong, nonatomic) ZFPhotoUpdater* updater;
+(ZFUpdatePhoto*) updatePhoto;
@end
