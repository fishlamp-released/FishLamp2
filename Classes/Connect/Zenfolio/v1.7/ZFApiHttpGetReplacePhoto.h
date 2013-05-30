// 
// ZFApiHttpGetReplacePhoto.h
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
@class ZFReplacePhotoHttpGetIn;
#import "FLHttpRequestDescriptor.h"
@class ZFReplacePhotoHttpGetOut;
@interface ZFApiHttpGetReplacePhoto : FLModelObject<FLHttpRequestDescriptor> {
@private
    ZFReplacePhotoHttpGetIn* _input;
    ZFReplacePhotoHttpGetOut* _output;
}

@property (readonly, strong, nonatomic) NSString* targetNamespace;
@property (readwrite, strong, nonatomic) ZFReplacePhotoHttpGetIn* input;
@property (readwrite, strong, nonatomic) ZFReplacePhotoHttpGetOut* output;
@property (readonly, strong, nonatomic) NSString* location;
@property (readonly, strong, nonatomic) NSString* operationName;
+(ZFApiHttpGetReplacePhoto*) apiHttpGetReplacePhoto;
@end
