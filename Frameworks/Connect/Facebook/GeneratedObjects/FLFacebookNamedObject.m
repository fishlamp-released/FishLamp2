// 
// FLFacebookNamedObject.m
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
#import "FLFacebookNamedObject.h"
@implementation FLFacebookNamedObject
@synthesize name = _name;
+(FLFacebookNamedObject) namedObject {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_name release];
    [super dealloc];
}
#endif
@end
