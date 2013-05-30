// 
// ZFAccessUpdater.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/30/13 4:42 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "ZFAccessUpdater.h"
#import "FLModelObject.h"
#import "FLObjectDescriber.h"
@implementation ZFAccessUpdater
@synthesize password = _password;
@synthesize passwordHint = _passwordHint;
@synthesize accessMask = _accessMask;
@synthesize accessType = _accessType;
@synthesize isDerived = _isDerived;
@synthesize viewers = _viewers;
+(void) didRegisterObjectDescriber:(FLObjectDescriber*) describer {
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"Viewer" propertyClass:[NSString class]] forContainerProperty:@"viewers"];
}
+(ZFAccessUpdater*) accessUpdater {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_password release];
    [_passwordHint release];
    [_accessMask release];
    [_accessType release];
    [_viewers release];
    [super dealloc];
}
#endif
@end
