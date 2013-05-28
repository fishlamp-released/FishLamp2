// [Generated]
//
// This file was generated at 7/9/12 1:47 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeObjectCategory.m
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCodeObjectCategory.h"
#import "FLCodeMethod.h"
#import "FLCodeProperty.h"

@implementation FLCodeObjectCategory

@synthesize categoryName = __categoryName;
@synthesize methods = __methods;

// Getter will create __methods if nil. Alternately, use the methodsObject property, which will not lazy create it.
- (NSMutableArray*) methods
{
    if(!__methods)
    {
        __methods = [[NSMutableArray alloc] init];
    }
    return __methods;
}
@synthesize objectName = __objectName;
@synthesize properties = __properties;

// Getter will create __properties if nil. Alternately, use the propertiesObject property, which will not lazy create it.
- (NSMutableArray*) properties
{
    if(!__properties)
    {
        __properties = [[NSMutableArray alloc] init];
    }
    return __properties;
}

- (void) dealloc
{
    FLRelease(__objectName);
    FLRelease(__categoryName);
    FLRelease(__properties);
    FLRelease(__methods);
    FLSuperDealloc();
}


+ (FLCodeObjectCategory*) objectCategory
{
    return FLAutorelease([[FLCodeObjectCategory alloc] init]);
}

+ (void) didRegisterObjectDescriber:(FLObjectDescriber *)describer {

    [describer addArrayProperty:@"properties" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyDescriber propertyDescriber:@"property" propertyClass:[FLCodeProperty class]], nil]];
    [describer addArrayProperty:@"methods" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyDescriber propertyDescriber:@"method" propertyClass:[FLCodeMethod class]], nil]];
}

// This returns __properties. It does NOT create it if it's NIL.
- (NSMutableArray*) propertiesObject
{
    return __properties;
}

// This returns __methods. It does NOT create it if it's NIL.
- (NSMutableArray*) methodsObject
{
    return __methods;
}

- (void) createPropertiesIfNil
{
    if(!__properties)
    {
        __properties = [[NSMutableArray alloc] init];
    }
}

- (void) createMethodsIfNil
{
    if(!__methods)
    {
        __methods = [[NSMutableArray alloc] init];
    }
}
@end

// [/Generated]
