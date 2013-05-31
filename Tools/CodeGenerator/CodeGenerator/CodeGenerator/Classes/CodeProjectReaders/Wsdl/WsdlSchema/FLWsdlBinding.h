// 
// FLWsdlBinding.h
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
@class FLWsdlBinding;
@class FLObjectDescriber;
@class FLWsdlOperation;
@interface FLWsdlBinding : FLModelObject {
@private
    NSMutableArray* _operations;
    NSString* _style;
    NSString* _verb;
    NSString* _transport;
    NSString* _type;
    NSString* _name;
    NSMutableArray* _bindings;
}

@property (readwrite, strong, nonatomic) NSMutableArray* operations;
@property (readwrite, strong, nonatomic) NSString* style;
@property (readwrite, strong, nonatomic) NSString* verb;
@property (readwrite, strong, nonatomic) NSString* transport;
@property (readwrite, strong, nonatomic) NSString* type;
@property (readwrite, strong, nonatomic) NSString* name;
@property (readwrite, strong, nonatomic) NSMutableArray* bindings;
+(FLWsdlBinding*) wsdlBinding;
@end
