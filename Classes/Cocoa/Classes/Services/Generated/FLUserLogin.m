// 
// FLUserLogin.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// 
// Project: FishLamp
// Schema: FLSessionObjects
// 
// Generated by: Mike Fullerton @ 5/25/13 11:04 AM with PackMule (3.0.0.1)
// 
// Organization: GreenTongue Software LLC, Mike Fullerton
// 
// License: The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 
// Copywrite (C) 2013 GreenTongue Software LLC, Mike Fullerton. All rights reserved.
// 
#import "FLUserLogin.h"
#import "FLModelObject.h"
@implementation FLUserLogin
@synthesize password = _password;
@synthesize isAuthenticated = _isAuthenticated;
@synthesize userName = _userName;
@synthesize authTokenLastUpdateTime = _authTokenLastUpdateTime;
@synthesize authToken = _authToken;
@synthesize userGuid = _userGuid;
@synthesize email = _email;
@synthesize userInfo = _userInfo;
+(FLUserLogin*) userLogin {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_password release];
    [_userName release];
    [_authToken release];
    [_userGuid release];
    [_email release];
    [_userInfo release];
    [super dealloc];
}
#endif
@end
