// 
// FLWsdlChoiceArray.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/2/13 5:36 PM with PackMule (3.0.0.100)
// 
// Project: FishLamp CodeWriter WSDL Interpreter
// Schema: FLWsdlObjects
// 
// Copyright 2013 (c) GreenTongue Software, LLC
// 


#import "FLWsdlChoiceArray.h"
#import "FLWsdlElement.h"
#import "FLModelObject.h"
#import "FLObjectDescriber.h"

@implementation FLWsdlChoiceArray

#if FL_MRC
- (void) dealloc {
    [_maxOccurs release];
    [_elements release];
    [_minOccurs release];
    [super dealloc];
}
#endif
+ (void) didRegisterObjectDescriber:(FLObjectDescriber*) describer {
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"element" propertyClass:[FLWsdlElement class]] forContainerProperty:@"elements"];
}
@synthesize elements = _elements;
@synthesize maxOccurs = _maxOccurs;
@synthesize minOccurs = _minOccurs;
+ (FLWsdlChoiceArray*) wsdlChoiceArray {
    return FLAutorelease([[[self class] alloc] init]);
}

@end