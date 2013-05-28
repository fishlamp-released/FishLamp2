// [Generated]
//
// This file was generated at 7/10/12 5:37 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeProject.m
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCodeProject.h"
#import "FLCodeCompany.h"
#import "FLCodeCodeLicense.h"
#import "FLCodeGeneratorOptions.h"

#import "FLCodeArray.h"
#import "FLCodeDefine.h"
#import "FLCodeTypeDefinition.h"
#import "FLCodeEnumType.h"
#import "FLCodeImport.h"
#import "FLCodeObject.h"

@implementation FLCodeProject

@synthesize arrays = __arrays;

// Getter will create __arrays if nil. Alternately, use the arraysObject property, which will not lazy create it.
- (NSMutableArray*) arrays
{
    if(!__arrays)
    {
        __arrays = [[NSMutableArray alloc] init];
    }
    return __arrays;
}
@synthesize canLazyCreate = __canLazyCreate;
@synthesize comment = __comment;
@synthesize defines = __defines;

// Getter will create __defines if nil. Alternately, use the definesObject property, which will not lazy create it.
- (NSMutableArray*) defines
{
    if(!__defines)
    {
        __defines = [[NSMutableArray alloc] init];
    }
    return __defines;
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
@synthesize enumTypes = __enumTypes;

// Getter will create __enumTypes if nil. Alternately, use the enumTypesObject property, which will not lazy create it.
- (NSMutableArray*) enumTypes
{
    if(!__enumTypes)
    {
        __enumTypes = [[NSMutableArray alloc] init];
    }
    return __enumTypes;
}
@synthesize generatorOptions = __generatorOptions;

// Getter will create __generatorOptions if nil. Alternately, use the generatorOptionsObject property, which will not lazy create it.
- (FLCodeGeneratorOptions*) generatorOptions
{
    if(!__generatorOptions)
    {
        __generatorOptions = [[FLCodeGeneratorOptions alloc] init];
    }
    return __generatorOptions;
}
@synthesize ifDef = __ifDef;
@synthesize imports = __imports;

// Getter will create __imports if nil. Alternately, use the importsObject property, which will not lazy create it.
- (NSMutableArray*) imports
{
    if(!__imports)
    {
        __imports = [[NSMutableArray alloc] init];
    }
    return __imports;
}
@synthesize isWildcardArray = __isWildcardArray;
@synthesize license = __license;

// Getter will create __license if nil. Alternately, use the licenseObject property, which will not lazy create it.
- (FLCodeCodeLicense*) license
{
    if(!__license)
    {
        __license = [[FLCodeCodeLicense alloc] init];
    }
    return __license;
}
@synthesize objects = __objects;

// Getter will create __objects if nil. Alternately, use the objectsObject property, which will not lazy create it.
- (NSMutableArray*) objects
{
    if(!__objects)
    {
        __objects = [[NSMutableArray alloc] init];
    }
    return __objects;
}
@synthesize organization = __organization;

// Getter will create __organization if nil. Alternately, use the organizationObject property, which will not lazy create it.
- (FLCodeCompany*) organization
{
    if(!__organization)
    {
        __organization = [[FLCodeCompany alloc] init];
    }
    return __organization;
}
@synthesize projectName = __projectName;
@synthesize projectPath = __projectPath;
@synthesize schemaName = __schemaName;
@synthesize typeDefinitions = __typeDefinitions;

// Getter will create __typeDefinitions if nil. Alternately, use the typeDefinitionsObject property, which will not lazy create it.
- (NSMutableArray*) typeDefinitions
{
    if(!__typeDefinitions)
    {
        __typeDefinitions = [[NSMutableArray alloc] init];
    }
    return __typeDefinitions;
}





- (void) dealloc
{
    FLRelease(__organization);
    FLRelease(__license);
    FLRelease(__projectName);
    FLRelease(__schemaName);
    FLRelease(__ifDef);
    FLRelease(__comment);
    FLRelease(__generatorOptions);
    FLRelease(__enumTypes);
    FLRelease(__objects);
    FLRelease(__dependencies);
    FLRelease(__defines);
    FLRelease(__arrays);
    FLRelease(__imports);
    FLRelease(__typeDefinitions);
    FLRelease(__projectPath);
    FLSuperDealloc();
}

- (NSUInteger) hash
{
    return [[self projectName] hash];
}


- (BOOL) isEqual:(id) object
{
    return [object isKindOfClass:[self class]] && [[object projectName] isEqual:[self projectName]];
}

+ (FLCodeProject*) project
{
    return FLAutorelease([[FLCodeProject alloc] init]);
}

+ (void) didRegisterObjectDescriber:(FLObjectDescriber *)describer
{
    [describer addArrayProperty:@"enumTypes" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyDescriber propertyDescriber:@"enumType" propertyClass:[FLCodeEnumType class]], nil]];
    [describer addArrayProperty:@"objects" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyDescriber propertyDescriber:@"object" propertyClass:[FLCodeObject class]], nil]];
    [describer addArrayProperty:@"dependencies" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyDescriber propertyDescriber:@"dependency" propertyClass:[FLCodeTypeDefinition class]], nil]];
    [describer addArrayProperty:@"defines" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyDescriber propertyDescriber:@"define" propertyClass:[FLCodeDefine class]], nil]];
    [describer addArrayProperty:@"arrays" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyDescriber propertyDescriber:@"array" propertyClass:[FLCodeArray class]], nil]];
    [describer addArrayProperty:@"imports" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyDescriber propertyDescriber:@"import" propertyClass:[FLCodeImport class]], nil]];
    [describer addArrayProperty:@"typeDefinitions" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyDescriber propertyDescriber:@"typeDefinition" propertyClass:[FLCodeTypeDefinition class]], nil]];

}


// This returns __organization. It does NOT create it if it's NIL.
- (FLCodeCompany*) organizationObject
{
    return __organization;
}

// This returns __license. It does NOT create it if it's NIL.
- (FLCodeCodeLicense*) licenseObject
{
    return __license;
}

// This returns __generatorOptions. It does NOT create it if it's NIL.
- (FLCodeGeneratorOptions*) generatorOptionsObject
{
    return __generatorOptions;
}

// This returns __enumTypes. It does NOT create it if it's NIL.
- (NSMutableArray*) enumTypesObject
{
    return __enumTypes;
}

// This returns __objects. It does NOT create it if it's NIL.
- (NSMutableArray*) objectsObject
{
    return __objects;
}

// This returns __dependencies. It does NOT create it if it's NIL.
- (NSMutableArray*) dependenciesObject
{
    return __dependencies;
}

// This returns __defines. It does NOT create it if it's NIL.
- (NSMutableArray*) definesObject
{
    return __defines;
}

// This returns __arrays. It does NOT create it if it's NIL.
- (NSMutableArray*) arraysObject
{
    return __arrays;
}

// This returns __imports. It does NOT create it if it's NIL.
- (NSMutableArray*) importsObject
{
    return __imports;
}

// This returns __typeDefinitions. It does NOT create it if it's NIL.
- (NSMutableArray*) typeDefinitionsObject
{
    return __typeDefinitions;
}

- (void) createOrganizationIfNil
{
    if(!__organization)
    {
        __organization = [[FLCodeCompany alloc] init];
    }
}

- (void) createLicenseIfNil
{
    if(!__license)
    {
        __license = [[FLCodeCodeLicense alloc] init];
    }
}

- (void) createGeneratorOptionsIfNil
{
    if(!__generatorOptions)
    {
        __generatorOptions = [[FLCodeGeneratorOptions alloc] init];
    }
}

- (void) createEnumTypesIfNil
{
    if(!__enumTypes)
    {
        __enumTypes = [[NSMutableArray alloc] init];
    }
}

- (void) createObjectsIfNil
{
    if(!__objects)
    {
        __objects = [[NSMutableArray alloc] init];
    }
}

- (void) createDependenciesIfNil
{
    if(!__dependencies)
    {
        __dependencies = [[NSMutableArray alloc] init];
    }
}

- (void) createDefinesIfNil
{
    if(!__defines)
    {
        __defines = [[NSMutableArray alloc] init];
    }
}

- (void) createArraysIfNil
{
    if(!__arrays)
    {
        __arrays = [[NSMutableArray alloc] init];
    }
}

- (void) createImportsIfNil
{
    if(!__imports)
    {
        __imports = [[NSMutableArray alloc] init];
    }
}

- (void) createTypeDefinitionsIfNil
{
    if(!__typeDefinitions)
    {
        __typeDefinitions = [[NSMutableArray alloc] init];
    }
}
@end

// [/Generated]
