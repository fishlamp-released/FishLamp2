// 
// ZFApiHttpPostGetVideoPlaybackUrl.h
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
@class ZFGetVideoPlaybackUrlHttpPostIn;
@interface ZFApiHttpPostGetVideoPlaybackUrl : FLModelObject<FLHttpRequestDescriptor> {
@private
    ZFGetVideoPlaybackUrlHttpPostIn* _input;
    NSString* _output;
}

@property (readonly, strong, nonatomic) NSString* targetNamespace;
@property (readwrite, strong, nonatomic) ZFGetVideoPlaybackUrlHttpPostIn* input;
@property (readwrite, strong, nonatomic) NSString* output;
@property (readonly, strong, nonatomic) NSString* location;
@property (readonly, strong, nonatomic) NSString* operationName;
+ (ZFApiHttpPostGetVideoPlaybackUrl*) apiHttpPostGetVideoPlaybackUrl;
@end
