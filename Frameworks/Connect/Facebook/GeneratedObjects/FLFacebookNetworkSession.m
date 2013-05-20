// 
// FLFacebookNetworkSession.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// 
// Project: FishLamp Connect
// Schema: FishLampFacebook
// 
// Generated by: Mike Fullerton @ 5/12/13 8:01 PM with PackMule (3.0.0.1)
// 
// Organization: GreenTongue Software, LLC
// 
// Copywrite (C) 2013 GreenTongue Software, LLC. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
// 
#import "FLFacebookNetworkSession.h"
@implementation FLFacebookNetworkSession
@synthesize appId = _appId;
@synthesize expiration_date = _expiration_date;
@synthesize permissions = _permissions;
@synthesize userId = _userId;
@synthesize access_token = _access_token;
+(FLFacebookNetworkSession) networkSession {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_appId release];
    [_expiration_date release];
    [_permissions release];
    [_userId release];
    [_access_token release];
    [super dealloc];
}
#endif
@end
