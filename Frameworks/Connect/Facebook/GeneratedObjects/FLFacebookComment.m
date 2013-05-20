// 
// FLFacebookComment.m
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
#import "FLFacebookComment.h"
#import "FLFacebookNamedObject.h"
@implementation FLFacebookComment
@synthesize message = _message;
@synthesize likes = _likes;
@synthesize created_time = _created_time;
@synthesize from = _from;
+(FLFacebookComment) comment {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_message release];
    [_created_time release];
    [_from release];
    [super dealloc];
}
#endif
@end
