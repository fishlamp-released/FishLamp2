// 
// ZFGetDownloadOriginalKey.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/2/13 4:12 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 


#import "FLObjectDescriber.h"
#import "FLModelObject.h"
#import "ZFGetDownloadOriginalKey.h"

@implementation ZFGetDownloadOriginalKey

#if FL_MRC
- (void) dealloc {
    [_photoIds release];
    [_password release];
    [super dealloc];
}
#endif
+ (void) didRegisterObjectDescriber:(FLObjectDescriber*) describer {
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"long" propertyClass:[NSNumber class]] forContainerProperty:@"photoIds"];
}
+ (ZFGetDownloadOriginalKey*) getDownloadOriginalKey {
    return FLAutorelease([[[self class] alloc] init]);
}
@synthesize password = _password;
@synthesize photoIds = _photoIds;

@end
