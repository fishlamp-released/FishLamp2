// 
// ZFCheckPrivilegeHttpPostIn.m
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


#import "ZFCheckPrivilegeHttpPostIn.h"
#import "FLModelObject.h"

@implementation ZFCheckPrivilegeHttpPostIn

+ (ZFCheckPrivilegeHttpPostIn*) checkPrivilegeHttpPostIn {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [_loginName release];
    [_privilegeName release];
    [super dealloc];
}
#endif
@synthesize loginName = _loginName;
@synthesize privilegeName = _privilegeName;

@end
