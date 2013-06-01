// 
// ZFApiHttpGetShareFavoritesSet.h
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
@class ZFShareFavoritesSetHttpGetIn;
#import "FLHttpRequestDescriptor.h"
@class ZFShareFavoritesSetHttpGetOut;
@interface ZFApiHttpGetShareFavoritesSet : FLModelObject<FLHttpRequestDescriptor> {
@private
    ZFShareFavoritesSetHttpGetIn* _input;
    ZFShareFavoritesSetHttpGetOut* _output;
}

@property (readonly, strong, nonatomic) NSString* targetNamespace;
@property (readwrite, strong, nonatomic) ZFShareFavoritesSetHttpGetIn* input;
@property (readwrite, strong, nonatomic) ZFShareFavoritesSetHttpGetOut* output;
@property (readonly, strong, nonatomic) NSString* location;
@property (readonly, strong, nonatomic) NSString* operationName;
+ (ZFApiHttpGetShareFavoritesSet*) apiHttpGetShareFavoritesSet;
@end
