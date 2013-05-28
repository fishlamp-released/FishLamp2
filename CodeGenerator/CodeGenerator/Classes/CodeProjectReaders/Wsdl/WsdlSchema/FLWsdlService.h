// 
// FLWsdlService.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/28/13 4:39 PM with PackMule (3.0.0.1)
// 
// Project: FishLamp CodeWriter WSDL Interpreter
// Schema: FLWsdlObjects
// 
// Copyright 2013 (c) GreenTongue Software, LLC
// 

#import "FLModelObject.h"
@class FLObjectDescriber;
@class FLWsdlPortType;
@interface FLWsdlService : FLModelObject {
@private
    NSString* _name;
    NSMutableArray* _ports;
    NSString* _documentation;
}

@property (readwrite, strong, nonatomic) NSString* name;
@property (readwrite, strong, nonatomic) NSMutableArray* ports;
@property (readwrite, strong, nonatomic) NSString* documentation;
+(FLWsdlService*) wsdlService;
@end
