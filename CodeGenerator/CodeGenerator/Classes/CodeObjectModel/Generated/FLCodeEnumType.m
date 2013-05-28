// [Generated]
//
// This file was generated at 7/9/12 1:47 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeEnumType.m
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCodeEnumType.h"
#import "FLCodeEnum.h"

@implementation FLCodeEnumType

@synthesize enums = __enums;

// Getter will create __enums if nil. Alternately, use the enumsObject property, which will not lazy create it.
- (NSMutableArray*) enums
{
    if(!__enums)
    {
        __enums = [[NSMutableArray alloc] init];
    }
    return __enums;
}

- (void) dealloc
{
    FLRelease(__enums);
    FLSuperDealloc();
}

+ (FLCodeEnumType*) enumType
{
    return FLAutorelease([[[self class] alloc] init]);
}

+ (void) didRegisterObjectDescriber:(FLObjectDescriber *)describer {
    [describer addArrayProperty:@"enums" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyDescriber propertyDescriber:@"enum" propertyClass:[FLCodeEnum class]], nil]];
}

// This returns __enums. It does NOT create it if it's NIL.
- (NSMutableArray*) enumsObject
{
    return __enums;
}

- (void) createEnumsIfNil
{
    if(!__enums)
    {
        __enums = [[NSMutableArray alloc] init];
    }
}
@end

// [/Generated]
