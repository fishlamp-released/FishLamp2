// 
// ZFFile.m
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

#import "ZFFile.h"
#import "FLModelObject.h"
@implementation ZFFile
@synthesize height = _height;
@synthesize urlCore = _urlCore;
@synthesize sequence = _sequence;
@synthesize id = _id;
@synthesize mimeType = _mimeType;
@synthesize width = _width;
@synthesize urlHost = _urlHost;
+ (ZFFile*) file {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [_urlCore release];
    [_sequence release];
    [_mimeType release];
    [_urlHost release];
    [super dealloc];
}
#endif
@end
