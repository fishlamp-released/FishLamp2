// 
// ZFAccessDescriptor.m
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


#import "ZFAccessDescriptor.h"
#import "FLModelObject.h"
#import "ZFAccessType.h"
#import "FLObjectDescriber.h"
#import "ZFApiAccessMask.h"

@implementation ZFAccessDescriptor

+ (ZFAccessDescriptor*) accessDescriptor {
    return FLAutorelease([[[self class] alloc] init]);
}
@synthesize accessMask = _accessMask;
- (ZFApiAccessMask) accessMaskEnum {
    return ZFApiAccessMaskEnumFromString(self.accessMask);
}
- (void) setAccessMaskEnum:(ZFApiAccessMask) value {
    self.accessMask = ZFApiAccessMaskStringFromEnum(value);
}
- (ZFApiAccessMaskEnumSet*) accessMaskEnumSet {
    return ZFApiAccessMaskEnumFromString(self.accessMask);
}
- (void) setAccessMaskEnumSet:(ZFApiAccessMaskEnumSet*) value {
    self.accessMask = value.concatenatedString;
}
@synthesize accessType = _accessType;
- (ZFAccessType) accessTypeEnum {
    return ZFAccessTypeEnumFromString(self.accessType);
}
- (void) setAccessTypeEnum:(ZFAccessType) value {
    self.accessType = ZFAccessTypeStringFromEnum(value);
}
- (ZFAccessTypeEnumSet*) accessTypeEnumSet {
    return ZFAccessTypeEnumFromString(self.accessType);
}
- (void) setAccessTypeEnumSet:(ZFAccessTypeEnumSet*) value {
    self.accessType = value.concatenatedString;
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
+ (void) didRegisterObjectDescriber:(FLObjectDescriber*) describer {
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"Viewer" propertyClass:[NSString class]] forContainerProperty:@"viewers"];
}
@synthesize isDerived = _isDerived;
@synthesize passwordHint = _passwordHint;
@synthesize realmId = _realmId;
@synthesize srcPasswordHint = _srcPasswordHint;
@synthesize viewers = _viewers;

@end
