// 
// ZFRotatePhoto.h
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
#import "ZFPhotoRotation.h"
@class ZFPhotoRotationEnumSet;
#import "ZFPhotoRotation.h"
@interface ZFRotatePhoto : FLModelObject {
@private
    long _photoId;
    NSString* _rotation;
}

@property (readwrite, strong, nonatomic) ZFPhotoRotationEnumSet* rotationEnumSet;
@property (readwrite, assign, nonatomic) long photoId;
@property (readwrite, assign, nonatomic) ZFPhotoRotation rotationEnum;
@property (readwrite, assign, nonatomic) NSString* rotation;
+ (ZFRotatePhoto*) rotatePhoto;
@end
