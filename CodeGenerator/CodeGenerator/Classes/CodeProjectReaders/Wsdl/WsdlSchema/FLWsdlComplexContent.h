// 
// FLWsdlComplexContent.h
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
@class FLWsdlRestrictionArray;
@class FLWsdlExtension;
@interface FLWsdlComplexContent : FLModelObject {
@private
    NSString* _mixed;
    FLWsdlExtension* _extension;
    FLWsdlRestrictionArray* _restriction;
}

@property (readwrite, strong, nonatomic) NSString* mixed;
@property (readwrite, strong, nonatomic) FLWsdlExtension* extension;
@property (readwrite, strong, nonatomic) FLWsdlRestrictionArray* restriction;
+(FLWsdlComplexContent*) wsdlComplexContent;
@end
