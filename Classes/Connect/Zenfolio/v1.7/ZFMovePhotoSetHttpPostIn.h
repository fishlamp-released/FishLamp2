// 
// ZFMovePhotoSetHttpPostIn.h
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
@interface ZFMovePhotoSetHttpPostIn : FLModelObject {
@private
    NSString* _destGroupId;
    NSString* _photoSetId;
    NSString* _index;
}

@property (readwrite, strong, nonatomic) NSString* destGroupId;
@property (readwrite, strong, nonatomic) NSString* photoSetId;
@property (readwrite, strong, nonatomic) NSString* index;
+ (ZFMovePhotoSetHttpPostIn*) movePhotoSetHttpPostIn;
@end
