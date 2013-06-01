// 
// ZFUpdatePhotoSetResponse.m
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

#import "ZFUpdatePhotoSetResponse.h"
#import "FLModelObject.h"
#import "ZFPhotoSet.h"
@implementation ZFUpdatePhotoSetResponse
@synthesize updatePhotoSetResult = _updatePhotoSetResult;
+ (ZFUpdatePhotoSetResponse*) updatePhotoSetResponse {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [_updatePhotoSetResult release];
    [super dealloc];
}
#endif
@end
