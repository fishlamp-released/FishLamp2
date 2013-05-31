// 
// ZFMoveGroupHttpPostIn.m
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

#import "ZFMoveGroupHttpPostIn.h"
#import "FLModelObject.h"
@implementation ZFMoveGroupHttpPostIn
@synthesize groupId = _groupId;
@synthesize destGroupId = _destGroupId;
@synthesize index = _index;
+ (ZFMoveGroupHttpPostIn*) moveGroupHttpPostIn {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [_groupId release];
    [_destGroupId release];
    [_index release];
    [super dealloc];
}
#endif
@end
