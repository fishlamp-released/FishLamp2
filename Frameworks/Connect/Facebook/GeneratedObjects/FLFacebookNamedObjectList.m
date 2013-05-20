// 
// FLFacebookNamedObjectList.m
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
#import "FLFacebookNamedObjectList.h"
@implementation FLFacebookNamedObjectList
@synthesize count = _count;
@synthesize data = _data;
+(FLFacebookNamedObjectList) namedObjectList {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_data release];
    [super dealloc];
}
#endif
@end
