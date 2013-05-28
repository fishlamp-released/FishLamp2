// 
// FLWsdlElementBaseType.h
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
#import "FLModelObject.h"
@class FLWsdlElement;
@class FLObjectDescriber;
@class FLWsdlSimpleType;
@class FLWsdlComplexType;
@interface FLWsdlElementBaseType : FLModelObject {
@private
    NSMutableArray* _element;
    NSMutableArray* _simpleType;
    NSMutableArray* _complexType;
}

@property (readwrite, strong, nonatomic) NSMutableArray* element;
@property (readwrite, strong, nonatomic) NSMutableArray* simpleType;
@property (readwrite, strong, nonatomic) NSMutableArray* complexType;
+(FLWsdlElementBaseType*) wsdlElementBaseType;
@end
