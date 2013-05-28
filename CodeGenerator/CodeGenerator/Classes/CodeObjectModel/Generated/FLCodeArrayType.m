// [Generated]
//
// This file was generated at 7/9/12 1:47 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeArrayType.m
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCodeArrayType.h"
#import "FLCodeProperty.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLCodeArrayType


@synthesize wildcardProperty = __wildcardProperty;

// Getter will create __wildcardProperty if nil. Alternately, use the wildcardPropertyObject property, which will not lazy create it.
- (FLCodeProperty*) wildcardProperty
{
    if(!__wildcardProperty)
    {
        __wildcardProperty = [[FLCodeProperty alloc] init];
    }
    return __wildcardProperty;
}

+ (NSString*) wildcardPropertyKey
{
    return @"wildcardProperty";
}

+ (FLCodeArrayType*) arrayType
{
    return FLAutorelease([[FLCodeArrayType alloc] init]);
}

- (void) dealloc
{
    FLRelease(__wildcardProperty);
    FLSuperDealloc();
}

// This returns __wildcardProperty. It does NOT create it if it's NIL.
- (FLCodeProperty*) wildcardPropertyObject
{
    return __wildcardProperty;
}

- (void) createWildcardPropertyIfNil
{
    if(!__wildcardProperty)
    {
        __wildcardProperty = [[FLCodeProperty alloc] init];
    }
}
@end

// [/Generated]
