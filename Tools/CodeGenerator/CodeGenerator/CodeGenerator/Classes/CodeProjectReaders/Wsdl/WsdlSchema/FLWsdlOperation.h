// 
// FLWsdlOperation.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/29/13 1:04 PM with PackMule (3.0.0.1)
// 
// Project: FishLamp CodeWriter WSDL Interpreter
// Schema: FLWsdlObjects
// 
// Copyright 2013 (c) GreenTongue Software, LLC
// 

#import "FLModelObject.h"
@class FLWsdlInputOutput;
@class FLWsdlOperation;
@interface FLWsdlOperation : FLModelObject {
@private
    FLWsdlInputOutput* _output;
    FLWsdlInputOutput* _input;
    NSString* _style;
    NSString* _location;
    NSString* _documentation;
    FLWsdlOperation* _operation;
    NSString* _name;
    NSString* _soapAction;
}

@property (readwrite, strong, nonatomic) FLWsdlInputOutput* output;
@property (readwrite, strong, nonatomic) FLWsdlInputOutput* input;
@property (readwrite, strong, nonatomic) NSString* style;
@property (readwrite, strong, nonatomic) NSString* location;
@property (readwrite, strong, nonatomic) NSString* documentation;
@property (readwrite, strong, nonatomic) FLWsdlOperation* operation;
@property (readwrite, strong, nonatomic) NSString* name;
@property (readwrite, strong, nonatomic) NSString* soapAction;
+(FLWsdlOperation*) wsdlOperation;
@end