// 
// FLImportedTestObjectGenerated.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/5/13 8:14 PM with PackMule (3.0.0.29)
// 
// Project: FishLamp
// Schema: FLTestObjects
// 
// Organization: GreenTongue Software, LLC (http://www.greentongue.com)
// Copyright 2013 (c) GreenTongue Software, LLC
// Individual licensees only.
// 


#import "FLImportedTestObjectGenerated.h"
#import "FLModelObject.h"

@implementation FLImportedTestObjectGenerated

@synthesize chloe = _chloe;
#if FL_MRC
- (void) dealloc {
    [_teddy release];
    [_chloe release];
    [_sanjo release];
    [super dealloc];
}
#endif
+ (FLImportedTestObjectGenerated*) importedTestObjectGenerated {
    return FLAutorelease([[[self class] alloc] init]);
}
@synthesize sanjo = _sanjo;
@synthesize teddy = _teddy;

@end