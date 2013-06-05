// 
// FLCodeProject.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/3/13 10:33 AM with PackMule (3.0.0.1)
// 
// Project: FishLamp Code Generator
// Schema: ObjectModel
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 


#import "FLObjectDescriber.h"
#import "FLCodeObject.h"
#import "FLCodeProject.h"
#import "FLCodeTypeDefinition.h"
#import "FLCodeCompany.h"
#import "FLCodeArray.h"
#import "FLModelObject.h"
#import "FLCodeGeneratorOptions.h"
#import "FLCodeDefine.h"
#import "FLCodeImport.h"
#import "FLCodeEnumType.h"
#import "FLCodeCodeLicense.h"

@implementation FLCodeProject

FLSynthesizeLazyGetter(arrays, NSMutableArray, _arrays);
@synthesize arrays = _arrays;
@synthesize canLazyCreate = _canLazyCreate;
+ (FLCodeProject*) codeProject {
    return FLAutorelease([[[self class] alloc] init]);
}
@synthesize comment = _comment;
#if FL_MRC
- (void) dealloc {
    [_schemaName release];
    [_projectName release];
    [_defines release];
    [_imports release];
    [_typeDefinitions release];
    [_enumTypes release];
    [_license release];
    [_generatorOptions release];
    [_objects release];
    [_comment release];
    [_arrays release];
    [_ifDef release];
    [_dependencies release];
    [_projectPath release];
    [_organization release];
    [super dealloc];
}
#endif
FLSynthesizeLazyGetter(defines, NSMutableArray, _defines);
@synthesize defines = _defines;
FLSynthesizeLazyGetter(dependencies, NSMutableArray, _dependencies);
@synthesize dependencies = _dependencies;
+ (void) didRegisterObjectDescriber:(FLObjectDescriber*) describer {
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"define" propertyClass:[FLCodeDefine class]] forContainerProperty:@"defines"];
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"import" propertyClass:[FLCodeImport class]] forContainerProperty:@"imports"];
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"typeDefinition" propertyClass:[FLCodeTypeDefinition class]] forContainerProperty:@"typeDefinitions"];
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"enumType" propertyClass:[FLCodeEnumType class]] forContainerProperty:@"enumTypes"];
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"object" propertyClass:[FLCodeObject class]] forContainerProperty:@"objects"];
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"array" propertyClass:[FLCodeArray class]] forContainerProperty:@"arrays"];
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"dependency" propertyClass:[FLCodeTypeDefinition class]] forContainerProperty:@"dependencies"];
}
@synthesize disabled = _disabled;
FLSynthesizeLazyGetter(enumTypes, NSMutableArray, _enumTypes);
@synthesize enumTypes = _enumTypes;
FLSynthesizeLazyGetter(generatorOptions, FLCodeGeneratorOptions, _generatorOptions);
@synthesize generatorOptions = _generatorOptions;
@synthesize ifDef = _ifDef;
FLSynthesizeLazyGetter(imports, NSMutableArray, _imports);
@synthesize imports = _imports;
@synthesize isWildcardArray = _isWildcardArray;
FLSynthesizeLazyGetter(license, FLCodeCodeLicense, _license);
@synthesize license = _license;
FLSynthesizeLazyGetter(objects, NSMutableArray, _objects);
@synthesize objects = _objects;
FLSynthesizeLazyGetter(organization, FLCodeCompany, _organization);
@synthesize organization = _organization;
@synthesize projectName = _projectName;
@synthesize projectPath = _projectPath;
@synthesize schemaName = _schemaName;
FLSynthesizeLazyGetter(typeDefinitions, NSMutableArray, _typeDefinitions);
@synthesize typeDefinitions = _typeDefinitions;

@end