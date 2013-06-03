// 
// ZFApiHttpPostRotatePhoto.h
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

@class ZFPhoto;
@class ZFRotatePhotoHttpPostIn;

@interface ZFApiHttpPostRotatePhoto : FLModelObject<FLHttpRequestDescriptor> {
@private
    ZFRotatePhotoHttpPostIn* _input;
    ZFPhoto* _output;
}

@property (readwrite, strong, nonatomic) ZFRotatePhotoHttpPostIn* input;
@property (readonly, strong, nonatomic) NSString* location;
@property (readonly, strong, nonatomic) NSString* operationName;
@property (readwrite, strong, nonatomic) ZFPhoto* output;
@property (readonly, strong, nonatomic) NSString* targetNamespace;

+ (ZFApiHttpPostRotatePhoto*) apiHttpPostRotatePhoto;

@end
