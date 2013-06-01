// 
// ZFApiSoapCreateGroup.h
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
@class ZFCreateGroupResponse;
#import "FLHttpRequestDescriptor.h"
@class ZFCreateGroup;
@interface ZFApiSoapCreateGroup : FLModelObject<FLHttpRequestDescriptor> {
@private
    ZFCreateGroup* _input;
    ZFCreateGroupResponse* _output;
}

@property (readwrite, strong, nonatomic) ZFCreateGroupResponse* output;
@property (readonly, strong, nonatomic) NSString* targetNamespace;
@property (readwrite, strong, nonatomic) ZFCreateGroup* input;
@property (readonly, strong, nonatomic) NSString* soapAction;
@property (readonly, strong, nonatomic) NSString* location;
@property (readonly, strong, nonatomic) NSString* operationName;
+ (ZFApiSoapCreateGroup*) apiSoapCreateGroup;
@end
