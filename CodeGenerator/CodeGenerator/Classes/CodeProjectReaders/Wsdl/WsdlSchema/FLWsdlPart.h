// 
// FLWsdlPart.h
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
@interface FLWsdlPart : FLModelObject {
@private
    NSString* _name;
    NSString* _element;
    NSString* _type;
}

@property (readwrite, strong, nonatomic) NSString* name;
@property (readwrite, strong, nonatomic) NSString* element;
@property (readwrite, strong, nonatomic) NSString* type;
+(FLWsdlPart*) wsdlPart;
@end
