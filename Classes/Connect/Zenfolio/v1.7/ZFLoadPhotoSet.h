// 
// ZFLoadPhotoSet.h
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
@interface ZFLoadPhotoSet : FLModelObject {
@private
    NSString* _level;
    long _photoSetId;
    BOOL _includePhotos;
}

@property (readwrite, strong, nonatomic) NSString* level;
@property (readwrite, assign, nonatomic) long photoSetId;
@property (readwrite, assign, nonatomic) BOOL includePhotos;
+ (ZFLoadPhotoSet*) loadPhotoSet;
@end
