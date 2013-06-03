// 
// ZFCreatePhotoSetResponse.m
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


#import "ZFPhotoSet.h"
#import "FLModelObject.h"
#import "ZFCreatePhotoSetResponse.h"

@implementation ZFCreatePhotoSetResponse

+ (ZFCreatePhotoSetResponse*) createPhotoSetResponse {
    return FLAutorelease([[[self class] alloc] init]);
}
@synthesize createPhotoSetResult = _createPhotoSetResult;
#if FL_MRC
- (void) dealloc {
    [_createPhotoSetResult release];
    [super dealloc];
}
#endif

@end
