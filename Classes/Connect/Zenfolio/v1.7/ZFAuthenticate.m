// 
// ZFAuthenticate.m
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

#import "ZFAuthenticate.h"
#import "FLModelObject.h"
@implementation ZFAuthenticate
@synthesize challenge = _challenge;
@synthesize proof = _proof;
+(ZFAuthenticate*) authenticate {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_challenge release];
    [_proof release];
    [super dealloc];
}
#endif
@end
