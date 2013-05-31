// [Generated]
//
// This file was generated at 7/9/12 1:47 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeVariable.m
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCodeVariable.h"


@implementation FLCodeVariable

@synthesize name = __name;

- (void) dealloc
{
    FLRelease(__name);
    FLSuperDealloc();
}

- (NSUInteger) hash
{
    return [[self name] hash];
}

- (BOOL) isEqual:(id) object
{
    return [object isKindOfClass:[self class]] && [[((FLCodeVariable*)object) name] isEqual:[self name]];
}

+ (FLCodeVariable*) variable
{
    return FLAutorelease([[FLCodeVariable alloc] init]);
}

@end

// [/Generated]
