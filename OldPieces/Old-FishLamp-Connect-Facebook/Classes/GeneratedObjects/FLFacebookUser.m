// 
// FLFacebookUser.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/28/13 2:04 PM with PackMule (3.0.0.1)
// 
// Project: FishLamp Connect
// Schema: FishLampFacebook
// 
// Copyright 2013 (c) GreenTongue Software, LLC
// 

#import "FLFacebookUser.h"
#import "FLFacebookNamedObject.h"
#import "FLObjectDescriber.h"
#import "FLFacebookWorkHistory.h"
@implementation FLFacebookUser
@synthesize third_party_id = _third_party_id;
@synthesize location = _location;
@synthesize birthday = _birthday;
@synthesize education = _education;
@synthesize link = _link;
@synthesize hometown = _hometown;
@synthesize religion = _religion;
@synthesize work = _work;
@synthesize significant_other = _significant_other;
@synthesize relationship_status = _relationship_status;
@synthesize bio = _bio;
@synthesize locale = _locale;
@synthesize last_name = _last_name;
@synthesize verified = _verified;
@synthesize quotes = _quotes;
@synthesize gender = _gender;
@synthesize website = _website;
@synthesize about = _about;
@synthesize timezone = _timezone;
@synthesize political = _political;
@synthesize interested_in = _interested_in;
@synthesize updated_time = _updated_time;
@synthesize first_name = _first_name;
@synthesize username = _username;
+(void) didRegisterObjectDescriber:(FLObjectDescriber*) describer {
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"work_history" propertyClass:[FLFacebookWorkHistory class]] forContainerProperty:@"work"];
}
+(FLFacebookUser*) facebookUser {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_third_party_id release];
    [_location release];
    [_birthday release];
    [_education release];
    [_link release];
    [_hometown release];
    [_religion release];
    [_work release];
    [_significant_other release];
    [_relationship_status release];
    [_bio release];
    [_locale release];
    [_last_name release];
    [_quotes release];
    [_gender release];
    [_website release];
    [_about release];
    [_political release];
    [_interested_in release];
    [_updated_time release];
    [_first_name release];
    [_username release];
    [super dealloc];
}
#endif
@end
