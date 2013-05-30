// 
// ZFAddress.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/30/13 2:36 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "ZFAddress.h"
#import "FLModelObject.h"
@implementation ZFAddress
@synthesize state = _state;
@synthesize other = _other;
@synthesize phone = _phone;
@synthesize zip = _zip;
@synthesize lastName = _lastName;
@synthesize street2 = _street2;
@synthesize street = _street;
@synthesize firstName = _firstName;
@synthesize url = _url;
@synthesize fax = _fax;
@synthesize city = _city;
@synthesize phone2 = _phone2;
@synthesize companyName = _companyName;
@synthesize country = _country;
@synthesize email = _email;
+(ZFAddress*) address {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_state release];
    [_other release];
    [_phone release];
    [_zip release];
    [_lastName release];
    [_street2 release];
    [_street release];
    [_firstName release];
    [_url release];
    [_fax release];
    [_city release];
    [_phone2 release];
    [_companyName release];
    [_country release];
    [_email release];
    [super dealloc];
}
#endif
@end
