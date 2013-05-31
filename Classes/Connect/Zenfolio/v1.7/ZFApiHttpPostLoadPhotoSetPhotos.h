// 
// ZFApiHttpPostLoadPhotoSetPhotos.h
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
@class ZFPhoto;
#import "FLHttpRequestDescriptor.h"
@class ZFLoadPhotoSetPhotosHttpPostIn;
@class FLObjectDescriber;
@interface ZFApiHttpPostLoadPhotoSetPhotos : FLModelObject<FLHttpRequestDescriptor> {
@private
    ZFLoadPhotoSetPhotosHttpPostIn* _input;
    NSMutableArray* _output;
}

@property (readonly, strong, nonatomic) NSString* targetNamespace;
@property (readwrite, strong, nonatomic) ZFLoadPhotoSetPhotosHttpPostIn* input;
@property (readwrite, strong, nonatomic) NSMutableArray* output;
@property (readonly, strong, nonatomic) NSString* location;
@property (readonly, strong, nonatomic) NSString* operationName;
+ (ZFApiHttpPostLoadPhotoSetPhotos*) apiHttpPostLoadPhotoSetPhotos;
@end