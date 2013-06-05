// 
// FLWsdlSimpleType.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/2/13 5:36 PM with PackMule (3.0.0.100)
// 
// Project: FishLamp CodeWriter WSDL Interpreter
// Schema: FLWsdlObjects
// 
// Copyright 2013 (c) GreenTongue Software, LLC
// 


#import "FLWsdlList.h"
#import "FLWsdlSimpleType.h"
#import "FLWsdlRestrictionArray.h"
#import "FLModelObject.h"

@implementation FLWsdlSimpleType

#if FL_MRC
- (void) dealloc {
    [_name release];
    [_restriction release];
    [_list release];
    [super dealloc];
}
#endif
@synthesize list = _list;
@synthesize name = _name;
@synthesize restriction = _restriction;
+ (FLWsdlSimpleType*) wsdlSimpleType {
    return FLAutorelease([[[self class] alloc] init]);
}

@end