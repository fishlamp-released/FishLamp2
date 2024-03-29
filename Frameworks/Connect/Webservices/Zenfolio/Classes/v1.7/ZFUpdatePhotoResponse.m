// 
// ZFUpdatePhotoResponse.m
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


#import "ZFUpdatePhotoResponse.h"
#import "FLModelObject.h"
#import "ZFPhoto.h"

@implementation ZFUpdatePhotoResponse

#if FL_MRC
- (void) dealloc {
    [_updatePhotoResult release];
    [super dealloc];
}
#endif
+ (ZFUpdatePhotoResponse*) updatePhotoResponse {
    return FLAutorelease([[[self class] alloc] init]);
}
@synthesize updatePhotoResult = _updatePhotoResult;

@end
