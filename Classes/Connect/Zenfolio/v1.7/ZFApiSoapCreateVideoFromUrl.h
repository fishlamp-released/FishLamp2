// 
// ZFApiSoapCreateVideoFromUrl.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/30/13 6:24 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLModelObject.h"
@class ZFCreateVideoFromUrlResponse;
#import "FLHttpRequestDescriptor.h"
@class ZFCreateVideoFromUrl;
@interface ZFApiSoapCreateVideoFromUrl : FLModelObject<FLHttpRequestDescriptor> {
@private
    ZFCreateVideoFromUrl* _input;
    ZFCreateVideoFromUrlResponse* _output;
}

@property (readwrite, strong, nonatomic) ZFCreateVideoFromUrlResponse* output;
@property (readonly, strong, nonatomic) NSString* targetNamespace;
@property (readwrite, strong, nonatomic) ZFCreateVideoFromUrl* input;
@property (readonly, strong, nonatomic) NSString* soapAction;
@property (readonly, strong, nonatomic) NSString* location;
@property (readonly, strong, nonatomic) NSString* operationName;
+ (ZFApiSoapCreateVideoFromUrl*) apiSoapCreateVideoFromUrl;
@end
