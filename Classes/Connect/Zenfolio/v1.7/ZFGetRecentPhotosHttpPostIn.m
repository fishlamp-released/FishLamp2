// 
// ZFGetRecentPhotosHttpPostIn.m
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

#import "ZFGetRecentPhotosHttpPostIn.h"
#import "FLModelObject.h"
@implementation ZFGetRecentPhotosHttpPostIn
@synthesize limit = _limit;
@synthesize offset = _offset;
+(ZFGetRecentPhotosHttpPostIn*) getRecentPhotosHttpPostIn {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_limit release];
    [_offset release];
    [super dealloc];
}
#endif
@end
