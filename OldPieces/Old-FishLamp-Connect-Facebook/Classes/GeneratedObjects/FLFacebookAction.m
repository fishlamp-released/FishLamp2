// 
// FLFacebookAction.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/28/13 2:04 PM with PackMule (3.0.0.1)
// 
// Project: FishLamp Connect
// Schema: FishLampFacebook
// 
// Copyright 2013 (c) GreenTongue Software, LLC
// 

#import "FLFacebookAction.h"
#import "FLModelObject.h"
@implementation FLFacebookAction
@synthesize link = _link;
@synthesize name = _name;
+(FLFacebookAction*) facebookAction {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_link release];
    [_name release];
    [super dealloc];
}
#endif
@end
