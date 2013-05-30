// 
// ZFApiSoapKeyringGetUnlockedRealms.m
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

#import "ZFApiSoapKeyringGetUnlockedRealms.h"
#import "ZFKeyringGetUnlockedRealms.h"
#import "FLModelObject.h"
#import "FLHttpRequestDescriptor.h"
#import "ZFKeyringGetUnlockedRealmsResponse.h"
@implementation ZFApiSoapKeyringGetUnlockedRealms
@synthesize output = _output;
-(NSString*) targetNamespace {
    return @"http://www.zenfolio.com/api/1.7";
}
@synthesize input = _input;
-(NSString*) soapAction {
    return @"http://www.zenfolio.com/api/1.7/KeyringGetUnlockedRealms";
}
-(NSString*) location {
    return @"http://api.zenfolio.com/api/1.7/zfapi.asmx";
}
-(NSString*) operationName {
    return @"KeyringGetUnlockedRealms";
}
+(ZFApiSoapKeyringGetUnlockedRealms*) apiSoapKeyringGetUnlockedRealms {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_input release];
    [_output release];
    [super dealloc];
}
#endif
@end
