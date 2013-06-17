// 
// FLCodeSequenceBaseClass.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/16/13 5:22 PM with PackMule (3.0.0.29)
// 
// Project: FishLamp Code Generator
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLCodeSequenceBaseClass.h"
#import "FLModelObject.h"
#import "FLObjectDescriber.h"
#import "FLCodeElement.h"

@implementation FLCodeSequenceBaseClass

#if FL_MRC
- (void) dealloc {
    [_statements release];
    [super dealloc];
}
#endif
+ (void) didRegisterObjectDescriber:(FLObjectDescriber*) describer {
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"statement" propertyClass:[FLCodeElement class]] forContainerProperty:@"statements"];
}
FLSynthesizeLazyGetter(statements, NSMutableArray, _statements);
@synthesize statements = _statements;

@end
