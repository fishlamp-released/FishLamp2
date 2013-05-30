// 
// ZFApiHttpGetLoadPrivateProfile.h
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
#import "FLHttpRequestDescriptor.h"
@class ZFLoadPrivateProfileHttpGetIn;
@class ZFUser;
@interface ZFApiHttpGetLoadPrivateProfile : FLModelObject<FLHttpRequestDescriptor> {
@private
    ZFLoadPrivateProfileHttpGetIn* _input;
    ZFUser* _output;
}

@property (readonly, strong, nonatomic) NSString* targetNamespace;
@property (readwrite, strong, nonatomic) ZFLoadPrivateProfileHttpGetIn* input;
@property (readwrite, strong, nonatomic) ZFUser* output;
@property (readonly, strong, nonatomic) NSString* location;
@property (readonly, strong, nonatomic) NSString* operationName;
+(ZFApiHttpGetLoadPrivateProfile*) apiHttpGetLoadPrivateProfile;
@end
