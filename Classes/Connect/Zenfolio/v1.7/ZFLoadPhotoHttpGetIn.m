// 
// ZFLoadPhotoHttpGetIn.m
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

#import "ZFLoadPhotoHttpGetIn.h"
#import "FLModelObject.h"
@implementation ZFLoadPhotoHttpGetIn
@synthesize photoId = _photoId;
@synthesize level = _level;
+ (ZFLoadPhotoHttpGetIn*) loadPhotoHttpGetIn {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [_photoId release];
    [_level release];
    [super dealloc];
}
#endif
@end
