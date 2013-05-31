// 
// FLWsdlElementBaseType.h
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
@class FLWsdlComplexType;
@class FLWsdlElement;
@class FLObjectDescriber;
@class FLWsdlSimpleType;
@interface FLWsdlElementBaseType : FLModelObject {
@private
    NSMutableArray* _simpleTypes;
    NSMutableArray* _complexTypes;
    NSMutableArray* _elements;
}

@property (readwrite, strong, nonatomic) NSMutableArray* simpleTypes;
@property (readwrite, strong, nonatomic) NSMutableArray* complexTypes;
@property (readwrite, strong, nonatomic) NSMutableArray* elements;
+(FLWsdlElementBaseType*) wsdlElementBaseType;
@end