// 
// FLFacebookEmailObject.m
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
#import "FLFacebookEmailObject.h"
@implementation FLFacebookEmailObject
@synthesize email = _email;
+(FLFacebookEmailObject) emailObject {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_email release];
    [super dealloc];
}
#endif
@end
