// 
// ZFRotatePhoto.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/3/13 12:06 PM with PackMule (3.0.0.20)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 


#import "ZFPhotoRotation.h"
#import "ZFRotatePhoto.h"
#import "FLModelObject.h"

@implementation ZFRotatePhoto

#if FL_MRC
- (void) dealloc {
    [_rotation release];
    [super dealloc];
}
#endif
@synthesize photoId = _photoId;
+ (ZFRotatePhoto*) rotatePhoto {
    return FLAutorelease([[[self class] alloc] init]);
}
@synthesize rotation = _rotation;
- (ZFPhotoRotation) rotationEnum {
    return ZFPhotoRotationEnumFromString(self.rotation);
}
- (void) setRotationEnum:(ZFPhotoRotation) value {
    self.rotation = ZFPhotoRotationStringFromEnum(value);
}
- (ZFPhotoRotationEnumSet*) rotationEnumSet {
    return [ZFPhotoRotationEnumSet enumSet:self.rotation];;
}
- (void) setRotationEnumSet:(ZFPhotoRotationEnumSet*) value {
    self.rotation = value.concatenatedString;
}

@end