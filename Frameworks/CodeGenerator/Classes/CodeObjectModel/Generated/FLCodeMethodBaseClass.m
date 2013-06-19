// 
// FLCodeMethodBaseClass.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/19/13 3:25 PM with PackMule (3.0.0.29)
// 
// Project: FishLamp Code Generator
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLCodeVariable.h"
#import "FLObjectDescriber.h"
#import "FLModelObject.h"
#import "FLCodeElement.h"
#import "FLCodeCodeSnippet.h"
#import "FLCodeMethodBaseClass.h"

@implementation FLCodeMethodBaseClass

FLSynthesizeLazyGetter(code, FLCodeCodeSnippet, _code);
@synthesize code = _code;
FLSynthesizeLazyGetter(codeLines, NSMutableArray, _codeLines);
@synthesize codeLines = _codeLines;
+ (id) codeMethod {
    return FLAutorelease([[[self class] alloc] init]);
}
@synthesize comment = _comment;
#if FL_MRC
- (void) dealloc {
    [_returnType release];
    [_parameters release];
    [_code release];
    [_comment release];
    [_codeLines release];
    [_name release];
    [super dealloc];
}
#endif
+ (void) didRegisterObjectDescriber:(FLObjectDescriber*) describer {
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"parameter" propertyClass:[FLCodeVariable class]] forContainerProperty:@"parameters"];
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"codeLine" propertyClass:[FLCodeElement class]] forContainerProperty:@"codeLines"];
}
@synthesize isPrivate = _isPrivate;
@synthesize isStatic = _isStatic;
@synthesize name = _name;
FLSynthesizeLazyGetter(parameters, NSMutableArray, _parameters);
@synthesize parameters = _parameters;
@synthesize returnType = _returnType;

@end
