// [Generated]
//
// This file was generated at 7/9/12 1:47 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeObject.m
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCodeObject.h"
#import "FLCodeStorageOptions.h"
#import "FLCodeObjectCategory.h"
#import "FLCodeTypeDefinition.h"
#import "FLCodeVariable.h"
#import "FLCodeMethod.h"
#import "FLCodeProperty.h"
#import "FLCodeCodeSnippet.h"

@implementation FLCodeObject

@synthesize canLazyCreate = __canLazyCreate;
@synthesize categories = __categories;

// Getter will create __categories if nil. Alternately, use the categoriesObject property, which will not lazy create it.
- (NSMutableArray*) categories
{
    if(!__categories)
    {
        __categories = [[NSMutableArray alloc] init];
    }
    return __categories;
}
@synthesize comment = __comment;
@synthesize deallocLines = __deallocLines;

// Getter will create __deallocLines if nil. Alternately, use the deallocLinesObject property, which will not lazy create it.
- (NSMutableArray*) deallocLines
{
    if(!__deallocLines)
    {
        __deallocLines = [[NSMutableArray alloc] init];
    }
    return __deallocLines;
}
@synthesize dependencies = __dependencies;

// Getter will create __dependencies if nil. Alternately, use the dependenciesObject property, which will not lazy create it.
- (NSMutableArray*) dependencies
{
    if(!__dependencies)
    {
        __dependencies = [[NSMutableArray alloc] init];
    }
    return __dependencies;
}
@synthesize disabled = __disabled;
@synthesize ifDef = __ifDef;
@synthesize linesForInitMethod = __linesForInitMethod;

// Getter will create __linesForInitMethod if nil. Alternately, use the linesForInitMethodObject property, which will not lazy create it.
- (NSMutableArray*) linesForInitMethod
{
    if(!__linesForInitMethod)
    {
        __linesForInitMethod = [[NSMutableArray alloc] init];
    }
    return __linesForInitMethod;
}
@synthesize isSingleton = __isSingleton;
@synthesize isWildcardArray = __isWildcardArray;
@synthesize members = __members;

// Getter will create __members if nil. Alternately, use the membersObject property, which will not lazy create it.
- (NSMutableArray*) members
{
    if(!__members)
    {
        __members = [[NSMutableArray alloc] init];
    }
    return __members;
}
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
@synthesize className = __className;
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
@synthesize protocols = __protocols;
@synthesize sourceSnippets = __sourceSnippets;

// Getter will create __sourceSnippets if nil. Alternately, use the sourceSnippetsObject property, which will not lazy create it.
- (NSMutableArray*) sourceSnippets
{
    if(!__sourceSnippets)
    {
        __sourceSnippets = [[NSMutableArray alloc] init];
    }
    return __sourceSnippets;
}
@synthesize storageOptions = __storageOptions;

// Getter will create __storageOptions if nil. Alternately, use the storageOptionsObject property, which will not lazy create it.
- (FLCodeStorageOptions*) storageOptions
{
    if(!__storageOptions)
    {
        __storageOptions = [[FLCodeStorageOptions alloc] init];
    }
    return __storageOptions;
}
@synthesize superclass = __superclass;

- (void) dealloc
{
    FLRelease(__protocols);
    FLRelease(__className);
    FLRelease(__storageOptions);
    FLRelease(__comment);
    FLRelease(__superclass);
    FLRelease(__ifDef);
    FLRelease(__properties);
    FLRelease(__dependencies);
    FLRelease(__members);
    FLRelease(__methods);
    FLRelease(__sourceSnippets);
    FLRelease(__linesForInitMethod);
    FLRelease(__deallocLines);
    FLRelease(__categories);
    FLSuperDealloc();
}

+ (FLCodeObject*) object
{
    return FLAutorelease([[FLCodeObject alloc] init]);
}

+ (void) didRegisterObjectDescriber:(FLObjectDescriber *)describer
{
    [describer addArrayProperty:@"properties" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyDescriber propertyDescriber:@"property" propertyClass:[FLCodeProperty class]], nil]];
    [describer addArrayProperty:@"dependencies" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyDescriber propertyDescriber:@"dependency" propertyClass:[FLCodeTypeDefinition class]], nil]];
    [describer addArrayProperty:@"members" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyDescriber propertyDescriber:@"member" propertyClass:[FLCodeVariable class]], nil]];
    [describer addArrayProperty:@"methods" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyDescriber propertyDescriber:@"method" propertyClass:[FLCodeMethod class]], nil]];
    [describer addArrayProperty:@"sourceSnippets" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyDescriber propertyDescriber:@"code" propertyClass:[FLCodeCodeSnippet class]], nil]];
    [describer addArrayProperty:@"linesForInitMethod" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyDescriber propertyDescriber:@"line" propertyClass:[NSString class]], nil]];
    [describer addArrayProperty:@"deallocLines" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyDescriber propertyDescriber:@"deallocLine" propertyClass:[NSString class]], nil]];
    [describer addArrayProperty:@"categories" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyDescriber propertyDescriber:@"category" propertyClass:[FLCodeObjectCategory class]], nil]];
}

// This returns __storageOptions. It does NOT create it if it's NIL.
- (FLCodeStorageOptions*) storageOptionsObject
{
    return __storageOptions;
}

// This returns __properties. It does NOT create it if it's NIL.
- (NSMutableArray*) propertiesObject
{
    return __properties;
}

// This returns __dependencies. It does NOT create it if it's NIL.
- (NSMutableArray*) dependenciesObject
{
    return __dependencies;
}

// This returns __members. It does NOT create it if it's NIL.
- (NSMutableArray*) membersObject
{
    return __members;
}

// This returns __methods. It does NOT create it if it's NIL.
- (NSMutableArray*) methodsObject
{
    return __methods;
}

// This returns __sourceSnippets. It does NOT create it if it's NIL.
- (NSMutableArray*) sourceSnippetsObject
{
    return __sourceSnippets;
}

// This returns __linesForInitMethod. It does NOT create it if it's NIL.
- (NSMutableArray*) linesForInitMethodObject
{
    return __linesForInitMethod;
}

// This returns __deallocLines. It does NOT create it if it's NIL.
- (NSMutableArray*) deallocLinesObject
{
    return __deallocLines;
}

// This returns __categories. It does NOT create it if it's NIL.
- (NSMutableArray*) categoriesObject
{
    return __categories;
}

- (void) createStorageOptionsIfNil
{
    if(!__storageOptions)
    {
        __storageOptions = [[FLCodeStorageOptions alloc] init];
    }
}

- (void) createPropertiesIfNil
{
    if(!__properties)
    {
        __properties = [[NSMutableArray alloc] init];
    }
}

- (void) createDependenciesIfNil
{
    if(!__dependencies)
    {
        __dependencies = [[NSMutableArray alloc] init];
    }
}

- (void) createMembersIfNil
{
    if(!__members)
    {
        __members = [[NSMutableArray alloc] init];
    }
}

- (void) createMethodsIfNil
{
    if(!__methods)
    {
        __methods = [[NSMutableArray alloc] init];
    }
}

- (void) createSourceSnippetsIfNil
{
    if(!__sourceSnippets)
    {
        __sourceSnippets = [[NSMutableArray alloc] init];
    }
}

- (void) createInitLinesIfNil
{
    if(!__linesForInitMethod)
    {
        __linesForInitMethod = [[NSMutableArray alloc] init];
    }
}

- (void) createDeallocLinesIfNil
{
    if(!__deallocLines)
    {
        __deallocLines = [[NSMutableArray alloc] init];
    }
}

- (void) createCategoriesIfNil
{
    if(!__categories)
    {
        __categories = [[NSMutableArray alloc] init];
    }
}
@end

// [/Generated]
