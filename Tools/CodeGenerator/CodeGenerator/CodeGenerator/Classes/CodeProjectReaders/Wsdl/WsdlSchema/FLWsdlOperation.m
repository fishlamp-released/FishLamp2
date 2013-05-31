// 
// FLWsdlOperation.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/29/13 1:04 PM with PackMule (3.0.0.1)
// 
// Project: FishLamp CodeWriter WSDL Interpreter
// Schema: FLWsdlObjects
// 
// Copyright 2013 (c) GreenTongue Software, LLC
// 

#import "FLWsdlOperation.h"
#import "FLWsdlInputOutput.h"
#import "FLModelObject.h"
#import "FLWsdlOperation.h"
@implementation FLWsdlOperation
@synthesize output = _output;
@synthesize input = _input;
@synthesize style = _style;
@synthesize location = _location;
@synthesize documentation = _documentation;
@synthesize operation = _operation;
@synthesize name = _name;
@synthesize soapAction = _soapAction;
+(FLWsdlOperation*) wsdlOperation {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_output release];
    [_input release];
    [_style release];
    [_location release];
    [_documentation release];
    [_operation release];
    [_name release];
    [_soapAction release];
    [super dealloc];
}
#endif
@end
