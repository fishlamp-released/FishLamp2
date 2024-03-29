// 
// ZFApiSoapGetDownloadOriginalKey.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/3/13 10:43 AM with PackMule (3.0.1.100)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLModelObject.h"
#import "FLHttpRequestDescriptor.h"

@class ZFGetDownloadOriginalKeyResponse;
@class ZFGetDownloadOriginalKey;

@interface ZFApiSoapGetDownloadOriginalKey : FLModelObject<FLHttpRequestDescriptor> {
@private
    ZFGetDownloadOriginalKey* _input;
    ZFGetDownloadOriginalKeyResponse* _output;
}

@property (readwrite, strong, nonatomic) ZFGetDownloadOriginalKey* input;
@property (readonly, strong, nonatomic) NSString* location;
@property (readonly, strong, nonatomic) NSString* operationName;
@property (readwrite, strong, nonatomic) ZFGetDownloadOriginalKeyResponse* output;
@property (readonly, strong, nonatomic) NSString* soapAction;
@property (readonly, strong, nonatomic) NSString* targetNamespace;

+ (ZFApiSoapGetDownloadOriginalKey*) apiSoapGetDownloadOriginalKey;

@end
