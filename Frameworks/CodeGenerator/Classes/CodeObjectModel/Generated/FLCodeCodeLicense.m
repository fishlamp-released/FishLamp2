// 
// FLCodeCodeLicense.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/14/13 2:45 PM with PackMule (3.0.0.29)
// 
// Project: ObjectModel
// Schema: ObjectModel
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 


#import "FLCodeCodeLicense.h"
#import "FLModelObject.h"

@implementation FLCodeCodeLicense

+ (FLCodeCodeLicense*) codeCodeLicense {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [_licenseName release];
    [_licenseTextFilePath release];
    [_licenseShortDescription release];
    [super dealloc];
}
#endif
@synthesize licenseName = _licenseName;
@synthesize licenseShortDescription = _licenseShortDescription;
@synthesize licenseTextFilePath = _licenseTextFilePath;

@end
