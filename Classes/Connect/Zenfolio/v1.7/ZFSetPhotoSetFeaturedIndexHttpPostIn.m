// 
// ZFSetPhotoSetFeaturedIndexHttpPostIn.m
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

#import "ZFSetPhotoSetFeaturedIndexHttpPostIn.h"
#import "FLModelObject.h"
@implementation ZFSetPhotoSetFeaturedIndexHttpPostIn
@synthesize index = _index;
@synthesize photoSetId = _photoSetId;
+ (ZFSetPhotoSetFeaturedIndexHttpPostIn*) setPhotoSetFeaturedIndexHttpPostIn {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [_index release];
    [_photoSetId release];
    [super dealloc];
}
#endif
@end