// [Generated]
//
// This file was generated at 7/9/12 1:47 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeMethod.m
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCodeMethod.h"
#import "FLCodeCodeSnippet.h"
#import "FLCodeVariable.h"

@implementation FLCodeMethod

//@synthesize code = __code;

// Getter will create __code if nil. Alternately, use the codeObject property, which will not lazy create it.
- (FLCodeCodeSnippet*) code
{
    if(!__code)
    {
        __code = [[FLCodeCodeSnippet alloc] init];
    }
    return __code;
}
@synthesize comment = __comment;
@synthesize isPrivate = __isPrivate;
@synthesize isStatic = __isStatic;
@synthesize name = __name;
@synthesize parameters = __parameters;

// Getter will create __parameters if nil. Alternately, use the parametersObject property, which will not lazy create it.
- (NSMutableArray*) parameters
{
    if(!__parameters)
    {
        __parameters = [[NSMutableArray alloc] init];
    }
    return __parameters;
}
@synthesize returnType = __returnType;

- (NSMutableArray*) codeLines
{
    if(!_codeLines)
    {
        _codeLines = [[NSMutableArray alloc] init];
    }
    return _codeLines;
}
@synthesize codeLines = _codeLines;

- (void) dealloc
{
    FLRelease(__returnType);
    FLRelease(__name);
    FLRelease(__comment);
    FLRelease(__code);
    FLRelease(__parameters);
    FLSuperDealloc();
}

- (NSUInteger) hash
{
    return [[self name] hash];
}


- (BOOL) isEqual:(id) object
{
    return [object isKindOfClass:[self class]] && [[((FLCodeMethod*)object) name] isEqual:[self name]];
}

+ (FLCodeMethod*) method
{
    return FLAutorelease([[FLCodeMethod alloc] init]);
}

+ (void) didRegisterObjectDescriber:(FLObjectDescriber*) describer
{
    [describer addArrayProperty:@"parameters" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyDescriber propertyDescriber:@"parameter" propertyClass:[FLCodeVariable class]], nil]];
}

// This returns __code. It does NOT create it if it's NIL.
- (FLCodeCodeSnippet*) codeObject
{
    return __code;
}

// This returns __parameters. It does NOT create it if it's NIL.
- (NSMutableArray*) parametersObject
{
    return __parameters;
}

- (void) createCodeIfNil
{
    if(!__code)
    {
        __code = [[FLCodeCodeSnippet alloc] init];
    }
}

- (void) createParametersIfNil
{
    if(!__parameters)
    {
        __parameters = [[NSMutableArray alloc] init];
    }
}
@end

// [/Generated]
