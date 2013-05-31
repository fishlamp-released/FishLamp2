// 
// FLWsdlElementBaseType.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/29/13 1:04 PM with PackMule (3.0.0.1)
// 
// Project: FishLamp CodeWriter WSDL Interpreter
// Schema: FLWsdlObjects
// 
// Copyright 2013 (c) GreenTongue Software, LLC
// 

#import "FLWsdlElementBaseType.h"
#import "FLWsdlComplexType.h"
#import "FLWsdlElement.h"
#import "FLModelObject.h"
#import "FLObjectDescriber.h"
#import "FLWsdlSimpleType.h"
@implementation FLWsdlElementBaseType
@synthesize simpleTypes = _simpleTypes;
@synthesize complexTypes = _complexTypes;
@synthesize elements = _elements;
+(void) didRegisterObjectDescriber:(FLObjectDescriber*) describer {
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"simpleType" propertyClass:[FLWsdlSimpleType class]] forContainerProperty:@"simpleTypes"];
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"complexType" propertyClass:[FLWsdlComplexType class]] forContainerProperty:@"complexTypes"];
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"element" propertyClass:[FLWsdlElement class]] forContainerProperty:@"elements"];
}
+(FLWsdlElementBaseType*) wsdlElementBaseType {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_simpleTypes release];
    [_complexTypes release];
    [_elements release];
    [super dealloc];
}
#endif
@end
