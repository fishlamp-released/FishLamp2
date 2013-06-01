// 
// ZFUpdatePhotoSet.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/31/13 7:38 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLModelObject.h"
@class ZFPhotoSetUpdater;
@interface ZFUpdatePhotoSet : FLModelObject {
@private
    ZFPhotoSetUpdater* _updater;
    long _photoSetId;
}

@property (readwrite, strong, nonatomic) ZFPhotoSetUpdater* updater;
@property (readwrite, assign, nonatomic) long photoSetId;
+ (ZFUpdatePhotoSet*) updatePhotoSet;
@end
