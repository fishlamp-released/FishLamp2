// 
// ZFApiSoapUpdatePhotoAccess.h
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
@class ZFUpdatePhotoAccess;
#import "FLHttpRequestDescriptor.h"
@class ZFUpdatePhotoAccessResponse;
@interface ZFApiSoapUpdatePhotoAccess : FLModelObject<FLHttpRequestDescriptor> {
@private
    ZFUpdatePhotoAccess* _input;
    ZFUpdatePhotoAccessResponse* _output;
}

@property (readwrite, strong, nonatomic) ZFUpdatePhotoAccessResponse* output;
@property (readonly, strong, nonatomic) NSString* targetNamespace;
@property (readwrite, strong, nonatomic) ZFUpdatePhotoAccess* input;
@property (readonly, strong, nonatomic) NSString* soapAction;
@property (readonly, strong, nonatomic) NSString* location;
@property (readonly, strong, nonatomic) NSString* operationName;
+ (ZFApiSoapUpdatePhotoAccess*) apiSoapUpdatePhotoAccess;
@end