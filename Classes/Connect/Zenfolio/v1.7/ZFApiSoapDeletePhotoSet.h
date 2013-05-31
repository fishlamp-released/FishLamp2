// 
// ZFApiSoapDeletePhotoSet.h
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
@class ZFDeletePhotoSetResponse;
#import "FLHttpRequestDescriptor.h"
@class ZFDeletePhotoSet;
@interface ZFApiSoapDeletePhotoSet : FLModelObject<FLHttpRequestDescriptor> {
@private
    ZFDeletePhotoSet* _input;
    ZFDeletePhotoSetResponse* _output;
}

@property (readwrite, strong, nonatomic) ZFDeletePhotoSetResponse* output;
@property (readonly, strong, nonatomic) NSString* targetNamespace;
@property (readwrite, strong, nonatomic) ZFDeletePhotoSet* input;
@property (readonly, strong, nonatomic) NSString* soapAction;
@property (readonly, strong, nonatomic) NSString* location;
@property (readonly, strong, nonatomic) NSString* operationName;
+ (ZFApiSoapDeletePhotoSet*) apiSoapDeletePhotoSet;
@end