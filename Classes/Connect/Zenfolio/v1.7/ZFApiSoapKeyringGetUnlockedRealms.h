// 
// ZFApiSoapKeyringGetUnlockedRealms.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/2/13 4:12 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLModelObject.h"
#import "FLHttpRequestDescriptor.h"

@class ZFKeyringGetUnlockedRealms;
@class ZFKeyringGetUnlockedRealmsResponse;

@interface ZFApiSoapKeyringGetUnlockedRealms : FLModelObject<FLHttpRequestDescriptor> {
@private
    ZFKeyringGetUnlockedRealms* _input;
    ZFKeyringGetUnlockedRealmsResponse* _output;
}

@property (readwrite, strong, nonatomic) ZFKeyringGetUnlockedRealms* input;
@property (readonly, strong, nonatomic) NSString* location;
@property (readonly, strong, nonatomic) NSString* operationName;
@property (readwrite, strong, nonatomic) ZFKeyringGetUnlockedRealmsResponse* output;
@property (readonly, strong, nonatomic) NSString* soapAction;
@property (readonly, strong, nonatomic) NSString* targetNamespace;

+ (ZFApiSoapKeyringGetUnlockedRealms*) apiSoapKeyringGetUnlockedRealms;

@end
