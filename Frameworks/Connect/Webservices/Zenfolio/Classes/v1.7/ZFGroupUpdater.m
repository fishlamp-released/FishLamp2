// 
// ZFGroupUpdater.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/3/13 10:43 AM with PackMule (3.0.1.100)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 


#import "ZFGroupUpdater.h"
#import "FLModelObject.h"

@implementation ZFGroupUpdater

@synthesize caption = _caption;
@synthesize customReference = _customReference;
#if FL_MRC
- (void) dealloc {
    [_title release];
    [_caption release];
    [_customReference release];
    [super dealloc];
}
#endif
+ (ZFGroupUpdater*) groupUpdater {
    return FLAutorelease([[[self class] alloc] init]);
}
@synthesize title = _title;

@end
