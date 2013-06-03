// 
// ZFGetPopularSetsResponse.m
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
#import "FLObjectDescriber.h"
#import "ZFGetPopularSetsResponse.h"
#import "ZFPhotoSet.h"

@implementation ZFGetPopularSetsResponse

#if FL_MRC
- (void) dealloc {
    [_getPopularSetsResult release];
    [super dealloc];
}
#endif
+ (void) didRegisterObjectDescriber:(FLObjectDescriber*) describer {
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"PhotoSet" propertyClass:[ZFPhotoSet class]] forContainerProperty:@"getPopularSetsResult"];
}
+ (ZFGetPopularSetsResponse*) getPopularSetsResponse {
    return FLAutorelease([[[self class] alloc] init]);
}
@synthesize getPopularSetsResult = _getPopularSetsResult;

@end
