// 
// FLFacebookWorkHistory.m
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
#import "FLFacebookWorkHistory.h"
#import "FLFacebookNamedObject.h"
@implementation FLFacebookWorkHistory
@synthesize employer = _employer;
@synthesize start_date = _start_date;
@synthesize end_date = _end_date;
@synthesize position = _position;
@synthesize location = _location;
+(FLFacebookWorkHistory) workHistory {
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