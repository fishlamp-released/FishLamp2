// 
// FLWsdlDefinitions.h
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
@class FLWsdlMessage;
@class FLWsdlService;
@class FLWsdlSchema;
@class FLObjectDescriber;
@class FLWsdlPortType;
@class FLWsdlBinding;
@interface FLWsdlDefinitions : FLModelObject {
@private
    FLWsdlService* _service;
    NSString* _documentation;
    NSMutableArray* _messages;
    NSMutableArray* _types;
    NSString* _targetNamespace;
    NSMutableArray* _portTypes;
    NSMutableArray* _bindings;
}

@property (readwrite, strong, nonatomic) FLWsdlService* service;
@property (readwrite, strong, nonatomic) NSString* documentation;
@property (readwrite, strong, nonatomic) NSMutableArray* messages;
@property (readwrite, strong, nonatomic) NSMutableArray* types;
@property (readwrite, strong, nonatomic) NSString* targetNamespace;
@property (readwrite, strong, nonatomic) NSMutableArray* portTypes;
@property (readwrite, strong, nonatomic) NSMutableArray* bindings;
+(FLWsdlDefinitions*) wsdlDefinitions;
@end
