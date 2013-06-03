// 
// ZFCreateFavoritesSet.m
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
#import "ZFCreateFavoritesSet.h"

@implementation ZFCreateFavoritesSet

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
+ (void) didRegisterObjectDescriber:(FLObjectDescriber*) describer {
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"long" propertyClass:[NSNumber class]] forContainerProperty:@"photoIds"];
}
@synthesize name = _name;
@synthesize photoIds = _photoIds;
@synthesize photographerLogin = _photographerLogin;

@end
