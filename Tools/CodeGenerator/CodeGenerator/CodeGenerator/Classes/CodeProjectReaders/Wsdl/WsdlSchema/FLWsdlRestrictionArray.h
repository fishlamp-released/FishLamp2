// 
// FLWsdlRestrictionArray.h
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
@class FLWsdlEnumeration;
@class FLObjectDescriber;
@class FLWsdlSequenceArray;
@interface FLWsdlRestrictionArray : FLModelObject {
@private
    NSString* _base;
    FLWsdlSequenceArray* _sequence;
    NSMutableArray* _enumerations;
}

@property (readwrite, strong, nonatomic) NSString* base;
@property (readwrite, strong, nonatomic) FLWsdlSequenceArray* sequence;
@property (readwrite, strong, nonatomic) NSMutableArray* enumerations;
+(FLWsdlRestrictionArray*) wsdlRestrictionArray;
@end
