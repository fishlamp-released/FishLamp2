// 
// ZFGetCategoriesResponse.m
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


#import "ZFCategory.h"
#import "FLModelObject.h"
#import "ZFGetCategoriesResponse.h"
#import "FLObjectDescriber.h"

@implementation ZFGetCategoriesResponse

#if FL_MRC
- (void) dealloc {
    [_getCategoriesResult release];
    [super dealloc];
}
#endif
+ (void) didRegisterObjectDescriber:(FLObjectDescriber*) describer {
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"Category" propertyClass:[ZFCategory class]] forContainerProperty:@"getCategoriesResult"];
}
+ (ZFGetCategoriesResponse*) getCategoriesResponse {
    return FLAutorelease([[[self class] alloc] init]);
}
@synthesize getCategoriesResult = _getCategoriesResult;

@end
