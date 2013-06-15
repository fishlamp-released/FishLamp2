// 
// FLCodeObjectBaseClass.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/15/13 4:24 PM with PackMule (3.0.0.29)
// 
// Project: FishLamp Code Generator
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLCodeProperty.h"
#import "FLCodeTypeDefinition.h"
#import "FLCodeMethod.h"
#import "FLCodeConstructor.h"
#import "FLCodeObjectCategory.h"
#import "FLModelObject.h"
#import "FLObjectDescriber.h"
#import "FLCodeStorageOptions.h"
#import "FLCodeVariable.h"
#import "FLCodeObjectBaseClass.h"
#import "FLCodeCodeSnippet.h"

@implementation FLCodeObjectBaseClass

@synthesize canLazyCreate = _canLazyCreate;
FLSynthesizeLazyGetter(categories, NSMutableArray, _categories);
@synthesize categories = _categories;
@synthesize className = _className;
@synthesize comment = _comment;
FLSynthesizeLazyGetter(constructors, NSMutableArray, _constructors);
@synthesize constructors = _constructors;
#if FL_MRC
- (void) dealloc {
    [_methods release];
    [_protocols release];
    [_categories release];
    [_members release];
    [_superclass release];
    [_storageOptions release];
    [_comment release];
    [_sourceSnippets release];
    [_linesForInitMethod release];
    [_className release];
    [_ifDef release];
    [_properties release];
    [_dependencies release];
    [_deallocLines release];
    [_constructors release];
    [super dealloc];
}
#endif
FLSynthesizeLazyGetter(deallocLines, NSMutableArray, _deallocLines);
@synthesize deallocLines = _deallocLines;
FLSynthesizeLazyGetter(dependencies, NSMutableArray, _dependencies);
@synthesize dependencies = _dependencies;
+ (void) didRegisterObjectDescriber:(FLObjectDescriber*) describer {
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"method" propertyClass:[FLCodeMethod class]] forContainerProperty:@"methods"];
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"category" propertyClass:[FLCodeObjectCategory class]] forContainerProperty:@"categories"];
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"member" propertyClass:[FLCodeVariable class]] forContainerProperty:@"members"];
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"code" propertyClass:[FLCodeCodeSnippet class]] forContainerProperty:@"sourceSnippets"];
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"line" propertyClass:[NSString class]] forContainerProperty:@"linesForInitMethod"];
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"property" propertyClass:[FLCodeProperty class]] forContainerProperty:@"properties"];
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"dependency" propertyClass:[FLCodeTypeDefinition class]] forContainerProperty:@"dependencies"];
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"deallocLine" propertyClass:[NSString class]] forContainerProperty:@"deallocLines"];
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"constructor" propertyClass:[FLCodeConstructor class]] forContainerProperty:@"constructors"];
}
@synthesize disabled = _disabled;
@synthesize ifDef = _ifDef;
@synthesize isSingleton = _isSingleton;
@synthesize isWildcardArray = _isWildcardArray;
FLSynthesizeLazyGetter(linesForInitMethod, NSMutableArray, _linesForInitMethod);
@synthesize linesForInitMethod = _linesForInitMethod;
FLSynthesizeLazyGetter(members, NSMutableArray, _members);
@synthesize members = _members;
FLSynthesizeLazyGetter(methods, NSMutableArray, _methods);
@synthesize methods = _methods;
FLSynthesizeLazyGetter(properties, NSMutableArray, _properties);
@synthesize properties = _properties;
@synthesize protocols = _protocols;
FLSynthesizeLazyGetter(sourceSnippets, NSMutableArray, _sourceSnippets);
@synthesize sourceSnippets = _sourceSnippets;
FLSynthesizeLazyGetter(storageOptions, FLCodeStorageOptions, _storageOptions);
@synthesize storageOptions = _storageOptions;
@synthesize superclass = _superclass;

@end
