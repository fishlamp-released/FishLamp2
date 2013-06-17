// 
// FLCodeConstructorBaseClass.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/16/13 5:55 PM with PackMule (3.0.0.29)
// 
// Project: FishLamp Code Generator
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLCodeConstructorBaseClass.h"
#import "FLModelObject.h"
#import "FLCodeElement.h"
#import "FLObjectDescriber.h"
#import "FLCodeConstructorParameter.h"

@implementation FLCodeConstructorBaseClass

#if FL_MRC
- (void) dealloc {
    [_lines release];
    [_parameters release];
    [super dealloc];
}
#endif
+ (void) didRegisterObjectDescriber:(FLObjectDescriber*) describer {
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"line" propertyClass:[FLCodeElement class]] forContainerProperty:@"lines"];
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"parameter" propertyClass:[FLCodeConstructorParameter class]] forContainerProperty:@"parameters"];
}
FLSynthesizeLazyGetter(lines, NSMutableArray, _lines);
@synthesize lines = _lines;
FLSynthesizeLazyGetter(parameters, NSMutableArray, _parameters);
@synthesize parameters = _parameters;

@end
