// 
// FLFacebookPrivacy.m
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
// Copywrite (C) 2013 GreenTongue Software, LLC. All rights reserved.
// 
#import "FLFacebookPrivacy.h"
@implementation FLFacebookPrivacy
@synthesize value = _value;
@synthesize friends = _friends;
@synthesize networks = _networks;
@synthesize deny = _deny;
@synthesize description = _description;
+(FLFacebookPrivacy) privacy {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_value release];
    [_friends release];
    [_networks release];
    [_deny release];
    [_description release];
    [super dealloc];
}
#endif
@end
