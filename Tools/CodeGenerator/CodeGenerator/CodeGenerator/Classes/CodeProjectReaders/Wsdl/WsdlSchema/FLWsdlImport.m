// 
// FLWsdlImport.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/29/13 1:04 PM with PackMule (3.0.0.1)
// 
// Project: FishLamp CodeWriter WSDL Interpreter
// Schema: FLWsdlObjects
// 
// Copyright 2013 (c) GreenTongue Software, LLC
// 

#import "FLWsdlImport.h"
#import "FLModelObject.h"
@implementation FLWsdlImport
@synthesize namespace = _namespace;
@synthesize import = _import;
+(FLWsdlImport*) wsdlImport {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_namespace release];
    [_import release];
    [super dealloc];
}
#endif
@end
