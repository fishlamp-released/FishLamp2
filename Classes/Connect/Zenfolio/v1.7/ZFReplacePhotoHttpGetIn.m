// 
// ZFReplacePhotoHttpGetIn.m
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

#import "ZFReplacePhotoHttpGetIn.h"
#import "FLModelObject.h"
@implementation ZFReplacePhotoHttpGetIn
@synthesize replacedId = _replacedId;
@synthesize originalId = _originalId;
+ (ZFReplacePhotoHttpGetIn*) replacePhotoHttpGetIn {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [_replacedId release];
    [_originalId release];
    [super dealloc];
}
#endif
@end