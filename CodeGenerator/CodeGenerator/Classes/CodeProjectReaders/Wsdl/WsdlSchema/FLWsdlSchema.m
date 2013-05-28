// 
// FLWsdlSchema.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// 
// Project: FishLamp CodeWriter WSDL Interpreter
// Schema: FLWsdlObjects
// 
// Generated by: Mike Fullerton @ 5/14/13 1:05 PM with PackMule (3.0.0.1)
// 
// Organization: GreenTongue Software, LLC
// 
// Copywrite (C) 2013 GreenTongue Software, LLC. All rights reserved.
// 
#import "FLWsdlSchema.h"
#import "FLWsdlImport.h"
#import "FLObjectDescriber.h"
@implementation FLWsdlSchema
@synthesize import = _import;
@synthesize elementFormDefault = _elementFormDefault;
@synthesize targetNamespace = _targetNamespace;
+(void) didRegisterObjectDescriber:(FLObjectDescriber*) describer {
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"import" propertyClass:[FLWsdlImport class]] forContainerProperty:@"import"];
}
+(FLWsdlSchema*) wsdlSchema {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_import release];
    [_elementFormDefault release];
    [_targetNamespace release];
    [super dealloc];
}
#endif
@end
