// 
// ZFApiHttpGetLoadAccessRealm.h
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
@class ZFAccessDescriptor;
#import "FLHttpRequestDescriptor.h"
@class ZFLoadAccessRealmHttpGetIn;
@interface ZFApiHttpGetLoadAccessRealm : FLModelObject<FLHttpRequestDescriptor> {
@private
    ZFLoadAccessRealmHttpGetIn* _input;
    ZFAccessDescriptor* _output;
}

@property (readonly, strong, nonatomic) NSString* targetNamespace;
@property (readwrite, strong, nonatomic) ZFLoadAccessRealmHttpGetIn* input;
@property (readwrite, strong, nonatomic) ZFAccessDescriptor* output;
@property (readonly, strong, nonatomic) NSString* location;
@property (readonly, strong, nonatomic) NSString* operationName;
+ (ZFApiHttpGetLoadAccessRealm*) apiHttpGetLoadAccessRealm;
@end
