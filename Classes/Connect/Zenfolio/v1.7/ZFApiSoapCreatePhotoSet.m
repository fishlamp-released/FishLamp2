// 
// ZFApiSoapCreatePhotoSet.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/30/13 2:36 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "ZFApiSoapCreatePhotoSet.h"
#import "ZFCreatePhotoSet.h"
#import "FLModelObject.h"
#import "FLHttpRequestDescriptor.h"
#import "ZFCreatePhotoSetResponse.h"
@implementation ZFApiSoapCreatePhotoSet
@synthesize output = _output;
-(NSString*) targetNamespace {
    return @"http://www.zenfolio.com/api/1.7";
}
@synthesize input = _input;
-(NSString*) soapAction {
    return @"http://www.zenfolio.com/api/1.7/CreatePhotoSet";
}
-(NSString*) location {
    return @"http://api.zenfolio.com/api/1.7/zfapi.asmx";
}
-(NSString*) operationName {
    return @"CreatePhotoSet";
}
+(ZFApiSoapCreatePhotoSet*) apiSoapCreatePhotoSet {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_input release];
    [_output release];
    [super dealloc];
}
#endif
@end
