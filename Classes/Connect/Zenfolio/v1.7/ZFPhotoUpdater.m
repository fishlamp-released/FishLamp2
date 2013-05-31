// 
// ZFPhotoUpdater.m
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

#import "ZFPhotoUpdater.h"
#import "FLModelObject.h"
#import "FLObjectDescriber.h"
@implementation ZFPhotoUpdater
@synthesize fileName = _fileName;
@synthesize title = _title;
@synthesize caption = _caption;
@synthesize keywords = _keywords;
@synthesize categories = _categories;
@synthesize copyright = _copyright;
+ (void) didRegisterObjectDescriber:(FLObjectDescriber*) describer {
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"Keyword" propertyClass:[NSString class]] forContainerProperty:@"keywords"];
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"Category" propertyClass:[NSNumber class]] forContainerProperty:@"categories"];
}
+ (ZFPhotoUpdater*) photoUpdater {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [_fileName release];
    [_title release];
    [_caption release];
    [_keywords release];
    [_categories release];
    [_copyright release];
    [super dealloc];
}
#endif
@end