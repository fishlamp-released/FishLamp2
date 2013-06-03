// 
// ZFMessage.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/2/13 4:12 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 


#import "FLModelObject.h"
#import "ZFMessage.h"

@implementation ZFMessage

@synthesize body = _body;
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
@synthesize index = _index;
@synthesize isPrivate = _isPrivate;
@synthesize mailboxId = _mailboxId;
+ (ZFMessage*) message {
    return FLAutorelease([[[self class] alloc] init]);
}
@synthesize postedOn = _postedOn;
@synthesize posterEmail = _posterEmail;
@synthesize posterLoginNane = _posterLoginNane;
@synthesize posterName = _posterName;
@synthesize posterUrl = _posterUrl;

@end
