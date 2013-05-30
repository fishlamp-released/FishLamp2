// 
// ZFApiSoapKeyringAddKeyPlain.h
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

#import "FLModelObject.h"
@class ZFKeyringAddKeyPlain;
#import "FLHttpRequestDescriptor.h"
@class ZFKeyringAddKeyPlainResponse;
@interface ZFApiSoapKeyringAddKeyPlain : FLModelObject<FLHttpRequestDescriptor> {
@private
    ZFKeyringAddKeyPlain* _input;
    ZFKeyringAddKeyPlainResponse* _output;
}

@property (readwrite, strong, nonatomic) ZFKeyringAddKeyPlainResponse* output;
@property (readonly, strong, nonatomic) NSString* targetNamespace;
@property (readwrite, strong, nonatomic) ZFKeyringAddKeyPlain* input;
@property (readonly, strong, nonatomic) NSString* soapAction;
@property (readonly, strong, nonatomic) NSString* location;
@property (readonly, strong, nonatomic) NSString* operationName;
+(ZFApiSoapKeyringAddKeyPlain*) apiSoapKeyringAddKeyPlain;
@end
