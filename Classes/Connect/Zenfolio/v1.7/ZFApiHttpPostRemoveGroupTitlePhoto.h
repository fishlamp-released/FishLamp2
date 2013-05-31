// 
// ZFApiHttpPostRemoveGroupTitlePhoto.h
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
@class ZFRemoveGroupTitlePhotoHttpPostOut;
#import "FLHttpRequestDescriptor.h"
@class ZFRemoveGroupTitlePhotoHttpPostIn;
@interface ZFApiHttpPostRemoveGroupTitlePhoto : FLModelObject<FLHttpRequestDescriptor> {
@private
    ZFRemoveGroupTitlePhotoHttpPostIn* _input;
    ZFRemoveGroupTitlePhotoHttpPostOut* _output;
}

@property (readonly, strong, nonatomic) NSString* targetNamespace;
@property (readwrite, strong, nonatomic) ZFRemoveGroupTitlePhotoHttpPostIn* input;
@property (readwrite, strong, nonatomic) ZFRemoveGroupTitlePhotoHttpPostOut* output;
@property (readonly, strong, nonatomic) NSString* location;
@property (readonly, strong, nonatomic) NSString* operationName;
+ (ZFApiHttpPostRemoveGroupTitlePhoto*) apiHttpPostRemoveGroupTitlePhoto;
@end