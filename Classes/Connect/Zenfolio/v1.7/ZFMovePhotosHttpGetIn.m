// 
// ZFMovePhotosHttpGetIn.m
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


#import "FLObjectDescriber.h"
#import "ZFMovePhotosHttpGetIn.h"
#import "FLModelObject.h"

@implementation ZFMovePhotosHttpGetIn

#if FL_MRC
- (void) dealloc {
    [_srcSetId release];
    [_destSetId release];
    [_photoIds release];
    [super dealloc];
}
#endif
@synthesize destSetId = _destSetId;
+ (void) didRegisterObjectDescriber:(FLObjectDescriber*) describer {
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"String" propertyClass:[NSString class]] forContainerProperty:@"photoIds"];
}
+ (ZFMovePhotosHttpGetIn*) movePhotosHttpGetIn {
    return FLAutorelease([[[self class] alloc] init]);
}
@synthesize photoIds = _photoIds;
@synthesize srcSetId = _srcSetId;

@end
