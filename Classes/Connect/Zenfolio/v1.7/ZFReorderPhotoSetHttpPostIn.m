// 
// ZFReorderPhotoSetHttpPostIn.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/30/13 4:42 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "ZFReorderPhotoSetHttpPostIn.h"
#import "FLModelObject.h"
@implementation ZFReorderPhotoSetHttpPostIn
@synthesize shiftOrder = _shiftOrder;
@synthesize photoSetId = _photoSetId;
+(ZFReorderPhotoSetHttpPostIn*) reorderPhotoSetHttpPostIn {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_shiftOrder release];
    [_photoSetId release];
    [super dealloc];
}
#endif
@end
