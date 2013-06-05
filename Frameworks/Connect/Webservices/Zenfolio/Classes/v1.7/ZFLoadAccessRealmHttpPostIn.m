// 
// ZFLoadAccessRealmHttpPostIn.m
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


#import "ZFLoadAccessRealmHttpPostIn.h"
#import "FLModelObject.h"

@implementation ZFLoadAccessRealmHttpPostIn

#if FL_MRC
- (void) dealloc {
    [_realmId release];
    [super dealloc];
}
#endif
+ (ZFLoadAccessRealmHttpPostIn*) loadAccessRealmHttpPostIn {
    return FLAutorelease([[[self class] alloc] init]);
}
@synthesize realmId = _realmId;

@end