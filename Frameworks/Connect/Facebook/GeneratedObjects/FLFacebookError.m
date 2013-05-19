// 
// FLFacebookError.m
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
#import "FLFacebookError.h"
@implementation FLFacebookError
@synthesize error_reason = _error_reason;
@synthesize error_description = _error_description;
@synthesize externalUrl = _externalUrl;
@synthesize error = _error;
+(FLFacebookError) error {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_error_reason release];
    [_error_description release];
    [_externalUrl release];
    [_error release];
    [super dealloc];
}
#endif
@end
