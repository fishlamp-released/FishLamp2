// 
// FLCodeEnumType.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/2/13 5:40 PM with PackMule (3.0.0.100)
// 
// Project: FishLamp Code Generator
// Schema: ObjectModel
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 


#import "FLCodeEnum.h"
#import "FLCodeType.h"
#import "FLCodeEnumType.h"
#import "FLObjectDescriber.h"

@implementation FLCodeEnumType

+ (FLCodeEnumType*) codeEnumType {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [_enums release];
    [super dealloc];
}
#endif
+ (void) didRegisterObjectDescriber:(FLObjectDescriber*) describer {
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"enum" propertyClass:[FLCodeEnum class]] forContainerProperty:@"enums"];
}
@synthesize enums = _enums;

@end
