// 
// FLWsdlSchema.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/28/13 4:39 PM with PackMule (3.0.0.1)
// 
// Project: FishLamp CodeWriter WSDL Interpreter
// Schema: FLWsdlObjects
// 
// Copyright 2013 (c) GreenTongue Software, LLC
// 

#import "FLWsdlSchema.h"
#import "FLWsdlImport.h"
#import "FLObjectDescriber.h"
#import "FLWsdlElementBaseType.h"
@implementation FLWsdlSchema
@synthesize imports = _imports;
@synthesize elementFormDefault = _elementFormDefault;
@synthesize targetNamespace = _targetNamespace;
+(void) didRegisterObjectDescriber:(FLObjectDescriber*) describer {
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"import" propertyClass:[FLWsdlImport class]] forContainerProperty:@"imports"];
}
+(FLWsdlSchema*) wsdlSchema {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_imports release];
    [_elementFormDefault release];
    [_targetNamespace release];
    [super dealloc];
}
#endif
@end
