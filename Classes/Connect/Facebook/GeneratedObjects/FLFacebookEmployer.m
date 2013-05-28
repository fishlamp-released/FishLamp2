// 
// FLFacebookEmployer.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/28/13 2:04 PM with PackMule (3.0.0.1)
// 
// Project: FishLamp Connect
// Schema: FishLampFacebook
// 
// Copyright 2013 (c) GreenTongue Software, LLC
// 

#import "FLFacebookEmployer.h"
#import "FLFacebookNamedObject.h"
@implementation FLFacebookEmployer
@synthesize employer = _employer;
@synthesize start_date = _start_date;
@synthesize end_date = _end_date;
@synthesize position = _position;
@synthesize location = _location;
+(FLFacebookEmployer*) facebookEmployer {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_employer release];
    [_start_date release];
    [_end_date release];
    [_position release];
    [_location release];
    [super dealloc];
}
#endif
@end
