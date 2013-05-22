// 
// FLFacebookNote.m
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
#import "FLFacebookNote.h"
#import "FLFacebookNamedObject.h"
@implementation FLFacebookNote
@synthesize updated_time = _updated_time;
@synthesize message = _message;
@synthesize subject = _subject;
@synthesize icon = _icon;
@synthesize created_time = _created_time;
@synthesize from = _from;
+(FLFacebookNote) note {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_updated_time release];
    [_message release];
    [_subject release];
    [_icon release];
    [_created_time release];
    [_from release];
    [super dealloc];
}
#endif
@end