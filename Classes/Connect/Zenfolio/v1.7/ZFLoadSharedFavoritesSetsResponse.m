// 
// ZFLoadSharedFavoritesSetsResponse.m
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

#import "ZFLoadSharedFavoritesSetsResponse.h"
#import "FLModelObject.h"
#import "FLObjectDescriber.h"
#import "ZFFavoritesSet.h"
@implementation ZFLoadSharedFavoritesSetsResponse
@synthesize loadSharedFavoritesSetsResult = _loadSharedFavoritesSetsResult;
+ (void) didRegisterObjectDescriber:(FLObjectDescriber*) describer {
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"FavoritesSet" propertyClass:[ZFFavoritesSet class]] forContainerProperty:@"loadSharedFavoritesSetsResult"];
}
+ (ZFLoadSharedFavoritesSetsResponse*) loadSharedFavoritesSetsResponse {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [_loadSharedFavoritesSetsResult release];
    [super dealloc];
}
#endif
@end
