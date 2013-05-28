// [Generated]
//
// This file was generated at 7/9/12 1:47 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeCompany.m
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCodeCompany.h"

@implementation FLCodeCompany


@synthesize address1 = __address1;
@synthesize address2 = __address2;
@synthesize address3 = __address3;
@synthesize name = __name;
@synthesize phone = __phone;
@synthesize website = __website;

+ (FLCodeCompany*) company
{
    return FLAutorelease([[FLCodeCompany alloc] init]);
}


- (void) dealloc
{
    FLRelease(__name);
    FLRelease(__website);
    FLRelease(__address1);
    FLRelease(__address2);
    FLRelease(__address3);
    FLRelease(__phone);
    FLSuperDealloc();
}

@end



// [/Generated]
