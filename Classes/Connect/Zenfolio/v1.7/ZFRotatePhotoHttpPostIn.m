// 
// ZFRotatePhotoHttpPostIn.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/2/13 4:12 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 


#import "ZFRotatePhotoHttpPostIn.h"
#import "FLModelObject.h"

@implementation ZFRotatePhotoHttpPostIn

#if FL_MRC
- (void) dealloc {
    [_photoId release];
    [_rotation release];
    [super dealloc];
}
#endif
@synthesize photoId = _photoId;
+ (ZFRotatePhotoHttpPostIn*) rotatePhotoHttpPostIn {
    return FLAutorelease([[[self class] alloc] init]);
}
@synthesize rotation = _rotation;

@end
