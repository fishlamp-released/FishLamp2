// 
// ZFCreatePhotoSet.h
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
@class ZFPhotoSetUpdater;
@interface ZFCreatePhotoSet : FLModelObject {
@private
    long _groupId;
    NSString* _type;
    ZFPhotoSetUpdater* _updater;
}

@property (readwrite, assign, nonatomic) long groupId;
@property (readwrite, strong, nonatomic) NSString* type;
@property (readwrite, strong, nonatomic) ZFPhotoSetUpdater* updater;
+ (ZFCreatePhotoSet*) createPhotoSet;
@end