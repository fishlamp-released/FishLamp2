// [Generated]
//
// This file was generated at 7/9/12 1:47 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeProperty.m
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCodeProperty.h"
#import "FLCodeStorageOptions.h"
#import "FLCodeMethod.h"
#import "FLCodeEnumType.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"
#import "FLCodeArrayType.h"

@implementation FLCodeProperty


@synthesize arrayTypes = __arrayTypes;

// Getter will create __arrayTypes if nil. Alternately, use the arrayTypesObject property, which will not lazy create it.
//- (NSMutableArray*) arrayTypes
//{
//    if(!__arrayTypes)
//    {
//        __arrayTypes = [[NSMutableArray alloc] init];
//    }
//    return __arrayTypes;
//}
@synthesize canLazyCreate = __canLazyCreate;
@synthesize comment = __comment;
@synthesize defaultValue = __defaultValue;
@synthesize enumType = __enumType;

// Getter will create __enumType if nil. Alternately, use the enumTypeObject property, which will not lazy create it.
- (FLCodeEnumType*) enumType
{
    if(!__enumType)
    {
        __enumType = [[FLCodeEnumType alloc] init];
    }
    return __enumType;
}
@synthesize getter = __getter;

// Getter will create __getter if nil. Alternately, use the getterObject property, which will not lazy create it.
- (FLCodeMethod*) getter
{
    if(!__getter)
    {
        __getter = [[FLCodeMethod alloc] init];
    }
    return __getter;
}
@synthesize hasCustomCode = __hasCustomCode;
@synthesize isImmutable = __isImmutable;
@synthesize isPrivate = __isPrivate;
@synthesize isReadOnly = __isReadOnly;
@synthesize isStatic = __isStatic;
@synthesize isWeak = __isWeak;
@synthesize isWildcardArray = __isWildcardArray;
@synthesize memberName = __memberName;
@synthesize name = __name;
@synthesize nameUnmodified = __nameUnmodified;
@synthesize setter = __setter;

// Getter will create __setter if nil. Alternately, use the setterObject property, which will not lazy create it.
- (FLCodeMethod*) setter
{
    if(!__setter)
    {
        __setter = [[FLCodeMethod alloc] init];
    }
    return __setter;
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
@synthesize type = __type;
@synthesize typeUnmodified = __typeUnmodified;
@synthesize useForEquality = __useForEquality;

- (void) dealloc
{
    FLRelease(__name);
    FLRelease(__type);
    FLRelease(__storageOptions);
    FLRelease(__memberName);
    FLRelease(__defaultValue);
    FLRelease(__comment);
    FLRelease(__getter);
    FLRelease(__setter);
    FLRelease(__arrayTypes);
    FLRelease(__typeUnmodified);
    FLRelease(__nameUnmodified);
    FLRelease(__enumType);
    FLSuperDealloc();
}

- (NSUInteger) hash
{
    return [[self name] hash];
}

- (BOOL) isEqual:(id) object
{
    return [object isKindOfClass:[self class]] && [[((FLCodeProperty*)object) name] isEqual:[self name]];
}

+ (FLCodeProperty*) property
{
    return FLAutorelease([[FLCodeProperty alloc] init]);
}

+ (void) didRegisterObjectDescriber:(FLObjectDescriber *)describer
{
    [describer addArrayProperty:@"arrayTypes" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyDescriber propertyDescriber:@"arrayType" propertyClass:[FLCodeArrayType class]], nil]];
}

// This returns __storageOptions. It does NOT create it if it's NIL.
- (FLCodeStorageOptions*) storageOptionsObject
{
    return __storageOptions;
}

// This returns __getter. It does NOT create it if it's NIL.
- (FLCodeMethod*) getterObject
{
    return __getter;
}

// This returns __setter. It does NOT create it if it's NIL.
- (FLCodeMethod*) setterObject
{
    return __setter;
}

// This returns __arrayTypes. It does NOT create it if it's NIL.
- (NSMutableArray*) arrayTypesObject
{
    return __arrayTypes;
}

// This returns __enumType. It does NOT create it if it's NIL.
- (FLCodeEnumType*) enumTypeObject
{
    return __enumType;
}

- (void) createStorageOptionsIfNil
{
    if(!__storageOptions)
    {
        __storageOptions = [[FLCodeStorageOptions alloc] init];
    }
}

- (void) createGetterIfNil
{
    if(!__getter)
    {
        __getter = [[FLCodeMethod alloc] init];
    }
}

- (void) createSetterIfNil
{
    if(!__setter)
    {
        __setter = [[FLCodeMethod alloc] init];
    }
}

- (void) createArrayTypesIfNil
{
    if(!__arrayTypes)
    {
        __arrayTypes = [[NSMutableArray alloc] init];
    }
}

- (void) createEnumTypeIfNil
{
    if(!__enumType)
    {
        __enumType = [[FLCodeEnumType alloc] init];
    }
}
@end

// [/Generated]
