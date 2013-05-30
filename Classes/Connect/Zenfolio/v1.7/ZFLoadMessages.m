// 
// ZFLoadMessages.m
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

#import "ZFLoadMessages.h"
#import "FLModelObject.h"
@implementation ZFLoadMessages
@synthesize mailboxId = _mailboxId;
@synthesize includeDeleted = _includeDeleted;
@synthesize postedSince = _postedSince;
+(ZFLoadMessages*) loadMessages {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_mailboxId release];
    [_postedSince release];
    [super dealloc];
}
#endif
@end
