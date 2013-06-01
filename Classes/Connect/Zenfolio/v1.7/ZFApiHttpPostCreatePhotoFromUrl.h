// 
// ZFApiHttpPostCreatePhotoFromUrl.h
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
@class ZFCreatePhotoFromUrlHttpPostIn;
#import "FLHttpRequestDescriptor.h"
@interface ZFApiHttpPostCreatePhotoFromUrl : FLModelObject<FLHttpRequestDescriptor> {
@private
    ZFCreatePhotoFromUrlHttpPostIn* _input;
    long _output;
}

@property (readonly, strong, nonatomic) NSString* targetNamespace;
@property (readwrite, strong, nonatomic) ZFCreatePhotoFromUrlHttpPostIn* input;
@property (readwrite, assign, nonatomic) long output;
@property (readonly, strong, nonatomic) NSString* location;
@property (readonly, strong, nonatomic) NSString* operationName;
+ (ZFApiHttpPostCreatePhotoFromUrl*) apiHttpPostCreatePhotoFromUrl;
@end
