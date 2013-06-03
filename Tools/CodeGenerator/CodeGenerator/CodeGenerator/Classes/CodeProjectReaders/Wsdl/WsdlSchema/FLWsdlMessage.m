// 
// FLWsdlMessage.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/2/13 5:36 PM with PackMule (3.0.0.100)
// 
// Project: FishLamp CodeWriter WSDL Interpreter
// Schema: FLWsdlObjects
// 
// Copyright 2013 (c) GreenTongue Software, LLC
// 


#import "FLWsdlMessage.h"
#import "FLModelObject.h"
#import "FLWsdlPart.h"
#import "FLObjectDescriber.h"

@implementation FLWsdlMessage

#if FL_MRC
- (void) dealloc {
    [_name release];
    [_parts release];
    [super dealloc];
}
#endif
+ (void) didRegisterObjectDescriber:(FLObjectDescriber*) describer {
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"part" propertyClass:[FLWsdlPart class]] forContainerProperty:@"parts"];
}
@synthesize name = _name;
@synthesize parts = _parts;
+ (FLWsdlMessage*) wsdlMessage {
    return FLAutorelease([[[self class] alloc] init]);
}

@end
