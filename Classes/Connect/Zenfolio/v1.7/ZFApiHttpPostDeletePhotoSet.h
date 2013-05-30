// 
// ZFApiHttpPostDeletePhotoSet.h
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
@class ZFDeletePhotoSetHttpPostIn;
@class ZFDeletePhotoSetHttpPostOut;
#import "FLHttpRequestDescriptor.h"
@interface ZFApiHttpPostDeletePhotoSet : FLModelObject<FLHttpRequestDescriptor> {
@private
    ZFDeletePhotoSetHttpPostIn* _input;
    ZFDeletePhotoSetHttpPostOut* _output;
}

@property (readonly, strong, nonatomic) NSString* targetNamespace;
@property (readwrite, strong, nonatomic) ZFDeletePhotoSetHttpPostIn* input;
@property (readwrite, strong, nonatomic) ZFDeletePhotoSetHttpPostOut* output;
@property (readonly, strong, nonatomic) NSString* location;
@property (readonly, strong, nonatomic) NSString* operationName;
+(ZFApiHttpPostDeletePhotoSet*) apiHttpPostDeletePhotoSet;
@end
