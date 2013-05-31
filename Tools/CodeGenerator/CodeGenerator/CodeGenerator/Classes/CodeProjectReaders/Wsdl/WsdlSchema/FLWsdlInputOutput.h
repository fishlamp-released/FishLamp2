// 
// FLWsdlInputOutput.h
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
@class FLWsdlContent;
@class FLWsdlMime;
@class FLWsdlMessageBody;
@interface FLWsdlInputOutput : FLModelObject {
@private
    FLWsdlMessageBody* _body;
    NSString* _message;
    FLWsdlContent* _content;
    NSString* _type;
    NSString* _urlEncoded;
    FLWsdlMime* _mimeXml;
}

@property (readwrite, strong, nonatomic) FLWsdlMessageBody* body;
@property (readwrite, strong, nonatomic) NSString* message;
@property (readwrite, strong, nonatomic) FLWsdlContent* content;
@property (readwrite, strong, nonatomic) NSString* type;
@property (readwrite, strong, nonatomic) NSString* urlEncoded;
@property (readwrite, strong, nonatomic) FLWsdlMime* mimeXml;
+(FLWsdlInputOutput*) wsdlInputOutput;
@end