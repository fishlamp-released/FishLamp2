// 
// ZFApiSoapSearchSetByCategory.h
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
#import "FLHttpRequestDescriptor.h"
@class ZFSearchSetByCategory;
@class ZFSearchSetByCategoryResponse;
@interface ZFApiSoapSearchSetByCategory : FLModelObject<FLHttpRequestDescriptor> {
@private
    ZFSearchSetByCategory* _input;
    ZFSearchSetByCategoryResponse* _output;
}

@property (readwrite, strong, nonatomic) ZFSearchSetByCategoryResponse* output;
@property (readonly, strong, nonatomic) NSString* targetNamespace;
@property (readwrite, strong, nonatomic) ZFSearchSetByCategory* input;
@property (readonly, strong, nonatomic) NSString* soapAction;
@property (readonly, strong, nonatomic) NSString* location;
@property (readonly, strong, nonatomic) NSString* operationName;
+ (ZFApiSoapSearchSetByCategory*) apiSoapSearchSetByCategory;
@end
