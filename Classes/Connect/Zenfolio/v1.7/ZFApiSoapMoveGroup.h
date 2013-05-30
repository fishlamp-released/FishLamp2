// 
// ZFApiSoapMoveGroup.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/30/13 4:42 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLModelObject.h"
@class ZFMoveGroupResponse;
#import "FLHttpRequestDescriptor.h"
@class ZFMoveGroup;
@interface ZFApiSoapMoveGroup : FLModelObject<FLHttpRequestDescriptor> {
@private
    ZFMoveGroup* _input;
    ZFMoveGroupResponse* _output;
}

@property (readwrite, strong, nonatomic) ZFMoveGroupResponse* output;
@property (readonly, strong, nonatomic) NSString* targetNamespace;
@property (readwrite, strong, nonatomic) ZFMoveGroup* input;
@property (readonly, strong, nonatomic) NSString* soapAction;
@property (readonly, strong, nonatomic) NSString* location;
@property (readonly, strong, nonatomic) NSString* operationName;
+(ZFApiSoapMoveGroup*) apiSoapMoveGroup;
@end
