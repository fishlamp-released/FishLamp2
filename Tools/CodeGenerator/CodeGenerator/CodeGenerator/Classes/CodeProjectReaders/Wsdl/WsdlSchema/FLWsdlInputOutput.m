// 
// FLWsdlInputOutput.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/29/13 1:04 PM with PackMule (3.0.0.1)
// 
// Project: FishLamp CodeWriter WSDL Interpreter
// Schema: FLWsdlObjects
// 
// Copyright 2013 (c) GreenTongue Software, LLC
// 

#import "FLWsdlInputOutput.h"
#import "FLWsdlContent.h"
#import "FLWsdlMime.h"
#import "FLModelObject.h"
#import "FLWsdlMessageBody.h"
@implementation FLWsdlInputOutput
@synthesize body = _body;
@synthesize message = _message;
@synthesize content = _content;
@synthesize type = _type;
@synthesize urlEncoded = _urlEncoded;
@synthesize mimeXml = _mimeXml;
+(FLWsdlInputOutput*) wsdlInputOutput {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_body release];
    [_message release];
    [_content release];
    [_type release];
    [_urlEncoded release];
    [_mimeXml release];
    [super dealloc];
}
#endif
@end