// 
// ZFResolveReference.m
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

#import "ZFResolveReference.h"
#import "FLModelObject.h"
@implementation ZFResolveReference
@synthesize loginName = _loginName;
@synthesize reference = _reference;
+(ZFResolveReference*) resolveReference {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_loginName release];
    [_reference release];
    [super dealloc];
}
#endif
@end
