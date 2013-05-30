// 
// ZFApiHttpPostGetRecentPhotos.h
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
@class ZFGetRecentPhotosHttpPostIn;
@class ZFPhoto;
#import "FLHttpRequestDescriptor.h"
@class FLObjectDescriber;
@interface ZFApiHttpPostGetRecentPhotos : FLModelObject<FLHttpRequestDescriptor> {
@private
    ZFGetRecentPhotosHttpPostIn* _input;
    NSMutableArray* _output;
}

@property (readonly, strong, nonatomic) NSString* targetNamespace;
@property (readwrite, strong, nonatomic) ZFGetRecentPhotosHttpPostIn* input;
@property (readwrite, strong, nonatomic) NSMutableArray* output;
@property (readonly, strong, nonatomic) NSString* location;
@property (readonly, strong, nonatomic) NSString* operationName;
+(ZFApiHttpPostGetRecentPhotos*) apiHttpPostGetRecentPhotos;
@end
