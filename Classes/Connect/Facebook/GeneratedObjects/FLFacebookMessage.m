// 
// FLFacebookMessage.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/28/13 2:04 PM with PackMule (3.0.0.1)
// 
// Project: FishLamp Connect
// Schema: FishLampFacebook
// 
// Copyright 2013 (c) GreenTongue Software, LLC
// 

#import "FLFacebookMessage.h"
#import "FLFacebookObject.h"
#import "FLFacebookEmailObject.h"
@implementation FLFacebookMessage
@synthesize message = _message;
@synthesize to = _to;
@synthesize created_time = _created_time;
@synthesize from = _from;
+(FLFacebookMessage*) facebookMessage {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_message release];
    [_to release];
    [_created_time release];
    [_from release];
    [super dealloc];
}
#endif
@end