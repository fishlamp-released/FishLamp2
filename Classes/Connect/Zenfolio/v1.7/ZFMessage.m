// 
// ZFMessage.m
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

#import "ZFMessage.h"
#import "FLModelObject.h"
@implementation ZFMessage
@synthesize body = _body;
@synthesize posterName = _posterName;
@synthesize postedOn = _postedOn;
@synthesize mailboxId = _mailboxId;
@synthesize posterUrl = _posterUrl;
@synthesize isPrivate = _isPrivate;
@synthesize posterEmail = _posterEmail;
@synthesize posterLoginNane = _posterLoginNane;
@synthesize index = _index;
+ (ZFMessage*) message {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [_body release];
    [_posterName release];
    [_postedOn release];
    [_mailboxId release];
    [_posterUrl release];
    [_posterEmail release];
    [_posterLoginNane release];
    [super dealloc];
}
#endif
@end