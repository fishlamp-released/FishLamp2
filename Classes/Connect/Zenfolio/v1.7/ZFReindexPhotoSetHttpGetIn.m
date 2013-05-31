// 
// ZFReindexPhotoSetHttpGetIn.m
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

#import "ZFReindexPhotoSetHttpGetIn.h"
#import "FLModelObject.h"
#import "FLObjectDescriber.h"
@implementation ZFReindexPhotoSetHttpGetIn
@synthesize mapping = _mapping;
@synthesize photoSetId = _photoSetId;
@synthesize startIndex = _startIndex;
+ (void) didRegisterObjectDescriber:(FLObjectDescriber*) describer {
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"String" propertyClass:[NSString class]] forContainerProperty:@"mapping"];
}
+ (ZFReindexPhotoSetHttpGetIn*) reindexPhotoSetHttpGetIn {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [_mapping release];
    [_photoSetId release];
    [_startIndex release];
    [super dealloc];
}
#endif
@end
