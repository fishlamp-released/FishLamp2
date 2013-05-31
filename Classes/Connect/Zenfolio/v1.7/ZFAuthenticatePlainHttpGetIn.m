// 
// ZFAuthenticatePlainHttpGetIn.m
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

#import "ZFAuthenticatePlainHttpGetIn.h"
#import "FLModelObject.h"
@implementation ZFAuthenticatePlainHttpGetIn
@synthesize loginName = _loginName;
@synthesize password = _password;
+ (ZFAuthenticatePlainHttpGetIn*) authenticatePlainHttpGetIn {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [_loginName release];
    [_password release];
    [super dealloc];
}
#endif
@end