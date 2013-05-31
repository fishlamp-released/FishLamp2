// [Generated]
//
// This file was generated at 7/9/12 1:47 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeType.m
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCodeType.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLCodeType

@synthesize defaultValue = __defaultValue;
@synthesize typeName = __typeName;
@synthesize typeNameUnmodified = __typeNameUnmodified;

- (void) dealloc
{
    FLRelease(__typeName);
    FLRelease(__defaultValue);
    FLRelease(__typeNameUnmodified);
    FLSuperDealloc();
}

- (NSUInteger) hash
{
    return [[self typeName] hash];
}

- (BOOL) isEqual:(id) object
{
    return [object isKindOfClass:[self class]] && [[object typeName] isEqual:[self typeName]];
}

+ (FLCodeType*) type
{
    return FLAutorelease([[FLCodeType alloc] init]);
}

@end

// [/Generated]
