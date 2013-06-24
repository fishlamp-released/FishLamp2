// 
// FLImportedTestObjectBaseClass.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/19/13 4:22 PM with PackMule (3.0.0.29)
// 
// Project: FishLamp
// 
// Organization: GreenTongue Software, LLC (http://www.greentongue.com)
// Copyright 2013 (c) GreenTongue Software, LLC
// Individual licensees only
// 

#import "FLImportedTestObjectBaseClass.h"
#import "FLModelObject.h"

@implementation FLImportedTestObjectBaseClass

@synthesize chloe = _chloe;
#if FL_MRC
- (void) dealloc {
    [_teddy release];
    [_chloe release];
    [_sanjo release];
    [super dealloc];
}
#endif
+ (id) importedTestObject {
    return FLAutorelease([[[self class] alloc] init]);
}
@synthesize sanjo = _sanjo;
@synthesize teddy = _teddy;

@end