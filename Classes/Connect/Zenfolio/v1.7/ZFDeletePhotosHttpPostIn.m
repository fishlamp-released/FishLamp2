// 
// ZFDeletePhotosHttpPostIn.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/31/13 7:38 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "ZFDeletePhotosHttpPostIn.h"
#import "FLModelObject.h"
#import "FLObjectDescriber.h"
@implementation ZFDeletePhotosHttpPostIn
@synthesize photoIds = _photoIds;
+ (void) didRegisterObjectDescriber:(FLObjectDescriber*) describer {
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"String" propertyClass:[NSString class]] forContainerProperty:@"photoIds"];
}
+ (ZFDeletePhotosHttpPostIn*) deletePhotosHttpPostIn {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [_photoIds release];
    [super dealloc];
}
#endif
@end
