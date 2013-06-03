// 
// ZFUpdatePhotoSetAccess.m
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


#import "ZFAccessUpdater.h"
#import "FLModelObject.h"
#import "ZFUpdatePhotoSetAccess.h"

@implementation ZFUpdatePhotoSetAccess

#if FL_MRC
- (void) dealloc {
    [_updater release];
    [super dealloc];
}
#endif
@synthesize photoSetId = _photoSetId;
+ (ZFUpdatePhotoSetAccess*) updatePhotoSetAccess {
    return FLAutorelease([[[self class] alloc] init]);
}
@synthesize updater = _updater;

@end
