// 
// ZFApiHttpGetCreateVideoFromUrl.m
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

#import "ZFApiHttpGetCreateVideoFromUrl.h"
#import "FLModelObject.h"
#import "FLHttpRequestDescriptor.h"
#import "ZFCreateVideoFromUrlHttpGetIn.h"
@implementation ZFApiHttpGetCreateVideoFromUrl
- (NSString*) targetNamespace {
    return @"http://www.zenfolio.com/api/1.7";
}
@synthesize input = _input;
@synthesize output = _output;
- (NSString*) location {
    return @"http:/api.zenfolio.com/api/1.7/zfapi.asmx/CreateVideoFromUrl";
}
- (NSString*) operationName {
    return @"CreateVideoFromUrl";
}
+ (ZFApiHttpGetCreateVideoFromUrl*) apiHttpGetCreateVideoFromUrl {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [_input release];
    [super dealloc];
}
#endif
@end
