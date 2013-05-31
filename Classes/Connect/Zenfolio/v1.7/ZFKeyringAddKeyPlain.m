// 
// ZFKeyringAddKeyPlain.m
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

#import "ZFKeyringAddKeyPlain.h"
#import "FLModelObject.h"
@implementation ZFKeyringAddKeyPlain
@synthesize keyring = _keyring;
@synthesize realmId = _realmId;
@synthesize password = _password;
+ (ZFKeyringAddKeyPlain*) keyringAddKeyPlain {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [_keyring release];
    [_password release];
    [super dealloc];
}
#endif
@end