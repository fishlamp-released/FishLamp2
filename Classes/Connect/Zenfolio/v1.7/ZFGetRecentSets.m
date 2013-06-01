// 
// ZFGetRecentSets.m
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

#import "ZFGetRecentSets.h"
#import "ZFPhotoSetType.h"
#import "FLModelObject.h"
#import "ZFPhotoSetType.h"
#import "ZFPhotoSetType.h"
@implementation ZFGetRecentSets
@synthesize typeEnum = (null);
@synthesize typeEnumSet = (null);
@synthesize offset = _offset;
@synthesize type = _type;
@synthesize limit = _limit;
+ (ZFGetRecentSets*) getRecentSets {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [super dealloc];
}
#endif
@end
