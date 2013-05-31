// [Generated]
//
// This file was generated at 7/9/12 1:47 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeCodeLicense.m
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCodeCodeLicense.h"

@implementation FLCodeCodeLicense


@synthesize licenseName = __licenseName;
@synthesize licenseShortDescription = __licenseShortDescription;
@synthesize licenseTextFilePath = __licenseTextFilePath;


+ (FLCodeCodeLicense*) codeLicense
{
    return FLAutorelease([[FLCodeCodeLicense alloc] init]);
}

- (NSUInteger) hash
{
    return [[self licenseName] hash];
}

- (BOOL) isEqual:(id) object
{
    return [object isKindOfClass:[self class]] && [[object licenseName] isEqual:[self licenseName]];
}



@end

