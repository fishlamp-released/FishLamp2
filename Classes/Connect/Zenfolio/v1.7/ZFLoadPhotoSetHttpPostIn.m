// 
// ZFLoadPhotoSetHttpPostIn.m
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

#import "ZFLoadPhotoSetHttpPostIn.h"
#import "FLModelObject.h"
@implementation ZFLoadPhotoSetHttpPostIn
@synthesize level = _level;
@synthesize photoSetId = _photoSetId;
@synthesize includePhotos = _includePhotos;
+ (ZFLoadPhotoSetHttpPostIn*) loadPhotoSetHttpPostIn {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [_level release];
    [_photoSetId release];
    [_includePhotos release];
    [super dealloc];
}
#endif
@end
