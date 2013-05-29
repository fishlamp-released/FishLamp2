// [Generated]
//
// This file was generated at 7/9/12 1:47 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeEnum.m
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCodeEnum.h"

@implementation FLCodeEnum

@synthesize name = __name;
@synthesize stringValue = __stringValue;
@synthesize value = __value;

- (void) dealloc
{
    FLRelease(__name);
    FLRelease(__stringValue);
    FLSuperDealloc();
}

+ (FLCodeEnum*) codeEnum
{
    return FLAutorelease([[FLCodeEnum alloc] init]);
}

- (NSUInteger) hash
{
    return [[self name] hash];
}

- (BOOL) isEqual:(id) object
{
    return [object isKindOfClass:[self class]] && [[((FLCodeEnum*)object) name] isEqual:[self name]];
}

@end



// [/Generated]
