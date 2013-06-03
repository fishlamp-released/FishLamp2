// 
// FLWsdlInputOutput.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/2/13 5:36 PM with PackMule (3.0.0.100)
// 
// Project: FishLamp CodeWriter WSDL Interpreter
// Schema: FLWsdlObjects
// 
// Copyright 2013 (c) GreenTongue Software, LLC
// 


#import "FLWsdlMime.h"
#import "FLWsdlMessageBody.h"
#import "FLModelObject.h"
#import "FLWsdlInputOutput.h"
#import "FLWsdlContent.h"

@implementation FLWsdlInputOutput

@synthesize body = _body;
@synthesize content = _content;
#if FL_MRC
- (void) dealloc {
    [_body release];
    [_message release];
    [_content release];
    [_mimeXml release];
    [_type release];
    [_urlEncoded release];
    [super dealloc];
}
#endif
@synthesize message = _message;
@synthesize mimeXml = _mimeXml;
@synthesize type = _type;
@synthesize urlEncoded = _urlEncoded;
+ (FLWsdlInputOutput*) wsdlInputOutput {
    return FLAutorelease([[[self class] alloc] init]);
}

@end
