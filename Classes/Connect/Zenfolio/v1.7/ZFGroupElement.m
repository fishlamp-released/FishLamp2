// 
// ZFGroupElement.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/30/13 6:24 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "ZFGroupElement.h"
#import "ZFAccessDescriptor.h"
#import "FLModelObject.h"
@implementation ZFGroupElement
@synthesize hideBranding = _hideBranding;
@synthesize id = _id;
@synthesize title = _title;
@synthesize groupIndex = _groupIndex;
@synthesize owner = _owner;
@synthesize accessDescriptor = _accessDescriptor;
+ (ZFGroupElement*) groupElement {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [_title release];
    [_owner release];
    [_accessDescriptor release];
    [super dealloc];
}
#endif
@end
