// 
// ZFAccessDescriptor.m
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

#import "ZFAccessDescriptor.h"
#import "FLObjectDescriber.h"
#import "FLModelObject.h"
@implementation ZFAccessDescriptor
@synthesize accessType = _accessType;
@synthesize isDerived = _isDerived;
@synthesize accessMask = _accessMask;
@synthesize srcPasswordHint = _srcPasswordHint;
@synthesize viewers = _viewers;
@synthesize passwordHint = _passwordHint;
@synthesize realmId = _realmId;
+ (void) didRegisterObjectDescriber:(FLObjectDescriber*) describer {
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"Viewer" propertyClass:[NSString class]] forContainerProperty:@"viewers"];
}
+ (ZFAccessDescriptor*) accessDescriptor {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [_accessType release];
    [_accessMask release];
    [_srcPasswordHint release];
    [_viewers release];
    [_passwordHint release];
    [super dealloc];
}
#endif
@end
