// 
// ZFCreateFavoritesSet.m
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

#import "ZFCreateFavoritesSet.h"
#import "FLModelObject.h"
#import "FLObjectDescriber.h"
@implementation ZFCreateFavoritesSet
@synthesize name = _name;
@synthesize photographerLogin = _photographerLogin;
@synthesize photoIds = _photoIds;
+ (void) didRegisterObjectDescriber:(FLObjectDescriber*) describer {
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"long" propertyClass:[NSNumber class]] forContainerProperty:@"photoIds"];
}
+ (ZFCreateFavoritesSet*) createFavoritesSet {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [_name release];
    [_photographerLogin release];
    [_photoIds release];
    [super dealloc];
}
#endif
@end