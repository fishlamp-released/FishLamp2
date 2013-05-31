// 
// ZFMessageUpdater.m
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

#import "ZFMessageUpdater.h"
#import "FLModelObject.h"
@implementation ZFMessageUpdater
@synthesize posterName = _posterName;
@synthesize body = _body;
@synthesize isPrivate = _isPrivate;
@synthesize posterUrl = _posterUrl;
@synthesize posterEmail = _posterEmail;
+ (ZFMessageUpdater*) messageUpdater {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [_posterName release];
    [_body release];
    [_posterUrl release];
    [_posterEmail release];
    [super dealloc];
}
#endif
@end