// [Generated]
//
// This file was generated at 7/9/12 1:47 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeArray.m
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCodeArray.h"
#import "FLCodeArrayType.h"

@implementation FLCodeArray


@synthesize name = __name;
@synthesize types = __types;

// Getter will create __types if nil. Alternately, use the typesObject property, which will not lazy create it.
- (NSMutableArray*) types
{
    if(!__types)
    {
        __types = [[NSMutableArray alloc] init];
    }
    return __types;
}

+ (FLCodeArray*) array
{
    return FLAutorelease([[FLCodeArray alloc] init]);
}


- (void) dealloc
{
    FLRelease(__name);
    FLRelease(__types);
    FLSuperDealloc();
}

- (NSUInteger) hash
{
    return [[self name] hash];
}

- (BOOL) isEqual:(id) object
{
    return [object isKindOfClass:[self class]] && [[((FLCodeArray*)object) name] isEqual:[self name]];
}

+ (void) didRegisterObjectDescriber:(FLObjectDescriber *)describer
{
    [describer addArrayProperty:@"types" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyDescriber propertyDescriber:@"arrayType" propertyClass:[FLCodeArrayType class]], nil]];
}

// This returns __types. It does NOT create it if it's NIL.
- (NSMutableArray*) typesObject
{
    return __types;
}

- (void) createTypesIfNil
{
    if(!__types)
    {
        __types = [[NSMutableArray alloc] init];
    }
}
@end

// [/Generated]
