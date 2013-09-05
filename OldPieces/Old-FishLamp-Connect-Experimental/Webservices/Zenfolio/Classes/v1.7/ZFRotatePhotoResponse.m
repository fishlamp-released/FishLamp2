// 
// ZFRotatePhotoResponse.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/3/13 10:43 AM with PackMule (3.0.1.100)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 


#import "ZFPhoto.h"
#import "ZFRotatePhotoResponse.h"
#import "FLModelObject.h"

@implementation ZFRotatePhotoResponse

#if FL_MRC
- (void) dealloc {
    [_rotatePhotoResult release];
    [super dealloc];
}
#endif
+ (ZFRotatePhotoResponse*) rotatePhotoResponse {
    return FLAutorelease([[[self class] alloc] init]);
}
@synthesize rotatePhotoResult = _rotatePhotoResult;

@end
