// 
// ZFApiHttpGetLoadGroup.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/30/13 4:42 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLModelObject.h"
@class ZFLoadGroupHttpGetIn;
#import "FLHttpRequestDescriptor.h"
@class ZFGroup;
@interface ZFApiHttpGetLoadGroup : FLModelObject<FLHttpRequestDescriptor> {
@private
    ZFLoadGroupHttpGetIn* _input;
    ZFGroup* _output;
}

@property (readonly, strong, nonatomic) NSString* targetNamespace;
@property (readwrite, strong, nonatomic) ZFLoadGroupHttpGetIn* input;
@property (readwrite, strong, nonatomic) ZFGroup* output;
@property (readonly, strong, nonatomic) NSString* location;
@property (readonly, strong, nonatomic) NSString* operationName;
+(ZFApiHttpGetLoadGroup*) apiHttpGetLoadGroup;
@end
