// 
// ZFApiSoapGetChallenge.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/31/13 7:38 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLModelObject.h"
@class ZFGetChallenge;
#import "FLHttpRequestDescriptor.h"
@class ZFGetChallengeResponse;
@interface ZFApiSoapGetChallenge : FLModelObject<FLHttpRequestDescriptor> {
@private
    ZFGetChallenge* _input;
    ZFGetChallengeResponse* _output;
}

@property (readwrite, strong, nonatomic) ZFGetChallengeResponse* output;
@property (readonly, strong, nonatomic) NSString* targetNamespace;
@property (readwrite, strong, nonatomic) ZFGetChallenge* input;
@property (readonly, strong, nonatomic) NSString* soapAction;
@property (readonly, strong, nonatomic) NSString* location;
@property (readonly, strong, nonatomic) NSString* operationName;
+ (ZFApiSoapGetChallenge*) apiSoapGetChallenge;
@end
