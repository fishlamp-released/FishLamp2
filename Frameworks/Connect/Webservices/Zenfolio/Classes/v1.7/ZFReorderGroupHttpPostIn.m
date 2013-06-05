// 
// ZFReorderGroupHttpPostIn.m
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


#import "FLModelObject.h"
#import "ZFReorderGroupHttpPostIn.h"

@implementation ZFReorderGroupHttpPostIn

#if FL_MRC
- (void) dealloc {
    [_groupId release];
    [_shiftOrder release];
    [super dealloc];
}
#endif
@synthesize groupId = _groupId;
+ (ZFReorderGroupHttpPostIn*) reorderGroupHttpPostIn {
    return FLAutorelease([[[self class] alloc] init]);
}
@synthesize shiftOrder = _shiftOrder;

@end