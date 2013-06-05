// 
// ZFMovePhotoSet.m
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


#import "ZFMovePhotoSet.h"
#import "FLModelObject.h"

@implementation ZFMovePhotoSet

#if FL_MRC
- (void) dealloc {
    [super dealloc];
}
#endif
@synthesize destGroupId = _destGroupId;
@synthesize index = _index;
+ (ZFMovePhotoSet*) movePhotoSet {
    return FLAutorelease([[[self class] alloc] init]);
}
@synthesize photoSetId = _photoSetId;

@end