// 
// FLWsdlImport.h
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
@interface FLWsdlImport : FLModelObject {
@private
    NSString* _namespace;
    NSString* _import;
}

@property (readwrite, strong, nonatomic) NSString* namespace;
@property (readwrite, strong, nonatomic) NSString* import;
+(FLWsdlImport*) wsdlImport;
@end
